#' DataSHIELD login data for the simulated survival expand-with-missing datasets
#'
#' DataSHIELD login data.frame for connecting with SURVIVAL datasets which purpose is to perform survival tests.
#' The datasets contain synthetic data based on a simulated survival model, including a censoring indicator.
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
#' @name logindata.dslite.survival.expand_with_missing
#' @docType data
#' @keywords data
NULL

#' Simulated survival expand-with-missing dataset 1
#'
#' Simulated dataset SURVIVAL.EXPAND_WITH_MISSING 1, in a data.frame with 2060 observations of 12 harmonized variables.
#' The dataset contains synthetic data based on a simulated survival model, including a censoring indicator.
#'
#' | **Variable**       | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | id                 | Unique individual ID             | integer  ||
#' | study.id           | Study ID                         | integer  ||
#' | time.id            | Time ID                          | integer  ||
#' | starttime          | Start of follow up               | numeric  | years |
#' | endtime            | End of follow up                 | numeric  | years |
#' | survtime           | Survtime                         | numeric  | years |
#' | cens               | Censoring status                 | factor   | 0 = not censored, 1 = censored |
#' | age.60             | Age centred at 60                | numeric  ||
#' | female             | Gender                           | factor   | 0 = Male, 1 = Female |
#' | noise.56           | Noise pollution centred at 56    | numeric  | dB |
#' | pm10.16            | Particulate matter centred at 16 | numeric  | μg/m3 |
#' | bmi.26             | Body mass index centred at 26    | numeric  | kg/m2 |
#'
#' @name SURVIVAL.EXPAND_WITH_MISSING1
#' @docType data
#' @keywords data
NULL

#' Simulated survival expand-with-missing dataset 2
#'
#' Simulated dataset SURVIVAL.EXPAND_WITH_MISSING 2, in a data.frame with 1640 observations of 12 harmonized variables.
#' The dataset contains synthetic data based on a simulated survival model, including a censoring indicator.
#'
#' | **Variable**       | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | id                 | Unique individual ID             | integer  ||
#' | study.id           | Study ID                         | integer  ||
#' | time.id            | Time ID                          | integer  ||
#' | starttime          | Start of follow up               | numeric  | years |
#' | endtime            | End of follow up                 | numeric  | years |
#' | survtime           | Survtime                         | numeric  | years |
#' | cens               | Censoring status                 | factor   | 0 = not censored, 1 = censored |
#' | age.60             | Age centred at 60                | numeric  ||
#' | female             | Gender                           | factor   | 0 = Male, 1 = Female |
#' | noise.56           | Noise pollution centred at 56    | numeric  | dB |
#' | pm10.16            | Particulate matter centred at 16 | numeric  | μg/m3 |
#' | bmi.26             | Body mass index centred at 26    | numeric  | kg/m2 |
#'
#' @name SURVIVAL.EXPAND_WITH_MISSING2
#' @docType data
#' @keywords data
NULL

#' Simulated survival expand-with-missing dataset 3
#'
#' Simulated dataset SURVIVAL.EXPAND_WITH_MISSING 3, in a data.frame with 2688 observations of 12 harmonized variables.
#' The dataset contains synthetic data based on a simulated survival model, including a censoring indicator.
#'
#' | **Variable**       | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | id                 | Unique individual ID             | integer  ||
#' | study.id           | Study ID                         | integer  ||
#' | time.id            | Time ID                          | integer  ||
#' | starttime          | Start of follow up               | numeric  | years |
#' | endtime            | End of follow up                 | numeric  | years |
#' | survtime           | Survtime                         | numeric  | years |
#' | cens               | Censoring status                 | factor   | 0 = not censored, 1 = censored |
#' | age.60             | Age centred at 60                | numeric  ||
#' | female             | Gender                           | factor   | 0 = Male, 1 = Female |
#' | noise.56           | Noise pollution centred at 56    | numeric  | dB |
#' | pm10.16            | Particulate matter centred at 16 | numeric  | μg/m3 |
#' | bmi.26             | Body mass index centred at 26    | numeric  | kg/m2 |
#'
#' @name SURVIVAL.EXPAND_WITH_MISSING3
#' @docType data
#' @keywords data
NULL
