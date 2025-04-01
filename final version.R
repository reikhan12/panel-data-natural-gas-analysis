# Install and load necessary packages
install.packages("plm")
install.packages("dplyr")
install.packages("lmtest")
install.packages("sandwich")
install.packages("stargazer")
install.packages("car")
install.packages("ggplot2")
install.packages("corrplot")

library(plm)
library(dplyr)
library(lmtest)
library(sandwich)
library(stargazer)
library(car)
library(ggplot2)
library(corrplot)

# Load the dataset
data <- read.csv("C:/Users/Bhupender/Desktop/Assignments/Sem 2/Econometrics/NaturalGas.csv") # Update the path to the correct one

# Set up the panel data structure
pdata <- pdata.frame(data, index = c("state", "year"))

# Define the dependent and independent variables
dependent_var <- "consumption"
independent_vars <- c("price", "eprice", "oprice", "lprice", "heating", "income")

## checking relation with individual variable to dependent variable.

# Fit OLS model
ols_model <- lm(consumption ~ price, data = data)
summary(ols_model)

# Breusch-Pagan Test for heteroskedasticity
bp_test <- bptest(ols_model)
print(bp_test)

# Durbin-Watson Test for autocorrelation
dw_test <- durbinWatsonTest(ols_model)
print(dw_test)

# Variance Inflation Factor (VIF) for multicollinearity
vif_values <- vif(ols_model)
print(vif_values)

# Plot the relationship between natural gas price and consumption
ggplot(data, aes(x = price, y = consumption)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Impact of Natural Gas Price on Consumption",
       x = "Natural Gas Price",
       y = "Natural Gas Consumption")

# Fit OLS model for income
ols_model_income <- lm(consumption ~ income, data = data)
summary(ols_model_income)

# Breusch-Pagan Test for heteroskedasticity
bp_test_income <- bptest(ols_model_income)
print(bp_test_income)

# Durbin-Watson Test for autocorrelation
dw_test_income <- durbinWatsonTest(ols_model_income)
print(dw_test_income)

# Plot the relationship between household income and natural gas consumption
ggplot(data, aes(x = income, y = consumption)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Impact of Household Income on Natural Gas Consumption",
       x = "Household Income",
       y = "Natural Gas Consumption")


# Fit OLS model for heating degree days
ols_model_heating <- lm(consumption ~ heating, data = data)
summary(ols_model_heating)

# Breusch-Pagan Test for heteroskedasticity
bp_test_heating <- bptest(ols_model_heating)
print(bp_test_heating)

# Durbin-Watson Test for autocorrelation
dw_test_heating <- durbinWatsonTest(ols_model_heating)
print(dw_test_heating)

# Plot the relationship between heating degree days and natural gas consumption
ggplot(data, aes(x = heating, y = consumption)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Impact of Heating Degree Days on Natural Gas Consumption",
       x = "Heating Degree Days",
       y = "Natural Gas Consumption")


# Fit OLS model for electricity price
ols_model_electricity <- lm(consumption ~ eprice, data = data)
summary(ols_model_electricity)

# Breusch-Pagan Test for heteroskedasticity
bp_test_electricity <- bptest(ols_model_electricity)
print(bp_test_electricity)

# Durbin-Watson Test for autocorrelation
dw_test_electricity <- durbinWatsonTest(ols_model_electricity)
print(dw_test_electricity)

# Plot the relationship between electricity price and natural gas consumption
ggplot(data, aes(x = eprice, y = consumption)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Impact of Electricity Price on Natural Gas Consumption",
       x = "Electricity Price",
       y = "Natural Gas Consumption")

# Save the plot
ggsave("electricity_consumption_plot.png", plot = electricity_consumption_plot)
#--------------------------------------------------------------------------------------------------------------------------------------


##Panel Data Analysis

# Fit OLS model
ols_model <- lm(consumption ~ price + eprice + oprice + lprice + heating + income, data = pdata)

# Fit Fixed Effects model
fixed_effects_model <- plm(consumption ~ price + eprice + oprice + lprice + heating + income, data = pdata, model = "within")

# Fit Random Effects model using Amemiya for efficieny
random_effects_model <- plm(consumption ~ price + eprice + oprice + lprice + heating + income, data = pdata, model = "random", random.method = "amemiya")

# Summaries of the models
summary(ols_model)
summary(fixed_effects_model)
summary(random_effects_model)

# Hausman test to compare fixed and random effects models
hausman_test <- phtest(fixed_effects_model, random_effects_model)
print(hausman_test)
# Conclusion:
# Based on the Hausman test, the random effects model is preferred over the fixed effects model 
# for this dataset, as it is both consistent and efficient under the null hypothesis.

# Check for multicollinearity using Spearman's rank correlation
cor_matrix <- cor(data[independent_vars], method = "spearman")
print(cor_matrix)

