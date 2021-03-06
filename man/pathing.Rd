% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set_paths.R
\name{pathing}
\alias{pathing}
\alias{set_bertini_path}
\alias{get_bertini_path}
\alias{has_bertini}
\alias{missing_bertini_stop}
\title{Set path to bertini}
\usage{
set_bertini_path(path)

get_bertini_path()

has_bertini()

missing_bertini_stop()
}
\arguments{
\item{path}{A character string, the path to theh bertini executable}
}
\value{
A logical(1) or character(1) containing the path.
}
\description{
These are helper functions that deal with pathing to bertini and asking if it
is present. When the bertini package is loaded it attempts to find the
bertini executable by looking for an environment variable indicating where it
is, i.e. its path as specified in your .Renviron file.
}
\details{
For easiest use, you'll want to specify the path the bertini executable in
your ~/.Renviron file. It should look something like

\code{BERTINI=/Applications/latte/bin}

You can set this permanently with \code{\link[=edit_r_environ]{edit_r_environ()}}. Note that absolute
paths should be specified, not relative paths, e.g. don't use ~/path/to/exe.

You can change this for the current session using \code{\link[=set_bertini_path]{set_bertini_path()}}, which
accepts a character string or, if missing, uses \code{\link[=file.choose]{file.choose()}} to let you
interactively; you just select an arbitrary executable.
}
\examples{

has_bertini()
if (has_bertini()) get_bertini_path()


# you can set this permanently with the following. note that you'll
# need to re-start the R session afterwards or simply pass the path into
# set_bertini_path(). see below for more details on that.
if (interactive()) edit_r_environ()


# you can change this in your current session with set_bertini_path() and
if (interactive()) set_bertini_path()

if (had_bertini <- has_bertini()) old_bertini_path <- get_bertini_path()
set_bertini_path("/path/to/bertini")
get_bertini_path()

if (had_bertini) set_bertini_path(old_bertini_path)
get_bertini_path()

}
\author{
David Kahle \email{david@kahle.io}
}
