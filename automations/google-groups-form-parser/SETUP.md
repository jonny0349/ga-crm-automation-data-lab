# Google Groups -> Sheets Form Parser (Apps Script)

## Purposse
Converts a forwarded form (pasted from Google Groups email) into a single structured rown in a `DATA` sheet. 

## Sheet requirements
Create two tabs in Google Sheets:
- `PASTE` (staging area)
- `DATA` (output table)

### DATA headers (row 1)
Recommended columns:
- Timestamp
- Name
- Email
- Phone
- Address
- Program of Interest
- Intended start
- Message (optional)

## How to use
1. Open the Google Groups email and copy the form content (Name through Message).
2. In the Google Sheet, go to the `PASTE` tab and click cell `A2`
3. Paste the contect (it will typically populate columns A and B.
4. Run `appendFromPasteToData()` from Apps Script.
5. Confirm a new row was appended in `DATA`

## Notes
- Do not commit real PII to this repo. Use fake examples only.
- Labels may vary dependig on the form template; update the label matching in the script if needed.
