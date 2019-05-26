library(shiny)
library(bsplus)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(shinyWidgets)
library(dplyr)
library(DT)
library(glue)
library(readr)
library(DBI)
library(dplyr)
library(dbplyr)
library(RSQLite)
library(stringr)

# Define several important backend function
source("helper.R")

conn <- dbConnect(RSQLite::SQLite(),"my-db.sqlite")
datatable="my_datatable"
