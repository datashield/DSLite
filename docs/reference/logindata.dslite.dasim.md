# DataSHIELD login data for the DASIM simulated datasets

DataSHIELD login data.frame for connecting with DASIM datasets. The
DASIM datasets contain synthetic data based on a model derived from the
participants of the 1958 Birth Cohort, as part of the obesity
methodological development project. These datasets do not contain some
NA values.

## Details

|           |                    |          |                                   |
|-----------|--------------------|----------|-----------------------------------|
| **Field** | **Description**    | **Type** | **Note**                          |
| server    | Server/study name  | char     |                                   |
| url       | Server/study URL   | char     | DSLiteServer instance symbol name |
| user      | User name          | char     | Always empty for DSLiteServer     |
| password  | User password      | char     | Always empty for DSLiteServer     |
| table     | Table unique name  | char     | As registered in the DSLiteServer |
| options   | Connection options | char     | Always empty for DSLiteServer     |
| driver    | Connection driver  | char     | DSLiteServer                      |
