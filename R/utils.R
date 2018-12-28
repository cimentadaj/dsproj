initial_styler <- function(x) cat(crayon::red(crayon::green(clisymbols::symbol$tick)), x)

print_styler <- function(x, files) {
  if (!missing(files)) x <- paste0(x, crayon::blue(paste0(paste0(files, .Platform$file.sep))), "\n")
  for (i in x) initial_styler(i)
}
