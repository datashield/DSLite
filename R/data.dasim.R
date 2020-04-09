#' DataSHIELD login data for the DASIM simulated datasets
#'
#' DataSHIELD login data.frame for connecting with DASIM datasets. The DASIM datasets contain
#' synthetic data based on a model derived from the participants of the 1958 Birth Cohort, as
#' part of the obesity methodological development project. These datasets do not contain some
#' NA values.
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
#' @name logindata.dslite.dasim
#' @docType data
#' @keywords data
NULL

#' Simulated dataset DASIM 1
#'
#' Simulated dataset DASIM 1, in a data.frame with 10000 observations of 10 harmonized variables.
#' The DASIM dataset contains synthetic data based on a model derived from the participants of
#' the 1958 Birth Cohort, as part of the obesity methodological development project. This dataset
#' does not contain some NA values.
#'
#' | **Variable**       | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | LAB_TSC            | Total Serum Cholesterol          | numeric  | mmol/L   |
#' | LAB_TRIG           | Triglycerides                    | numeric  | mmol/L   |
#' | LAB_HDL            | HDL Cholesterol                  | numeric  | mmol/L   |
#' | LAB_GLUC_FASTING   | Fasting Glucose                  | numeric  | mmol/L   |
#' | PM_BMI_CONTINUOUS  | Body Mass Index (continuous)     | numeric  | kg/m2    |
#' | DIS_CVA            | History of Stroke                | factor   | 0 = Never had stroke, 1 = Has had stroke|
#' | DIS_DIAB           | History of Diabetes              | factor   | 0 = Never had diabetes, 1 = Has had diabetes|
#' | DIS_AMI            | History of Myocardial Infarction | factor   | 0 = Never had myocardial infarction, 1 = Has had myocardial infarction|
#' | GENDER             | Gender                           | factor   | 0 = Female, 1 = Male|
#' | PM_BMI_CATEGORICAL | Body Mass Index (categorical)    | factor   | 1 = Less than 25 kg/m2, 2 = 25 to 30 kg/m2, 3 = Over 30 kg/m2|
#'
#' @name DASIM1
#' @docType data
#' @keywords data
NULL

#' Simulated dataset DASIM 2
#'
#' Simulated dataset DASIM 2, in a data.frame with 10000 observations of 10 harmonized variables.
#' The DASIM dataset contains synthetic data based on a model derived from the participants of
#' the 1958 Birth Cohort, as part of the obesity methodological development project. This dataset
#' does not contain some NA values.
#'
#' | **Variable**       | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | LAB_TSC            | Total Serum Cholesterol          | numeric  | mmol/L   |
#' | LAB_TRIG           | Triglycerides                    | numeric  | mmol/L   |
#' | LAB_HDL            | HDL Cholesterol                  | numeric  | mmol/L   |
#' | LAB_GLUC_FASTING   | Fasting Glucose                  | numeric  | mmol/L   |
#' | PM_BMI_CONTINUOUS  | Body Mass Index (continuous)     | numeric  | kg/m2    |
#' | DIS_CVA            | History of Stroke                | factor   | 0 = Never had stroke, 1 = Has had stroke|
#' | DIS_DIAB           | History of Diabetes              | factor   | 0 = Never had diabetes, 1 = Has had diabetes|
#' | DIS_AMI            | History of Myocardial Infarction | factor   | 0 = Never had myocardial infarction, 1 = Has had myocardial infarction|
#' | GENDER             | Gender                           | factor   | 0 = Female, 1 = Male|
#' | PM_BMI_CATEGORICAL | Body Mass Index (categorical)    | factor   | 1 = Less than 25 kg/m2, 2 = 25 to 30 kg/m2, 3 = Over 30 kg/m2|
#'
#' @name DASIM2
#' @docType data
#' @keywords data
NULL

#' Simulated dataset DASIM 3
#'
#' Simulated dataset DASIM 3, in a data.frame with 10000 observations of 10 harmonized variables.
#' The DASIM dataset contains synthetic data based on a model derived from the participants of
#' the 1958 Birth Cohort, as part of the obesity methodological development project. This dataset
#' does not contain some NA values.
#'
#' | **Variable**       | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | LAB_TSC            | Total Serum Cholesterol          | numeric  | mmol/L   |
#' | LAB_TRIG           | Triglycerides                    | numeric  | mmol/L   |
#' | LAB_HDL            | HDL Cholesterol                  | numeric  | mmol/L   |
#' | LAB_GLUC_FASTING   | Fasting Glucose                  | numeric  | mmol/L   |
#' | PM_BMI_CONTINUOUS  | Body Mass Index (continuous)     | numeric  | kg/m2    |
#' | DIS_CVA            | History of Stroke                | factor   | 0 = Never had stroke, 1 = Has had stroke|
#' | DIS_DIAB           | History of Diabetes              | factor   | 0 = Never had diabetes, 1 = Has had diabetes|
#' | DIS_AMI            | History of Myocardial Infarction | factor   | 0 = Never had myocardial infarction, 1 = Has had myocardial infarction|
#' | GENDER             | Gender                           | factor   | 0 = Female, 1 = Male|
#' | PM_BMI_CATEGORICAL | Body Mass Index (categorical)    | factor   | 1 = Less than 25 kg/m2, 2 = 25 to 30 kg/m2, 3 = Over 30 kg/m2|
#'
#' @name DASIM3
#' @docType data
#' @keywords data
NULL
