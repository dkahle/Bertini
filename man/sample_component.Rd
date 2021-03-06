% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample_component.R
\name{sample_component}
\alias{sample_component}
\title{Component Sampling}
\usage{
sample_component(out, dimension, component, n, dir = tempdir(), ...)
}
\arguments{
\item{out}{the output of a positive-dimension run from bertini}

\item{dimension}{the dimension of the component to be sampled from}

\item{component}{the component to be sampled from. Indexing of components
starts at 0, not 1.}

\item{n}{the number of samples to be drawn from the selected component}

\item{dir}{directory to place the files in, without an ending /}

\item{...}{additional configuration arguments to be changed}
}
\value{
a matrix of samples
}
\description{
Draw the selected number of samples from a specified component
and dimension of a numerical irreducible decomposition.
}
\examples{
if (has_bertini()) {

# see ?bertini

# run initial numerical irreducible decomposition for equation xy = 0
input <- bertini_input("x*y")
input <- modify_config(input, tracktype = 1)

out <- bertini(input, output = "pos_dim")

# 25 samples from the first one-dimensional component (complex x-axis)
sample_component(out, dimension = 1, component = 0, n = 25)
}
}
