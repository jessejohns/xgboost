% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xgb.model.dt.tree.R
\name{xgb.model.dt.tree}
\alias{xgb.model.dt.tree}
\title{Parse boosted tree model text dump}
\usage{
xgb.model.dt.tree(feature_names = NULL, model = NULL, text = NULL,
  n_first_tree = NULL)
}
\arguments{
\item{feature_names}{names of each feature as a character vector. Can be extracted from a sparse matrix (see example). If the model already contains feature names, this argument should be \code{NULL} (default value).}

\item{model}{object created by the \code{xgb.train} function.}

\item{text}{\code{character} vector generated by the \code{xgb.dump} function. Model dump must include the gain per feature and per tree (parameter \code{with.stats = TRUE} in function \code{xgb.dump}).}

\item{n_first_tree}{limit the plot to the \code{n} first trees. If set to \code{NULL}, all trees of the model are plotted. Performance can be low depending of the size of the model.}
}
\value{
A \code{data.table} of the features used in the model with their gain, cover and few other information.
}
\description{
Parse a boosted tree model text dump and return a \code{data.table}.
}
\details{
General function to convert a text dump of tree model to a \code{data.table}. 

The purpose is to help user to explore the model and get a better understanding of it.

The columns of the \code{data.table} are:

\itemize{
\item \code{ID}: unique identifier of a node ;
 \item \code{Feature}: feature used in the tree to operate a split. When Leaf is indicated, it is the end of a branch ;
 \item \code{Split}: value of the chosen feature where is operated the split ;
 \item \code{Yes}: ID of the feature for the next node in the branch when the split condition is met ;
 \item \code{No}: ID of the feature for the next node in the branch when the split condition is not met ;
 \item \code{Missing}: ID of the feature for the next node in the branch for observation where the feature used for the split are not provided ;
 \item \code{Quality}: it's the gain related to the split in this specific node ;
 \item \code{Cover}: metric to measure the number of observation affected by the split ;
 \item \code{Tree}: ID of the tree. It is included in the main ID ;
 \item \code{Yes.Feature}, \code{No.Feature}, \code{Yes.Cover}, \code{No.Cover}, \code{Yes.Quality} and \code{No.Quality}: data related to the pointer in \code{Yes} or \code{No} column ;
}
}
\examples{
data(agaricus.train, package='xgboost')

bst <- xgboost(data = agaricus.train$data, label = agaricus.train$label, max.depth = 2, 
               eta = 1, nthread = 2, nround = 2,objective = "binary:logistic")

# agaricus.train$data@Dimnames[[2]] represents the column names of the sparse matrix.
xgb.model.dt.tree(feature_names = agaricus.train$data@Dimnames[[2]], model = bst)

}

