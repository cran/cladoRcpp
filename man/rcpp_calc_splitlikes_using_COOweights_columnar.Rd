\name{rcpp_calc_splitlikes_using_COOweights_columnar}
\alias{rcpp_calc_splitlikes_using_COOweights_columnar}
\title{Calculate the split likelihoods using \code{COO_weights_columnar}}
\usage{
  rcpp_calc_splitlikes_using_COOweights_columnar(Rcpp_leftprobs,
    Rcpp_rightprobs, COO_weights_columnar, Rsp_rowsums,
    printmat = TRUE)
}
\arguments{
  \item{Rcpp_leftprobs}{Probabilities of the states at the
  base of the left descendant branch}

  \item{Rcpp_rightprobs}{Probabilities of the states at the
  base of the right descendant branch}

  \item{COO_weights_columnar}{Transition probability matrix
  in COO-like format as 4 columns: ancestral index, left
  index, right index, conditional probability given
  ancestral states. (assuming likelihood of descendants is
  1). Indexes are 0-based.}

  \item{Rsp_rowsums}{A vector of size (numstates) giving
  the sum of the relative probabilites of each combination
  of descendant states, assuming the probabilities of the
  left- and right-states are all equal (set to 1). This is
  thus the sum of the weights, and dividing by this
  normalization vector means that the each row of the
  speciation probability matrix will sum to 1.  Default
  assumes the weights sum to 1 but this is not usually the
  case. Rsp_rowsums need only be calculated once per
  tree+model combination, stored, and then re-used for each
  node in the tree, yielding significant time savings.}

  \item{printmat}{Should the probability matrix output be
  printed to screen? (useful for debugging, but can be
  dramatically slow in R.app for some reason for even
  moderate numbers of states; perhaps overrunning the line
  length...)}
}
\value{
  \code{splitlikes} Vector of the probabilities of each
  allowed split
}
\description{
  Calculates the split likelihoods using
  \code{COO_weights_columnar}, i.e. the weights as produced
  by \code{\link{rcpp_calc_anclikes_sp_COOweights_faster}}.
}
\examples{
# For the basic logic of a probablistic cladogenesis model, see
?rcpp_calc_anclikes_sp

# For examples of running the functions, see the comparison of all functions at:
# ?cladoRcpp
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
  \code{\link{rcpp_calc_anclikes_sp}}
}

