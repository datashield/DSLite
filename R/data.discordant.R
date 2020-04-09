#' DataSHIELD login data for the DISCORDANT simulated datasets
#'
#' DataSHIELD login data.frame for connecting with DISCORDANT datasets which purpose is to test
#' datasets that are NOT harmonized.
#'
#' | **Field**          | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | server             | Server/study name                | char     ||
#' | url                | Server/study URL                 | char     | DSLiteServer instance symbol name |
#' | user               | User name                        | char     | Always empty for DSLiteServer |
#' | password           | User password                    | char     | Always empty for DSLiteServer |
#' | table              | Table unique name                | char     | As registered in the DSLiteServer |
#' | options            | Connection options               | char     | Always empty for DSLiteServer |
#' | driver             | Connection driver                | char     | DSLiteServer |
#'
#' @name logindata.dslite.discordant
#' @docType data
#' @keywords data
NULL

#' Simulated dataset DISCORDANT 1
#'
#' Simulated dataset DISCORDANT 1, in a data.frame with 12 observations of 2 discordant variables.
#'
#' | **Variable**       | **Description**                  | **Type** |
#' | ------------------ | -------------------------------- | -------- |
#' | A                  | Dummy data                       | integer  |
#' | B                  | Dummy data                       | integer  |
#'
#' @name DISCORDANT_STUDY1
#' @docType data
#' @keywords data
NULL

#' Simulated dataset DISCORDANT 2
#'
#' Simulated dataset DISCORDANT 2, in a data.frame with 12 observations of 2 discordant variables.
#'
#' | **Variable**       | **Description**                  | **Type** |
#' | ------------------ | -------------------------------- | -------- |
#' | A                  | Dummy data                       | integer  |
#' | C                  | Dummy data                       | integer  |
#'
#'
#' @name DISCORDANT_STUDY2
#' @docType data
#' @keywords data
NULL

#' Simulated dataset DISCORDANT 3
#'
#' Simulated dataset DISCORDANT 3, in a data.frame with 12 observations of 2 discordant variables.
#'
#' | **Variable**       | **Description**                  | **Type** |
#' | ------------------ | -------------------------------- | -------- |
#' | B                  | Dummy data                       | integer  |
#' | C                  | Dummy data                       | integer  |
#'
#' @name DISCORDANT_STUDY3
#' @docType data
#' @keywords data
NULL
