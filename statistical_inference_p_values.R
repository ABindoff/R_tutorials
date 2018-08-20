#### Statistical Inference part 1 - understanding p-values
####
#### this script accompanies the slide deck at github.com/ABindoff/R_tutorials/statistical_inference.html




#### slide 5


# setting the seed for the random number generator
# assures reproducibility
set.seed(42)  

# 36 trials with p = 0.5 chance of guessing correctly
bem <- function(n = 100, trials = 36){
  y <- replicate(n, rbinom(trials, 1, prob = 0.5))
  colMeans(y)
}
y <- bem(n = 100)

####

hist(y, main = "", breaks = seq(0.05, 1, by = 0.1))


#### slide 7

# initialise a vector to store results of our t-tests
y <- replicate(1000, bem(n = 100, trials = 36))
replication <- colMeans(y)

hist(replication)
abline(v = 0.53, lty = 2)

####

bem2 <- function(){
  y <- bem(n = 40, trials = 12)
  y <- c(y, bem(n = 60, trials = 18))
  return(y)
}

y <- replicate(1000, bem2())
replication <- colMeans(y)

hist(replication)
abline(v = 0.53, lty = 2)
cat("\n", sum(replication >.53),
    " out of 1000 replications with mean correct responses > .53")

pvals <- apply(y, 2, function(z) t.test(z-0.5)$p.val)

hist(pvals, breaks = 20, main = "1000 replications (no effect)")

####

set.seed(10)
B0 <- 3
B1 <- 1.25
epsilon <- function(){rnorm(12, mean = 0, sd = 1)}
x1 <- c(rep(0, 6), rep(1, 6))

y <- function(){B0 + B1*x1 + epsilon()}
data <- data.frame(y = round(y(), 1), x1 = factor(x1))

#### slide 13

data


#### slide 14

t.test(y ~ x1, data, var.equal = TRUE)
cat("\n\nDifference in group means = ", mean(data$y[7:12] - data$y[1:6]))





####

shuffle <- function(y){
  n <- length(y)
  ydot <- sample(y, n, replace = FALSE)
  y1 <- ydot[1:floor(n/2)]
  y2 <- ydot[(floor(n/2)+1):n]
  abs(mean(y1)-mean(y2))
}
set.seed(1)
permute <- replicate(100, shuffle(data$y), simplify = "array")

hist(permute, breaks = 20, xlab = "random group diff", main = "Null distribution")
abline(v = 1.233, lty = "dotted")


####

p.val.perm <- function(){
  k <- y()         # run experiment again (random draws from generating model)
  obs.diff <- abs(mean(k[7:12]-k[1:6]))  # calculate observed difference of means
  perm <- replicate(100, shuffle(k))     # permute ("shuffle") 100 times and calculate observed differences
  mean(perm >= obs.diff)       # what proportion of permutations >= observed difference from experiment
}

p.perm <- replicate(500, p.val.perm())   # repeat experiment 500 times, storing p-value each time
mean(p.perm < .05) 

#### slide 18

hist(p.perm, breaks = 20)
