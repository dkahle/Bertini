#' Compute a Variety
#'
#' The variety of a collection of multivariate polynomials is the collection of
#' points at which those polynomials are (simultaneously) equal to 0.
#' \code{variety} uses Bertini to find this set.
#'
#' @param mpolyList Bertini code as either a character string or function; see
#'   examples
#' @param varorder variable order (see examples)
#' @param ... stuff to pass to bertini
#' @return an object of class bertini
#' @export
#' @examples
#'
#' if (has_bertini()) {
#'
#'
#' polys <- mp(c(
#'   "x^2 - y^2 - z^2 - .5",
#'   "x^2 + y^2 + z^2 - 9",
#'   ".25 x^2 + .25 y^2 - z^2"
#' ))
#' variety(polys)
#'
#' # algebraic solution :
#' c(sqrt(19)/2, 7/(2*sqrt(5)), 3/sqrt(5)) # +/- each ordinate
#'
#'
#'
#' # character vectors can be taken in; they're passed to mp
#' variety(c("y - x^2", "y - x - 2"))
#'
#'
#'
#' # an example of how varieties are invariant to the
#' # the generators of the ideal
#' variety(c("2 x^2 + 3 y^2 - 11", "x^2 - y^2 - 3"))
#'
#'
#' #
#' variety(c("y^2 - 1", "x^2 - 4"))
#' variety(c("x^2 - 4", "y^2 - 1"))
#'
#'
#'
#' # variable order is by default equal to vars(mpolyList)
#' # (this finds the zeros of y = x^2 - 1)
#' variety(c("y", "y - x^2 + 1")) # y, x
#' vars(mp(c("y", "y - x^2 + 1")))
#' variety(c("y", "y - x^2 + 1"), c("x", "y")) # x, y
#'
#'
#'
#' # complex solutions
#' variety("x^2 + 1")
#' variety(c("x^2 + 1 + y", "y"))
#'
#'
#' # multiplicities
#' variety("x^2")
#' variety(c("2 x^2 + 1 + y", "y + 1"))
#' variety(c("x^3 - x^2 y", "y + 2"))
#'
#'
#' #
#' p <- mp(c("2 x  -  2  -  3 x^2 l  -  2 x l",
#'   "2 y  -  2  +  2 l y",
#'   "y^2  -  x^3  -  x^2"))
#' variety(p)
#'
#' }
#'
variety <- function(mpolyList, varorder, ...){

  if(is.character(mpolyList)) mpolyList <- mp(mpolyList)
  if(is.mpoly(mpolyList)) mpolyList <- structure(list(mpolyList), class = "mpolyList")
  stopifnot(is.mpolyList(mpolyList))


  # sort out variables
  vars <- vars(mpolyList)

  if(!missing(varorder) && !all(sort(vars) == sort(varorder))) stop(
    "If varorder is provided, it must contain all of the variables.",
    call. = FALSE
  )

  if(!missing(varorder)) vars <- varorder


  # format code
  fun_names <- str_c("f", 1:length(mpolyList))
  funs <- print(mpolyList, stars = TRUE, silent = TRUE)
  funs <- str_replace_all(funs, "  ", " ")
  funs <- str_replace_all(funs, "\\*\\*", "^")

  # glue code together
  code <- glue(
    "INPUT

    variable_group {paste(vars, collapse = ', ')};
    function {paste(fun_names, collapse = ', ')};
    {paste(fun_names, str_c(funs, ';'), sep = ' = ', collapse = '\n')}

    END;"
  )

  bertini(code, ...)
}
