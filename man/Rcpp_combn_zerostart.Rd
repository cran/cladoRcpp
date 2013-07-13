\name{Rcpp_combn_zerostart}
\alias{Rcpp_combn_zerostart}
\title{Get all the combinations of descendent state pairs, in 0-based index form}
\usage{
  Rcpp_combn_zerostart(n_to_choose_from, k_to_choose,
    maxlim = 1e+07)
}
\arguments{
  \item{n_to_choose_from}{N in N choose K}

  \item{k_to_choose}{K in N choose K}

  \item{maxlim}{To avoid memory overruns, the number of
  combinations can be no larger than \code{maxlim}
  (default: 1e+07)}
}
\value{
  \code{outarray} an integer matrix with \code{outarray}
  rows; the number of columns is the number of
  combinations.
}
\description{
  Given the number of states, this function returns all of
  the pairs of indexes corresponding to those states.
}
\details{
  The C++ version is MUCH faster than the plain-R version.
}
\examples{
Rcpp_combn_zerostart(n_to_choose_from=4, k_to_choose=2, maxlim=1e+07)
Rcpp_combn_zerostart(n_to_choose_from=4, k_to_choose=3, maxlim=1e+07)
}
\author{
  Nicholas Matzke \email{matzke@berkeley.edu}
}
\references{
  Matzke N (2012). "Founder-event speciation in BioGeoBEARS
  package dramatically improves likelihoods and alters
  parameter inference in Dispersal-Extinction-Cladogenesis
  (DEC) analyses." _Frontiers of Biogeography_, *4*(suppl.
  1), pp. 210. ISSN 1948-6596, Poster abstract published in
  the Conference Program and Abstracts of the International
  Biogeography Society 6th Biannual Meeting, Miami,
  Florida. Poster Session P10: Historical and
  Paleo-Biogeography. Poster 129B. January 11, 2013, <URL:
  \url{http://phylo.wikidot.com/matzke-2013-international-biogeography-society-poster}>.
}
\seealso{
  \code{\link{rcpp_calc_anclikes_sp}},
  \code{\link{rcpp_mult2probvect}},
  \code{\link{rcpp_convolve}}
}