# Breusch-Pagan test for heteroskedasticity
bp_test_ols <- bptest(ols_model)
bp_test_random <- bptest(random_effects_model)
print(bp_test_ols)
print(bp_test_random)
# Interpretation:
# Since the p-value (0.08557) is greater than the typical significance level of 0.05, 
# we fail to reject the null hypothesis. This suggests that there is no significant evidence 
# of heteroskedasticity in the residuals of the random effects model.

# Serial correlation test
serial_test <- pbgtest(random_effects_model)
print(serial_test)
# Since the p-value (2.888e-05) is much less than the typical significance level of 0.05, we reject the null hypothesis.
# This suggests that there is significant evidence of serial correlation in the idiosyncratic errors of the random effects model.

# Robust standard errors
robust_se_random <- coeftest(random_effects_model, vcov = vcovHC(random_effects_model, type = "HC0", cluster = "group"))
print(robust_se_random)
# Detailed explanation of the final robust model results
# The final robust model uses robust standard errors to account for potential heteroskedasticity 
# and correlation, providing more reliable inference.
# As we dont have heteroskedasticity,so we account of corelation

# General TO specific procedure: 
#H0-"price=0","eprice=0", "oprice=0","income=0" at the same time
# Test joint significance of every insignificant  using linearHypothesis from car package
linearHypothesis(random_effects_model, c("price=0","lprice=0", "eprice=0", "oprice=0","income=0"))


# Fit the restricted Random Effects model 
restricted_random_effects_model <- plm(consumption ~ heating, data = pdata, model = "random", random.method = "amemiya")
summary(restricted_random_effects_model)

final_robust_model <- coeftest(restricted_random_effects_model, vcov = vcovHC(restricted_random_effects_model, type = "HC0", cluster = "group"))
final_robust_model
# Conclusion:
# The final robust model results highlight the significant impact of both the intercept and the heating degree days on natural gas consumption.(Assuming 10% alpha, observations were around 100)
# The use of robust standard errors ensures that the estimates are consistent and reliable.


# Manually calculate AIC for plm models
calc_AIC <- function(model, n) {
  RSS <- sum(residuals(model)^2)
  k <- length(coef(model)) + 1  # Number of parameters (including intercept)
  AIC <- n * log(RSS / n) + 2 * k
  return(AIC)
}

n <- nrow(pdata)

aic_ols <- AIC(ols_model)
aic_fixed <- calc_AIC(fixed_effects_model, n)
aic_random <- calc_AIC(random_effects_model, n)
aic_final_fixed <- calc_AIC(final_fixed_model, n)

print(aic_ols)
print(aic_fixed)
print(aic_random)
print(aic_final_fixed)

# Compare models using stargazer
stargazer(ols_model, fixed_effects_model, random_effects_model, final_fixed_model, type = "text", 
          title = "Model Comparison", 
          dep.var.labels = "Natural Gas Consumption",
          out = "models_comparison.txt")

# Visualization: Correlation Matrix Heatmap
corrplot(cor_matrix, method = "color", type = "upper", 
         tl.col = "black", tl.srt = 60, 
         title = "Correlation Matrix Heatmap")

# Visualization: Residuals Plot for Final Fixed Effects Model
residuals_final_fixed <- residuals(final_fixed_model)
ggplot(data = data.frame(year = as.numeric(index(pdata)$year), residuals = residuals_final_fixed), aes(x = year, y = residuals)) +
  geom_line() +
  labs(title = "Residuals Plot for Final Fixed Effects Model", x = "Year", y = "Residuals")

# Ensure consistent lengths for coefficient vectors
coef_ols <- coef(ols_model)[independent_vars]
coef_fixed <- coef(fixed_effects_model)
coef_random <- coef(random_effects_model)
coef_final_fixed <- coef(final_fixed_model)

# Create a data frame for coefficients
create_coef_df <- function(vars, ...){
  coef_list <- list(...)
  max_length <- max(sapply(coef_list, length))
  
  coef_df <- data.frame(Variable = rep(vars, length(coef_list)), 
                        Model = rep(names(coef_list), each = length(vars)), 
                        Coefficient = NA)
  
  for(i in seq_along(coef_list)){
    coefs <- coef_list[[i]]
    coef_df$Coefficient[(1 + (i-1)*length(vars)):(i*length(vars))] <- ifelse(names(coefs) %in% vars, coefs[vars], NA)
  }
  return(coef_df)
}

coef_df <- create_coef_df(independent_vars, 
                          OLS = coef_ols, 
                          Fixed_Effects = coef_fixed, 
                          Random_Effects = coef_random, 
                          Final_Fixed_Effects = coef_final_fixed)

# Reshape the data frame for plotting
coef_df <- coef_df %>%
  pivot_wider(names_from = Model, values_from = Coefficient) %>%
  gather(key = "Model", value = "Coefficient", -Variable)

# Visualization: Coefficient Plot
ggplot(coef_df, aes(x = Variable, y = Coefficient, fill = Model)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "Coefficient Plot for Different Models", x = "Variable", y = "Coefficient")
