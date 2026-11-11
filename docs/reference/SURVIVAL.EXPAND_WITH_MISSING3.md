# Simulated survival expand-with-missing dataset 3

Simulated dataset SURVIVAL.EXPAND_WITH_MISSING 3, in a data.frame with
2688 observations of 12 harmonized variables. The dataset contains
synthetic data based on a simulated survival model, including a
censoring indicator.

## Details

|  |  |  |  |
|----|----|----|----|
| **Variable** | **Description** | **Type** | **Note** |
| id | Unique individual ID | integer |  |
| study.id | Study ID | integer |  |
| time.id | Time ID | integer |  |
| starttime | Start of follow up | numeric | years |
| endtime | End of follow up | numeric | years |
| survtime | Survtime | numeric | years |
| cens | Censoring status | factor | 0 = not censored, 1 = censored |
| age.60 | Age centred at 60 | numeric |  |
| female | Gender | factor | 0 = Male, 1 = Female |
| noise.56 | Noise pollution centred at 56 | numeric | dB |
| pm10.16 | Particulate matter centred at 16 | numeric | µg/m3 |
| bmi.26 | Body mass index centred at 26 | numeric | kg/m2 |
