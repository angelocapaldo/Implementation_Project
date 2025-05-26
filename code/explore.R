
library("biodome")

# seed just for demonstration

set.seed(0)

# randomly generated points on sphere

distribution <- kentPresence(n=5000, kappa=0)
plot(distribution)

# changing k value to see how concentration changes

concentration <- kentPresence(n=5000, kappa=200)
points(concentration, col="red")

# determining where the centre is and using it as the place where datas appear

centre <- matrix(0, ncol=2, nrow=1)
lowsamples <- kentPresence(n=50, kappa=50, centers=centre)

# extending ath the maximum the x and y limits 

plot(lowsamples, xlim=c(-180, 180), ylim=c(-90, 90))

#using maximum great circle

ranges_mgcd(lowsamples)$estimate
ranges_mgcd(lowsamples, dm = NULL, plot = TRUE, plot.args = NULL)

# observe how changes in k are influencing the results
# define a vector of 15 values and forloop generating mgcd values and plot x is k y mgcd



