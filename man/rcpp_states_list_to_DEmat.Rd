\name{rcpp_states_list_to_DEmat}
\alias{rcpp_states_list_to_DEmat}
\title{C++ conversion of a states list to a dispersal-extinction matrix (DEmat)}
\usage{
  rcpp_states_list_to_DEmat(areas_list, states_list, dmat,
    elist, amat = NULL, include_null_range = TRUE,
    normalize_TF = TRUE, makeCOO_TF = FALSE,
    min_precision = 1e-26)
}
\arguments{
  \item{areas_list}{a list of lists of areas (numbers,
  starting with 0)}

  \item{states_list}{a list of lists of areas (numbers,
  starting with 0)}

  \item{dmat}{dispersal matrix from area to area}

  \item{elist}{a list of extinction probabilities}

  \item{amat}{A matrix specifying the probability of
  instantaneous transition from one area to another (as in
  standard character rate matrices).}

  \item{include_null_range}{include the null () range (NA)
  in the matrix (LAGRANGE default=TRUE)}

  \item{normalize_TF}{should the columns be -1 * rowsums?}

  \item{makeCOO_TF}{should the returned matrix be COO or
  standard dense (the latter is default).}

  \item{min_precision}{what is the effective minimum size
  for 0}
}
\value{
  dmat (a standard Q matrix)
}
\description{
  This function takes a list of states/ranges, a matrix
  describing relative dispersal probability (dmat) for each
  pair of areas, and a list describing the local
  extirpation probability for each area (elist), and
  calculates a transition matrix Qmat accordingly.
}
\details{
  The size of the matrix will expand dramatically with the
  number of areas.  See
  \code{\link{numstates_from_numareas}} for the
  calculation.

  Above 7 or so areas, making \code{Qmat} a COO-formatted
  matrix (COO=Coordinate list, see wikipedia,
  \url{http://en.wikipedia.org/wiki/Sparse_matrix#Coordinate_list_.28COO.29}
  ) which can then be used in
  \code{\link[rexpokit]{rexpokit}}'s sparse-matrix
  algorithms, should be more efficient. (Sparse matrices
  are matrices made of mostly 0s.)
}
\examples{
# Specify the areas
areas_list_txt = c("A", "B", "C")
areas_list_txt

# rcpp_states_list_to_DEmat function requires a 0-based list of areas
areas_list = seq(0, length(areas_list_txt)-1, 1)
areas_list

\dontrun{

# Calculate the list of 0-based indices for each possible
#geographic range, i.e. each combination of areas
states_list = rcpp_areas_list_to_states_list(areas=areas_list, maxareas=3,
include_null_range=FALSE)
states_list
states_list = rcpp_areas_list_to_states_list(areas=areas_list, maxareas=3,
include_null_range=TRUE)
states_list
states_list = rcpp_areas_list_to_states_list(areas=areas_list, maxareas=2,
include_null_range=TRUE)
states_list
states_list = rcpp_areas_list_to_states_list(areas=areas_list, maxareas=1,
include_null_range=TRUE)
states_list

# Hard-code the along-branch dispersal and extinction rates
d = 0.2
e = 0.1

# Calculate the dispersal weights matrix and the extinction weights matrix
# Equal dispersal in all directions (unconstrained)
areas = areas_list
distances_mat = matrix(1, nrow=length(areas), ncol=length(areas))
dmat = matrix(d, nrow=length(areas), ncol=length(areas))
dmat

# Equal extinction probability for all areas
elist = rep(e, length(areas))
elist

# Set up the instantaneous rate matrix (Q matrix, Qmat)
# DON'T force a sparse-style (COO-formatted) matrix here
force_sparse = FALSE
Qmat = rcpp_states_list_to_DEmat(areas_list, states_list, dmat, elist,
include_null_range=TRUE, normalize_TF=TRUE, makeCOO_TF=force_sparse)
Qmat

# DO force a sparse-style (COO-formatted) matrix here
force_sparse = TRUE
Qmat = rcpp_states_list_to_DEmat(areas_list, states_list, dmat, elist,
include_null_range=TRUE, normalize_TF=TRUE, makeCOO_TF=force_sparse)
Qmat


# Repeat with an amat
amat = dmat
amat[is.numeric(amat)] = 0.33

# Set up the instantaneous rate matrix (Q matrix, Qmat)
# DON'T force a sparse-style (COO-formatted) matrix here
force_sparse = FALSE
Qmat = rcpp_states_list_to_DEmat(areas_list, states_list, dmat, elist, amat,
include_null_range=TRUE, normalize_TF=TRUE, makeCOO_TF=force_sparse)
Qmat

# DO force a sparse-style (COO-formatted) matrix here
force_sparse = TRUE
Qmat = rcpp_states_list_to_DEmat(areas_list, states_list, dmat, elist, amat,
include_null_range=TRUE, normalize_TF=TRUE, makeCOO_TF=force_sparse)
Qmat
}
}
\author{
  Nicholas Matzke \email{matzke@berkeley.edu}
}
\references{
  \url{http://en.wikipedia.org/wiki/Sparse_matrix#Coordinate_list_.28COO.29}

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
  \code{\link{numstates_from_numareas}},
  \code{\link[stats]{convolve}}
}

