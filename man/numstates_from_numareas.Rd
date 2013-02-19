\name{numstates_from_numareas}
\alias{numstates_from_numareas}
\title{Calculate the number of states, given a certain number of areas}
\usage{
  numstates_from_numareas(numareas = 3,
    maxareas = numareas, include_null_range = FALSE)
}
\arguments{
  \item{numareas}{The number of areas in the analysis.}

  \item{maxareas}{The maximum number of areas that any
  single species/lineage can occupy.}

  \item{include_null_range}{If FALSE (default), the null
  range is not included in the count. If TRUE, the null
  range is included, adding +1 to the count of the states.}
}
\value{
  \code{nstates} Number of states
}
\description{
  This function calculates the number of discrete states
  that are needed to represent the possible combinations of
  presence and absence in a set of discrete areas.  The
  number of states is a function of the number of areas,
  and the maximum allowed range size (in number of areas)
  of a species.
}
\details{
  For example, with 3 areas (A, B, C), there are 8 possible
  states, if a null range is allowed (null, A, B, C, AB,
  BC, AC, ABC).  If the maximum range size is 2 areas, then
  there are only 7 possible states.

  The formula for the number of geographic states, based on
  the number of areas (\emph{N}), is the sum of \emph{N}
  choose \emph{k}, from \emph{k}=1 to \emph{m} (maximum
  range size) \deqn{s = \sum_{k=1}^{m}{N\choose k}}{s =
  sum(k=1...m)(N choose k)}

  This equation assumes that the null range (a species
  lives in no areas, i.e. is extinct) is not allowed. In
  the LAGRANGE program of \cite{Ree et al. (2008)}), the
  null range is included in the transition matrix, and thus
  this is one more state.  This situation is represented in
  \code{numstates_from_numareas} by setting
  \code{include_null_range=TRUE}.

  Users might manually remove states from the states list,
  if prior information indicates that some configurations
  of presence/absence in areas are impossible as geographic
  ranges for species.  If so, they should manually subtract
  from the number of states.
}
\examples{
numstates_from_numareas(numareas=3, maxareas=3, include_null_range=FALSE)
numstates_from_numareas(numareas=3, maxareas=3, include_null_range=TRUE)
numstates_from_numareas(numareas=3, maxareas=2, include_null_range=TRUE)
numstates_from_numareas(numareas=3, maxareas=1, include_null_range=TRUE)
numstates_from_numareas(numareas=7, maxareas=7, include_null_range=TRUE)
numstates_from_numareas(numareas=7, maxareas=2, include_null_range=TRUE)
numstates_from_numareas(numareas=8, maxareas=8, include_null_range=TRUE)
numstates_from_numareas(numareas=8, maxareas=2, include_null_range=TRUE)
numstates_from_numareas(numareas=20, maxareas=20, include_null_range=TRUE)
numstates_from_numareas(numareas=20, maxareas=2, include_null_range=TRUE)
numstates_from_numareas(numareas=20, maxareas=3, include_null_range=TRUE)
}
\author{
  Nicholas Matzke \email{matzke@berkeley.edu}
}
\references{
  Ree RH and Smith SA (2008). "Maximum likelihood inference
  of geographic range evolution by dispersal, local
  extinction, and cladogenesis." _Systematic Biology_,
  *57*(1), pp. 4-14. <URL:
  http://dx.doi.org/10.1080/10635150701883881>, <URL:
  http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Citation&list_uids=18253896>.

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
  \code{\link[stats]{convolve}}
}

