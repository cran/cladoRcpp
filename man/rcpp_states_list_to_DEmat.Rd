\name{rcpp_states_list_to_DEmat}
\alias{rcpp_states_list_to_DEmat}
\title{C++ conversion of a states list to a dispersal-extinction matrix (DEmat)}
\usage{
  rcpp_states_list_to_DEmat(areas_list, states_list, dmat,
    elist, include_null_range = TRUE, normalize_TF = TRUE,
    makeCOO_TF = FALSE, min_precision = 1e-26)
}
\arguments{
  \item{areas_list}{a list of lists of areas (numbers,
  starting with 0)}

  \item{states_list}{a list of lists of areas (numbers,
  starting with 0)}

  \item{dmat}{dispersal matrix from area to area}

  \item{elist}{a list of extinction probabilities}

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
areas_list = c("A", "B", "C")
areas_list

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
}
\author{
  Nicholas Matzke \email{matzke@berkeley.edu}
}
\references{
  \url{http://en.wikipedia.org/wiki/Sparse_matrix#Coordinate_list_.28COO.29}
}
\seealso{
  \code{\link{numstates_from_numareas}},
  \code{\link[stats]{convolve}}
}

