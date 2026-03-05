# HubSpot: Set `admission-stage` property = Student (R data process)

## Purpose
Create an import-ready CSV that updates HubSpot contacts to identify current students by setting: 
- `admission-stage` = `Student`

The import matches contacts by **email** (home email preferred; school email as fallback).

## Why
Some contacts already have school emails (e.g., from undergrad) and email alone is not a reliable indicator of program status. This workflow uses a trusted roster/export to update the HubSpot stage consistently.

## Inputs
A roster/export CSV that includes (after column normalization):
- `first_name`
- `last_name`
- `home_email`
- `mus_email_addr`
- `majr_code`
- `degc_code`
Optional columns (script will still run if missing):
- `phone`
- `cum_gpa`
- `id`

## Outputs
A HubSpot import CSV:
- `email` (matching key)
- `admission_stage` (set to `Student`)
- plus optional fields included in the script (e.g., `school_email`, `program_interested_in`, etc.)

## How to run
1. Open `student_list.R`
2. Set `INPUT_FILE` to your local roster file path
3. Run the script
4. Upload the generated CSV to HubSpot as a **Contacts-only** import
   - Ensure HubSpot maps `email` to Email and `admission_stage` to the existing property

## Notes
- If `program_interested_in` is a dropdown in HubSpot, the program labels must match the dropdown options exactly.
- No real student data should be committed to this repository. 
