# Loading libraries for this extraction of information 
library(readr)
library(dplyr)
library(stringr)

# Make safe, unique column names (no blanks, not NA); this is to avoid script breaking because there are thousands of blank columns
safe_names <- function(nm) {
  nm <- ifelse(is.na(nm) | str_trim(nm) == "", "unnamed", nm)
  nm <- nm %>%
    str_trim() %>%
    str_to_lower() %>%
    str_replace_all("[^a-z0-9]+", "_") %>%
    str_replace_all("^_|_$", "")
  make.unique(nm, sep = "_")
}

# 1) Read file (adjust path/name as needed)
raw <- read_csv('Use/the/path/on/your/computer.csv', show_col_types = FALSE)

# 2) Fix column names BEFORE any dplyr verbs
names(raw) <- safe_names(names(raw))

# 3) Build a program mapping for majr_code (edit labels if your school uses different names)
program_map <- c(
  "ACCT" = "Accounting, MS",
  "BUAD" = "Business Administration, MBA",
  "DAAV" = "Data Analytics and Visualization, MS",
  "OMBA" = "Online, Business Administration, MBA",
  "OPMG" = "Online, Project Management, MS",
  "PRMG" = "Project Management, MS",
  "HOMG" = "Hospitality Magament, MS"
)

# 4) Identify the renamed columns we care about
# Based on the file we have:
# "Msu Email Addr" -> "msu_email_addr
# "Home Email" -> "home_email"
required_cols <- c("first_name", "last_name", "home_email", "msu_email_addr", "majr_code", "degc_code")

missing <- setdiff(required_cols, names(raw))
if (length(missing) > 0) {
  stop(paste("Missing expected columns after renaming:", paste(missing, collapse = ", ")))
}

# 5) Transform into HubSpot import-ready dataset
# Match on home_email -> HubSpot Email
# Put university email into School Email property

out <- raw %>%
  mutate(
    # Clean emails (turn blanks into NA so coalesce works)
    home_email_clean = na_if(str_trim(home_email), ""),
    msu_email_clean = na_if(str_trim(msu_email_addr), ""),
    
    # Failsafe: use home email first, otherwise use MSU email for mapping
    email_for_hubspot = coalesce(home_email_clean, msu_email_clean), 
    
    majr_code = toupper(majr_code),
    degc_code = toupper(degc_code),
    program_interested_in = unname(program_map[majr_code]),
    admission_stage = "Student"
  ) %>%
  transmute(
    firstname = first_name,
    lastname = last_name,
    
    # HubSpot matching key:
    email = str_to_lower(str_trim(email_for_hubspot)),
    
    # Map to your HubSpot custom property (Always store MSU email in the School Email property)
    school_email = str_to_lower(str_trim(msu_email_clean)),
    
    # Optional useful fields
    program_interested_in = program_interested_in,
    phone = phone,
    cum_gpa = cum_gpa,
    student_id = id,
    
    # The operational update
    admission_stage = admission_stage
  ) %>%
  # MUST have SOME email after fallback
  filter(!is.na(email), email != "") %>%  # Must have a match key
  distinct(email, .keep_all = TRUE) # Prevent duplicates on import

# 6) Quick audit outputs (optional but helpful)
cat("Rows in raw:", nrow(raw), "\n")
cat("Rows after filtering missing home email and dedup:", nrow(out), "\n")
cat("Missing program mapping count:", sum(is.na(out$program_interested_in)), "\n")

# 7) Write the import file
write_csv(out, file = "hubspot_import_students_update.csv", na = "")
