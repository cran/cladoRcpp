\name{rcpp_calc_anclikes_sp_rowsums}
\alias{rcpp_calc_anclikes_sp_rowsums}
\title{Calculate the number of cladogenesis events of nonzero probability for each ancestral state}
\usage{
  rcpp_calc_anclikes_sp_rowsums(Rcpp_leftprobs,
    Rcpp_rightprobs, l, s = 1, v = 1, j = 0, y = 1,
    dmat = NULL, maxent01s = NULL, maxent01v = NULL,
    maxent01j = NULL, maxent01y = NULL,
    max_minsize_as_function_of_ancsize = NULL,
    printmat = TRUE)
}
\arguments{
  \item{Rcpp_leftprobs}{Probabilities of the states at the
  base of the left descendant branch}

  \item{Rcpp_rightprobs}{Probabilities of the states at the
  base of the right descendant branch}

  \item{l}{List of state indices (0-based)}

  \item{s}{Relative weight of sympatric "subset"
  speciation. Default \code{s=1} mimics LAGRANGE model.}

  \item{v}{Relative weight of vicariant speciation. Default
  \code{v=1} mimics LAGRANGE model.}

  \item{j}{Relative weight of "founder event
  speciation"/jump speciation. Default \code{j=0} mimics
  LAGRANGE model.}

  \item{y}{Relative weight of fully sympatric speciation
  (range-copying). Default \code{y=1} mimics LAGRANGE
  model.}

  \item{dmat}{If given, a matrix of rank numareas giving
  multipliers for the probability of each dispersal event
  between areas. Default NULL, which sets every cell of the
  \code{dmat} matrix to value 1.  Users may construct their
  own parameterized \code{dmat} (for example, making
  \code{dmat} a function of distance) for inclusion in ML
  or Bayesian analyses.}

  \item{maxent01s}{Matrix giving the relative weight of
  each possible descendant rangesize for the smaller range,
  for a given ancestral rangesize, for a subset-sympatric
  speciation event. Default is \code{NULL}, which means the
  script will set up the LAGRANGE model (one descendent
  always has range size 1).}

  \item{maxent01v}{Matrix giving the relative weight of
  each possible descendant rangesize for the smaller range,
  for a given ancestral rangesize, for a vicariance
  speciation event. Default is \code{NULL}, which means the
  script will set up the LAGRANGE model (one descendent
  always has range size 1).}

  \item{maxent01j}{Matrix giving the relative weight of
  each possible descendant rangesize for the smaller range,
  for a given ancestral rangesize, for a founder-event
  speciation event. Default is \code{NULL}, which means the
  script will set up the LAGRANGE model (one descendent
  always has range size 1).}

  \item{maxent01y}{Matrix giving the relative weight of
  each possible descendant rangesize for the smaller range,
  for a given ancestral rangesize, for a full-sympatric
  (range-copying) speciation event. Default is \code{NULL},
  which means the script will set up the LAGRANGE model
  (one descendent always has range size 1).}

  \item{max_minsize_as_function_of_ancsize}{If given, any
  state with a range larger that this value will be given a
  probability of zero (for the branch with the smaller
  rangesize).  This means that not every possible
  combination of ranges has to be checked, which can get
  very slow for large state spaces.}

  \item{printmat}{Should the probability matrix output be
  printed to screen? (useful for debugging, but can be
  dramatically slow in R.app for some reason for even
  moderate numbers of states; perhaps overrunning the line
  length...)}
}
\value{
  \code{Rsp_rowsums} A vector of size (numstates) giving
  the number of events of nonzero probability for each
  ancestral states.
}
\description{
  This function takes the list of possible states
  (\emph{l}), and the parameters of a cladogenesis model
  (\emph{s}, \emph{v}, \emph{j}, \emph{y}) (which are the
  relative weights of each of type of cladogenic range
  inheritance event) and, for each ancestral state, sums
  the weights of allowed descendant events.  Dividing the
  weights in each row, by the sum of the weights for that
  row, provides the absolute probabilities of each
  transition, conditional on the ancestral state for that
  row.
}
\details{
  The inputs \code{Rcpp_leftprobs} and
  \code{Rcpp_rightprobs} are basically irrelevant here, but
  retained for symmetry with the other functions.  In
  effect, this function is identical with
  \code{\link{rcpp_calc_anclikes_sp}} except that
  \code{Rcpp_leftprobs} and \code{Rcpp_rightprobs} are
  arrays of 1s of \code{length(l)}, i.e.
  \code{length(number_of_states)}.

  This function is no longer used in \code{BioGeoBEARS},
  but has been retained to enable easy counting of the
  number of events.  When all nonzero-probability events
  are of equal probability (e.g. as in LAGRANGE; Ree &
  Smith 2008) the function could be used for normalization,
  but it is safer to use
  \code{\link{rcpp_calc_anclikes_sp}} or one of the faster
  COO-like equivalents.
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

  Ree RH and Smith SA (2008). "Maximum likelihood inference
  of geographic range evolution by dispersal, local
  extinction, and cladogenesis." _Systematic Biology_,
  *57*(1), pp. 4-14. <URL:
  http://dx.doi.org/10.1080/10635150701883881>, <URL:
  http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Citation&list_uids=18253896>.
}
\seealso{
  \code{\link{rcpp_calc_anclikes_sp}},
  \code{\link{rcpp_calc_anclikes_sp_COOprobs}},
  \code{\link{rcpp_calc_anclikes_sp_COOweights_faster}}
}

