# Panel-data-natural-gas-analysis
Panel data econometrics project analyzing the effect of energy prices, income, and heating on natural gas consumption using OLS, Fixed Effects, and Random Effects models in R.

# 📉 Panel Data Analysis of Natural Gas Consumption in R

This repository contains a complete panel data econometrics project analyzing the impact of energy prices, income, and climate variables on **natural gas consumption** across U.S. states over time. The project applies econometric techniques including:

- OLS (Ordinary Least Squares)
- Fixed Effects
- Random Effects
- Robust Standard Errors
- Hausman Test
- AIC comparisons
- Visualization of coefficients and residuals

---


---

## 📌 Key Features

- ✅ Panel data setup with `plm` and `pdata.frame`
- ✅ Multicollinearity checks via **VIF** and **Spearman correlation**
- ✅ Autocorrelation tests (Durbin-Watson, pbgtest)
- ✅ Heteroskedasticity checks (Breusch-Pagan)
- ✅ Coefficient plots across different models
- ✅ Final robust model estimation
- ✅ Model comparison via AIC and `stargazer`

---

## 🔍 Variables

- **Dependent Variable**: Natural gas consumption
- **Independent Variables**: 
  - price: Natural gas price  
  - eprice: Electricity price  
  - oprice: Oil price  
  - lprice: Lagged price of natural gas  
  - income: Household income  
  - heating: Heating degree days  

---

## 📊 4.1 Data Source

In this study, we utilized a dataset focusing on **natural gas consumption** across various states in the United States. The dataset spans multiple decades and includes both economic and climate-related variables. It serves as a comprehensive resource for analyzing energy consumption patterns and their economic drivers over time.

The dataset was compiled from publicly available U.S. government sources, primarily from the **[U.S. Energy Information Administration (EIA)](https://www.eia.gov/state/seds/seds-data-complete.php)** and other historical energy records.

### 📁 Key Variables Included:
| Variable     | Description |
|--------------|-------------|
| `State`      | U.S. state abbreviation (e.g., NY for New York) |
| `State Code` | Numerical state code |
| `Year`       | Year of observation |
| `Consumption`| Natural gas consumption (units may vary by source) |
| `Price`      | Price of natural gas |
| `Eprice`     | Price of electricity |
| `Oprice`     | Price of oil |
| `Lprice`     | Lagged price of natural gas |
| `Heating`    | Heating degree days (climate proxy) |
| `Income`     | Average household income |

You can access and replicate the dataset using the **[State Energy Data System (SEDS)](https://www.eia.gov/state/seds/seds-data-complete.php)** by the U.S. Energy Information Administration.

---

## 📦 Required R Packages

```r
install.packages(c("plm", "dplyr", "lmtest", "sandwich", 
                   "stargazer", "car", "ggplot2", "corrplot", "tidyr"))
```

---

## 🚀 How to Run

1. Open `final version.R` in RStudio or any R environment.
2. Ensure the dataset `NaturalGas.csv` is available in the working directory.
3. Run each block step-by-step to replicate the full analysis, tests, and plots.

---

## 🧠 Learning Outcomes

This project demonstrates how to:
- Apply econometric techniques to real-world data
- Choose between fixed vs. random effects using Hausman tests
- Use robust standard errors for more reliable inference
- Visualize model results and understand implications of policy-relevant variables

---

## 🤝 Contributions

Feel free to fork the repository, suggest improvements, or raise issues!

---

📬 If you find this project insightful, consider giving it a ⭐ star!
