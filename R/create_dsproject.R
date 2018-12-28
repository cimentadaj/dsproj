#' Creates a template of folders and files for the 'ideal' data science project
#'
#' @param path A path where to create the project template. Can be relative, absolute and non existent.
#'
#'
#' @details
#' The function accepts a valid path (either relative or absolute) and applies these steps:
#'
#' @details text describing parameter inputs in more detail.
#' \itemize{
#'  \item{"Folders"}{Creates folders code, data, report and misc inside \code{path}}
#'  \item{"RProjects"}{Creates an R project in \code{path}}
#'  \item{"Git"}{Initializes a Git repository in \code{path}}
#'  \item{"Documentation"}{Adds a README.Rmd for project purposes}
#'  \item{"Package dependency"}{Installs and loads \code{packrat} for package dependency management}
#'  \item{"Fresh start"}{Restarts R and opens the newly created .Rproj with packrat loaded}
#' }
#'
#' @return Nothing, it creates and edits several folders and files in \code{path}
#' @export
#'
#' @examples
#'
#' \dontrun{
#' create_dsproject()
#' }
#'
create_dsproject <- function(path) {
  stopifnot(is.character(path))

  path <- normalizePath(path, winslash = .Platform$file.sep, mustWork = FALSE)
  dirs_create <- file.path(path, c("code", "data", "report", "misc"))
  for (folder in dirs_create) dir.create(folder, recursive = TRUE)
  print_styler('Created folder ', dirs_create)


  if (!requireNamespace("rmarkdown", quietly = TRUE)) {
    print_styler("Installing rmarkdown for reporting")
    cat("\n")
    utils::install.packages("rmarkdown")
  }

  usethis::proj_set(path, force = TRUE)
  usethis::use_rstudio()

  print_styler("Created RStudio project")
  cat("\n")
  r <- git2r::init(usethis::proj_get())
  print_styler("Created git repository")

  usethis::use_git_ignore(c(".Rhistory", ".RData", ".Rproj.user"))

  # I think this adds .Rbuildignore -- exclude
  # Add a custom readme for ds projects
  usethis::use_readme_rmd(open = FALSE)

  # Add a set of preinstalled packages for every project
  print_styler("Installing packrat for package dependency")
  cat("\n")

  unloadNamespace('packrat')
  utils::install.packages("packrat")

  writeLines("packrat::on()", file.path(path, ".Rprofile"))
  initial_styler(paste0("Set packrat mode on as default in", crayon::blue(" .Rprofile")))

  print_styler("Activating packrat project")
  cat("\n")
  packrat::init(infer.dependencies = FALSE, enter = FALSE)
  rstudioapi::openProject(usethis::proj_get())

  invisible(TRUE)
}
