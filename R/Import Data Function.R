#' @title Create minimal tidy data set for caculating compliance cost
#'
#' @description compliance_data is the class used for preforming the analysis
#'
#' @details The function reads in a dataframe containg the compliance review and converts to a custom class compliance_data.
#' This quality checks the data and creates the minimal tidy data set needed for caculating the compliance cost.
#'
#' @details The compliance review contains 4 varibles but spread over mutiple columns in a messy excel sheet. This function
#' checks and tidyies.
#'
#' @param x The input data frame, see details.
#'
#' @param log_level The severity level at which log messages are written from least to most serious: TRACE, DEBUG, INFO,
#' ERROR, FATAL. Default level is info. See \code{?flog.threshold()} for additional details.
#'
#' @param log_appender Defaults to writing the log to "console", or can procide a character string to specify a filename
#' to write to. For additional details \code{?futile.logger::appender.tee()}
#'
#' @param plot If True a plot is drawn for visual inspection.
#'
#' @return Return compliance_data class object if instantiated correctly, otherwise nothing.
#'
#' @example
#'
#' name_of_your_data_frame <- compliance_data(data.frame)
#'
#' @export

compliance_data <- function(x, log_level= futile.logger::WARN, log_appender= "console", plot= FALSE)
{











}
