#' DataSHIELD login data for the CNSIM simulated datasets
#'
#' DataSHIELD login data.frame for connecting with CNSIM datasets. The CNSIM datasets contain
#' synthetic data based on a model derived from the participants of the 1958 Birth Cohort,
#' as part of the obesity methodological development project. These datasets do contain some
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
#' @name logindata.dslite.cnsim
#' @docType data
#' @keywords data
NULL

#' Simulated dataset CNSIM 1
#'
#' Simulated dataset CNSIM 1, in a data.frame with 2163 observations of 11 harmonized
#' variables. The CNSIM dataset contains synthetic data based on a model derived from the
#' participants of the 1958 Birth Cohort, as part of the obesity methodological development
#' project. This dataset does contain some NA values.
#'
#' | **Variable**       | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | LAB_TSC            | Total Serum Cholesterol          | numeric  | mmol/L  |
#' | LAB_TRIG           | Triglycerides                    | numeric  | mmol/L   |
#' | LAB_HDL            | HDL Cholesterol                  | numeric  | mmol/L   |
#' | LAB_GLUC_ADJUSTED  | Non-Fasting Glucose              | numeric  | mmol/L   |
#' | PM_BMI_CONTINUOUS  | Body Mass Index (continuous)     | numeric  | kg/m2    |
#' | DIS_CVA            | History of Stroke                | factor   | 0 = Never had stroke, 1 = Has had stroke|
#' | MEDI_LPD           | Current Use of Lipid Lowering Medication (from categorical assessment item) | factor | 0 = Not currently using lipid lowering medication, 1 = Currently using lipid lowering medication|
#' | DIS_DIAB           | History of Diabetes              | factor   | 0 = Never had diabetes, 1 = Has had diabetes |
#' | DIS_AMI            | History of Myocardial Infarction | factor   | 0 = Never had myocardial infarction, 1 = Has had myocardial infarction |
#' | GENDER             | Gender                           | factor   | 0 = Female, 1 = Male |
#' | PM_BMI_CATEGORICAL | Body Mass Index (categorical)    | factor   | 1 = Less than 25 kg/m2, 2 = 25 to 30 kg/m2, 3 = Over 30 kg/m2 |
#'
#' @name CNSIM1
#' @docType data
#' @keywords data
NULL

#' Simulated dataset CNSIM 2
#'
#' Simulated dataset CNSIM 1, in a data.frame with 3088 observations of 11 harmonized variables
#' variables. The CNSIM dataset contains synthetic data based on a model derived from the
#' participants of the 1958 Birth Cohort, as part of the obesity methodological development
#' project. This dataset does contain some NA values.

#'
#' | **Variable**       | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | LAB_TSC            | Total Serum Cholesterol          | numeric  | mmol/L   |
#' | LAB_TRIG           | Triglycerides                    | numeric  | mmol/L   |
#' | LAB_HDL            | HDL Cholesterol                  | numeric  | mmol/L   |
#' | LAB_GLUC_ADJUSTED  | Non-Fasting Glucose              | numeric  | mmol/L   |
#' | PM_BMI_CONTINUOUS  | Body Mass Index (continuous)     | numeric  | kg/m2    |
#' | DIS_CVA            | History of Stroke                | factor   | 0 = Never had stroke, 1 = Has had stroke|
#' | MEDI_LPD           | Current Use of Lipid Lowering Medication (from categorical assessment item) | factor | 0 = Not currently using lipid lowering medication, 1 = Currently using lipid lowering medication|
#' | DIS_DIAB           | History of Diabetes              | factor   | 0 = Never had diabetes, 1 = Has had diabetes |
#' | DIS_AMI            | History of Myocardial Infarction | factor   | 0 = Never had myocardial infarction, 1 = Has had myocardial infarction |
#' | GENDER             | Gender                           | factor   | 0 = Female, 1 = Male |
#' | PM_BMI_CATEGORICAL | Body Mass Index (categorical)    | factor   | 1 = Less than 25 kg/m2, 2 = 25 to 30 kg/m2, 3 = Over 30 kg/m2 |
#'
#' @name CNSIM2
#' @docType data
#' @keywords data
NULL

#' Simulated dataset CNSIM 3
#'
#' Simulated dataset CNSIM 1, in a data.frame with 4128 observations of 11 harmonized variables
#' variables. The CNSIM dataset contains synthetic data based on a model derived from the
#' participants of the 1958 Birth Cohort, as part of the obesity methodological development
#' project. This dataset does contain some NA values.
#'
#' | **Variable**       | **Description**                  | **Type** | **Note** |
#' | ------------------ | -------------------------------- | -------- | -------- |
#' | LAB_TSC            | Total Serum Cholesterol          | numeric  | mmol/L   |
#' | LAB_TRIG           | Triglycerides                    | numeric  | mmol/L   |
#' | LAB_HDL            | HDL Cholesterol                  | numeric  | mmol/L   |
#' | LAB_GLUC_ADJUSTED  | Non-Fasting Glucose              | numeric  | mmol/L   |
#' | PM_BMI_CONTINUOUS  | Body Mass Index (continuous)     | numeric  | kg/m2    |
#' | DIS_CVA            | History of Stroke                | factor   | 0 = Never had stroke, 1 = Has had stroke|
#' | MEDI_LPD           | Current Use of Lipid Lowering Medication (from categorical assessment item) | factor | 0 = Not currently using lipid lowering medication, 1 = Currently using lipid lowering medication|
#' | DIS_DIAB           | History of Diabetes              | factor   | 0 = Never had diabetes, 1 = Has had diabetes |
#' | DIS_AMI            | History of Myocardial Infarction | factor   | 0 = Never had myocardial infarction, 1 = Has had myocardial infarction |
#' | GENDER             | Gender                           | factor   | 0 = Female, 1 = Male |
#' | PM_BMI_CATEGORICAL | Body Mass Index (categorical)    | factor   | 1 = Less than 25 kg/m2, 2 = 25 to 30 kg/m2, 3 = Over 30 kg/m2 |
#'
#' @name CNSIM3
#' @docType data
#' @keywords data
NULL
