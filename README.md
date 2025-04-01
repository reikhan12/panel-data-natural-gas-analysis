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

## 📁 Files in This Repository

Natural Gas Project/ │ ├── final version.R # Main R script with full analysis ├── NaturalGas.csv # [You should add this dataset or link it] ├── models_comparison.txt # (Optional) Exported model summary table └── electricity_consumption_plot.png # Sample plot (auto-saved)


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
  - lprice: LPG price  
  - income: Household income  
  - heating: Heating degree days  

---

## 📊 Visualization Examples

- Correlation heatmap
- Coefficient comparison bar chart
- Residual plots over time

---

## 📦 Required R Packages

Ensure you have the following R packages installed:

```r
install.packages(c("plm", "dplyr", "lmtest", "sandwich", 
                   "stargazer", "car", "ggplot2", "corrplot", "tidyr"))
