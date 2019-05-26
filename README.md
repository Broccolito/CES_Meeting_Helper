# Meeting Scheduler
Meeting Scheduler is an integrated web application for meeting scheduling and project management.

## Getting Started

In order to work on this project, you should have R on your computer and Rstudio, as a powerful IDE, is strongly recommended.

Install R:
```bash
sudo apt-get update
sudo apt-get install r-base
```

Install Rstudio:
* [Rstudio](https://www.r-project.org/) - Download Rstudio from here.

### Prerequisites

Packages in R that you need prior to working on this project

```r
library(shiny)
library(bsplus)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(shinyWidgets)
library(shinyAce)
library(dplyr)
library(DT)
library(glue)
library(readr)
library(DBI)
library(dplyr)
library(dbplyr)
library(RSQLite)
library(stringr)
```
<br>
If some of the packages are not installed yet, install using:

```r
if(!require("package_name")){
  install.packages("package_name")
  library("package_name")
}
```

## Built With

* [R](https://www.r-project.org/) - The data Analysis tool used 
* [shiny](https://shiny.rstudio.com/) - A web framework using R

## Contributing and deploy

The application is currently at version 1.1 deployed on shiny.io
<br>
[Meeting Scheduler](https://wanjun-gu.shinyapps.io/Meeting_Scheduler/) - Shiny.io deploy site link


## Authors

* **Wanjun Gu** - *Initial work* - [Broccolito](https://github.com/Broccolito)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

