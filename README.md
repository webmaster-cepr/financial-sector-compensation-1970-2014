# README

## WHAT

These scripts use data from the Bureau of Economic Analysis to produce graphics showing the change in compensation for financial sector employees from 1970-2014.

## WHAT'S INSIDE

* data/
  * National Income and Product Accounts Tables, Section 6, Tables 6.2B, 6.2C, 6.2D
    * 1970-1987.csv
    * 1988-1997.csv
    * 1998-2014.csv
  * National Income and Product Accounts Tables, Section 1, Table 1.1.5
    * gdp-1970-2014.csv
* raw/
  * animate.R
    * Top-level script, calls exploratory.R and othersectors.R. Produces .gif.
  * cleandata.R
    * Reads in and cleans data, called by exploratory.R.
  * exploratory.R
    * some exploratory graphs and transformations on variables.
  * othersectors.R
    * takes data from cleandata.R and excludes financial sector. Results in dataframe with compensation from all other sectors as share of gdp, used in animate.R