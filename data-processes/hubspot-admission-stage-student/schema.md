## Input schema (expected)
Required (post-normalization): 
- first_name
- last_name
- home_email
- msu_email_addr
- majr_code
- degc_code

Optional:
- phone
- cum_gpa
- id

## Output schema (HubSpot import)
- firstname
- lastname
- email (match key)
- school_email
- program_interested_in
- phone
- cum_gpa
- student_id
- admission_stage (constant = "Student")

- 
