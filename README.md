# NSS 75th Round Health (Schedule 25.0) → Stata

Turn the raw NSS 75th round health survey (July 2017 – June 2018) into 13 labelled, ready-to-analyse Stata datasets with **one command**.

The raw MoSPI release is 13 fixed-width text files plus an Excel layout sheet. Reading them by hand means typing hundreds of column positions and variable labels. This repository does that work for you.

## What you get

- `dct/` — Stata dictionaries for all 13 levels, generated directly from MoSPI's official layout file (`datalay75_250.XLS`)
- `labels/` — variable labels for every item in every level
- `import_nsso75_health.do` — imports all levels, labels them, and adds:
  - `hhid`: household identifier (FSU + segment + second-stage stratum + household no.), for merging across levels
  - `wgt`: final weight for sub-sample-combined estimates (`MLT/100` if `NSS == NSC`, else `MLT/200`, as per the MoSPI README)

## How to use

1. Download the Schedule 25.0 unit-level data from the [MoSPI microdata portal](https://microdata.gov.in) (free, registration required).
2. Copy `R75250L01.TXT` … `R75250L13.TXT` into the `raw/` folder.
3. In Stata, set the working directory to this folder and run:

```stata
cd "path/to/this/repository"
do import_nsso75_health.do
```

The labelled datasets appear in `output/` as `nsso75_health_level01.dta` … `level13.dta`.

## Levels

| Level | Block | Contents |
|---|---|---|
| 01 | 1–2 | Identification and particulars of field operations |
| 02 | 3 | Household characteristics |
| 03 | 4 | Demographic particulars of household members |
| 04 | 5 | Former household members who died in the last 365 days |
| 05 | 6 | In-patient treatment in the last 365 days |
| 06–07 | 7 | Expenses on in-patient treatment (items 1–14, 15–20) |
| 08 | 8 | Spells of ailment in the last 15 days |
| 09–10 | 9 | Expenses on treatment other than as in-patient, last 15 days (items 1–18, 19–23) |
| 11 | 10a | Economic independence and health of persons aged 60+ |
| 12 | 10b | Immunisation of children |
| 13 | 11 | Pre-natal and post-natal care (women aged 15–49 pregnant in the last 365 days) |

Check the MoSPI layout file and schedule for the exact block-to-level mapping and item definitions before analysis.

## Notes

- Identifier fields (`c1`–`c16`), fillers, blanks and NIC/NCO codes are read as strings so leading zeros are kept.
- All dictionaries were checked against the raw files: every record is 142 characters, every numeric field parses cleanly, and the level code in each record matches its file.
- Raw data is not included. Please download it from MoSPI under their terms of use.

## Author

[Piyush Kumar](https://github.com/piyushkumar-econ) — development economist working on climate, health and finance.
