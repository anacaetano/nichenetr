% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_model_ligand_prediction.R
\name{convert_settings_tf_prediction}
\alias{convert_settings_tf_prediction}
\title{Convert settings to correct settings format for TF prediction.}
\usage{
convert_settings_tf_prediction(settings, all_tfs, single = TRUE)
}
\arguments{
\item{settings}{A list of lists. Eeach sublist contains the following elements: .$name: name of the setting; .$from: name(s) of the tf(s) active in the setting of interest; .$response: the observed target response: indicate for a gene whether it was a target or not in the setting of interest.}

\item{all_tfs}{A character vector of possible tfs that will be considered for the tf activity state prediction.}

\item{single}{TRUE if feature importance scores for tfs will be calculated by looking at ligans individually. FALSE if the goal is to calculate the feature importance scores via sophisticated classification algorithms like random forest.}
}
\value{
A list with following elements: $name, $tf: name of active tf(s) (only if validation is TRUE), $from (tf(s) that will be tested for activity prediction), $response
}
\description{
\code{convert_settings_tf_prediction} Converts settings to correct settings format for TF activity prediction. In this prediction problem, TFs (out of a set of possibly active TFs) will be ranked based on feature importance scores. The format can be made suited for applications in which TFs need to be scored based on their possible upstream activity: 3) by calculating individual feature importane scores or 4) feature importance based on models with embedded feature importance determination. Remark that upstream regulator analysis for TFs here is experimental and was not thoroughly validated in the study accompanying this package.
}
\examples{
settings = lapply(expression_settings_validation[1:5],convert_expression_settings_evaluation)
settings_tf_pred = convert_settings_tf_prediction(settings, all_tfs = c("SMAD1","STAT1","RELA"), single = TRUE)
# show how this function can be used to predict activities of TFs
weighted_networks = construct_weighted_networks(lr_network, sig_network, gr_network, source_weights_df)
tf_target = construct_tf_target_matrix(weighted_networks, tfs_as_cols = TRUE, standalone_output = TRUE)
tf_importances = dplyr::bind_rows(lapply(settings_tf_pred,get_single_ligand_importances,tf_target,known = FALSE))
print(head(tf_importances))

}
