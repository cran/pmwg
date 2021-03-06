% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/store.R
\name{extend_sampler}
\alias{extend_sampler}
\title{Extend the main data store with empty space for new samples}
\usage{
extend_sampler(sampler, n_samples, stage)
}
\arguments{
\item{sampler}{The pmwgs object that we are adding the new samples to}

\item{n_samples}{The number of new samples to increase by}

\item{stage}{The name of the stage from which the new samples will be drawn}
}
\value{
The pmwgs object with the space for new samples added
}
\description{
Extend the main data store with empty space for new samples
}
\keyword{internal}
