# DataSHIELD login data for the TESTING.DATASET simulated datasets

DataSHIELD login data.frame for connecting with TESTING.DATASET datasets
which purpose is to evaluate each base data types.

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
