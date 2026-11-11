# DataSHIELD login data for the simulated survival expand-with-missing datasets

DataSHIELD login data.frame for connecting with SURVIVAL datasets which
purpose is to perform survival tests. The datasets contain synthetic
data based on a simulated survival model, including a censoring
indicator.

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
