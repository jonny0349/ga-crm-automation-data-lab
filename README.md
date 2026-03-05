# GA CRM Automation Lab & Data Processes

A living repository for automation scripts, lightweight data pipelines, and analytics/viz work created during my Graduate Assistanship. The goal is to reduce manual CRM/admin work, improve data quality, and build repeatable processes that can be documented, reused, and improved over time. 

This repo will be updated continuously as new tasks/projects come up.

## Why this repo exists

Graduate assistant work often includes "one-off" fixes that quietly save hours (data cleanup, imports, segmentation support, reporting, etc.). This repo is meant to: 
- **Capture repeatable solutions** (so we don't reinvent them later)
- **Document workflows**: step-by-step for easy handoff
- **Support data quality** and reduce manual errors
- **Create a portfolio of practical ops + analytics work** (CRM + data processes).

---

## What you'll find here (and what's coming)
This repo will evolve, but uploads will generally fall into these categories: 

### 1) CRM automations (HubSpot + intake workflows)
Examples: 
- Parsing forwarded inquiry forms into structured rows for importing
- Import-ready data cleaning routines
- List/segmentation support logic
- Process documentation for common CRM workflows

### 2) Data Processes (cleaning, transformation, QA)
Examples: 
- Deduping logic and validation checks
- Standardizing categorical fields (e.g., program names / start terms)
- Simple pipelines from "raw -> clean -> export/import"
- Reproducible templates (Sheets, CSV schemas, etc.)

### 3) Analytics and visualization
Examples: 
- Small reporting datasets prepared for dashboards
- Tableau / Power BI/ Excel visual workflows (screenshots + notes)
- Python/R notebooks for analysis when useful or javascript code

----

## Current project: Google Groups -> Sheets Parser (Forwarded inquiry forms)
**Problem**: inquiry forms arrive via Google Groups as forwarded emails, often in a label/value format.
**Solution**: a Google Sheets + Apps Script workflow that converts each inquiry into a single structured row, ready for review and CRM import.

What it does: 
- Paste the forwarded form into a staging tab
- Run the script
- Appends a clean row to a `DATA` sheet with standardized columns

**Notes**:
- This repo only contains **generic code and documentation**.
- No institutional or personal data is included here.

---

##Data privacy & security

This repo is intended for reusable tooling and documentation only. 

- No real student/prospect PII(names, emails, phone numbers, addresses) should be committed.
- Use the `data/sample-datasets/` folder for **fake/demo** inputs only.
- If screenshots are added, they should be **redacted**.

---

##Repo Organization (will evolve)

A suggested structure as this grows:

- `automations/` - Apps Script and CRM workflow utilities
- `data/` - sample datasets (fake), schemas, cleaning templates
- `viz/` - dashboard notes, screenshots (redacted), examples
- `docs/` - workflow diagrams, setup guides, references

---

## How updates will happen

This is a "work-in-progress" repo. As new tasks come up, I'll add:
- a short description of the problem
- the solution approach
- setup steps / dependencies
- sample inputs/outputs (fake data only)

---

## License
TBD (Will add once the repo structure stabilizes). 
