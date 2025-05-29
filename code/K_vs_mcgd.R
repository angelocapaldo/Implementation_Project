#-------------------------------------------------------------------
# Angelo Capaldo
# Implementation project
# Paleobiology FAU 2025
#-------------------------------------------------------------------

# The task is to observe how changes in K value (Kent distribution)
# influence the mcgd values


# First of all we load the package biodome
library(biodome)


# Now we define our K values vector
k_values <- c(5, 15, 25, 35, 45, 55, 65, 75, 85, 95, 105, 115, 125, 135, 145)


# Now we do a forloop to generate distributions with each K value
# The number of randomly generated data will always be 50.
distributions <- vector("list", length(k_values))
for (i in seq_along(k_values)) {
  distributions[[i]] <- kentPresence(n = 50, kappa = k_values[i])
}


# Now a check to the data
distributions


# All good, now let's forloop the mcgd to get multiple results
mgcd_results <- vector("list", length(distributions))
for (m in seq_along(distributions)) {
  mgcd_results[[m]] <- ranges_mgcd(distributions[[m]], dm = NULL, plot = FALSE, plot.args = NULL)
}


# Now let's plot a graph that has K values on the x axis and mgcd results on the y axis
estimates <- sapply(mgcd_results, function(x) x[["estimate"]]) # estracting the estimates
regression <- lm(estimates ~ k_values) # linear regression    
plot(k_values, estimates,
     main = "K values and mgcd results relationship",
     xlab = "K values", ylab = "mgcd results",
     pch = 19,
     xlim = c(min(k_values), max(k_values) + 10))
abline(regression, col = "red", lwd = 2) # linear regression




#-------------------------------------------------------------------------------
# Try again with smaller K values

k_values <- c(0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48)
distributions <- vector("list", length(k_values))
for (i in seq_along(k_values)) {
  distributions[[i]] <- kentPresence(n = 50, kappa = k_values[i])
}
mgcd_results <- vector("list", length(distributions))
for (m in seq_along(distributions)) {
  mgcd_results[[m]] <- ranges_mgcd(distributions[[m]], dm = NULL, plot = FALSE, plot.args = NULL)
}
estimates <- sapply(mgcd_results, function(x) x[["estimate"]]) 
regression <- lm(estimates ~ k_values)
plot(k_values, estimates,
     main = "K values and mgcd results relationship",
     xlab = "K values", ylab = "mgcd results",
     pch = 19,
     xlim = c(min(k_values), max(k_values) + 10))
abline(regression, col = "red", lwd = 2)
