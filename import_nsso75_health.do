*==============================================================================
* NSS 75th Round (July 2017 - June 2018), Schedule 25.0: Social Consumption: Health
* Converts the 13 raw fixed-width text files into labelled Stata datasets.
*
* Usage:
*   1. Put the raw files from MoSPI (R75250L01.TXT ... R75250L13.TXT) in raw/
*   2. Set the working directory to this repository's folder, e.g.
*        cd "C:/Users/you/nsso-75-health-stata"
*   3. Run:  do import_nsso75_health.do
*
* Output: output/nsso75_health_level01.dta ... level13.dta
*==============================================================================

version 14
clear all
set more off

capture mkdir "output"

forvalues L = 1/13 {
    local l : display %02.0f `L'
    display as text _n "Importing level `l' ..."

    clear
    quietly infix using "dct/level`l'.dct", using("raw/R75250L`l'.TXT")
    quietly do "labels/level`l'.do"

    * Household identifier (common primary key per MoSPI README):
    * FSU serial no. + segment no. + second-stage stratum + household no.
    gen str9 hhid = c2 + c14 + c15 + c16
    label variable hhid "Household ID (FSU + segment + SSS + hhld no.)"

    * Final weight for sub-sample-combined estimates (MoSPI README, item 8)
    gen double wgt = cond(nss == nsc, mlt/100, mlt/200)
    label variable wgt "Final weight, sub-sample combined"

    compress
    save "output/nsso75_health_level`l'.dta", replace
    display as result "  saved output/nsso75_health_level`l'.dta (" _N " records)"
}
