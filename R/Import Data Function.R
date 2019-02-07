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

# Set logger severity threshold, defaults to high level use  (only flag warnings and errors)
#Can set log_level argument to futile.logger::TRACE for full info

  futile.logger::flog.threshold(log_level)

# This sets whereto wrtie the log to, defaults to console but can change to logging in a file

  if(log_appender != "console")
  {
    #if not the console can set to rite to a file called....
    futile.logger::flog.appender(futile.logger::appender.file(log_appender))
  }

# Checks
  futile.logger::flog.info("Creating compliance_data class. Expects a data.frame with 20 columns. Each row represents
                           a return from a unique business. MOre information on the format that is expected by this class
                           can be found by ?compliance_data().")

# Intergrity checks on incoming data
# Check the structure of the data.frame is as expected

  futile.logger::flog.info(" \n*** Running ntegrity checks on the input data.frame (x):")

  futile.logger::flog.debug("Checking x is a data.frame...")
  if (!is.data.frame(x))
  {
    futile.logger::flog.error("x must be a data.frame", x, capture = TRUE)
  }

  futile.logger::flog.debug("Checking input dataframe has the right number of columns")
  if (length(colnames(x))>20)
  {
    futile.logger::flog.error("The input dataframe should have 20 columns")
  }

  futile.logger::flog.info("...passed")

  # Statistical test using assertr, currently not implmented


  # Add column Names

  column_names= c("Reference Number", "Attachments", "Admin/ secretarial", "Managers/ senior officials", "Directors/ chief executives", "Associate Professional", "Professional", "Other", "Other (please specify)", "Total time taken to complete Hours", "Total time taken to complete Mins", "External Costs Y", "External Costs False", "Accountant/ Bookkeeper", "Other", "Other (please specify)", "Accountant/ Bookkeeper £", "Accountant/ Bookkeeper p", "Other £", "Other p")
  colnames(x) <- column_names

  # Create a column of total minutes to be used to check distrubtion and caculate median time

  x$'Total time taken to complete Hours'[is.na(x$'Total time taken to complete Hours')] <- 0
  x$'Total time taken to complete Mins'[is.na(x$'Total time taken to complete Mins')] <- 0
  x$Total_Minutes <- x$'Total time taken to complete Hours'*60 + x$'Total time taken to complete Mins'

 #plot argument allows the user to have a look at the data

  if (plot == TRUE) {
    hist(x$'Total_Minutes',
         xlab = "Minutes taken to complete survey",
         main = "Distribution of Minutes",
         col = "plum")

    abline(v= median(x$Total_Minutes), col= "deeppink", lwd = 4)

    abline(v= mean(x$Total_Minutes), col= "darkmagenta", lwd=4)

    abline(v= 2*sd(x$Total_Minutes), col = "blueviolet", lwd = 4)

    legend(x= "topright",
           legend= c("Median", "Mean", "2 Standard Deviations"),
           col = c("deeppink", "darkmagenta", "blueviolet"),
           lwd = 2)
  }

  structure(
    data.frame(x),
    class= "compliance_data"
    )

}
