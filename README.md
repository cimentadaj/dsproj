
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dsproj

The goal of dsproj is to create the ideal (opinionated) templated for a
Data Science project.

## Installation

You can install the released version of dsproj from
[Github](http://github.com/) with:

``` r
install.packages("remotes")
remotes::install_github('cimentadaj/dsproj')
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(dsproj)

project_folder <- tempdir()
create_dsproject(project_folder)
```
