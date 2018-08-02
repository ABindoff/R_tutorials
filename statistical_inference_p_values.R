#### Statistical Inference part 1 - understanding p-values
####
#### this script accompanies the slide deck at github.com/ABindoff/R_tutorials/statistical_inference.html




#### slide 5


# setting the seed for the random number generator
# assures reproducibility
set.seed(42)  

# 36 trials with p = 0.5 chance of guessing correctly
y <- replicate(10000, rbinom(36, 1, prob = 0.5))  


#### slide 6

hist(colMeans(y), breaks = 24, main = "")


#### slide 7

# initialise a vector to store results of our t-tests
rep <- c()  
for(i in 1:2000){
  y <- replicate(100, rbinom(36, 1, prob = 0.5))
  # one sample t-test of difference from expected value if chance
  test <- t.test(colMeans(y)-0.5) 
  # store the p-values in a vector called `rep`
  rep <- c(rep, test$p.value)                
}



#### slide 8

hist(rep, breaks = 20, main = "")



#### slide 11

set.seed(10)
B0 <- 3
B1 <- 1.5
epsilon <- function(){rnorm(12, mean = 0, sd = 1)}
x1 <- c(rep(0, 6), rep(1, 6))

y <- function(){B0 + B1*x1 + epsilon()}

data <- data.frame(y = round(y(), 1), x1 = factor(x1))

#### slide 13

data


#### slide 14

t.test(y ~ x1, data)
cat("\n\nDifference in group means = ", mean(data$y[7:12] - data$y[1:6]))




#### slide 16

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



#### slide 17

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
