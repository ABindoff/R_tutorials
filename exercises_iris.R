# the iris dataset comes packaged with R
# it contains measurements from 3 species of iris
# let's have a look at it

head(iris)

# which parts of the flower were measured?

# how many individual flowers were measured?

# what are the three species of iris in the data set?

# what is the mean sepal length of all flowers in the data set?

# what is the standard deviation of all flowers in the data set?

# what is the mean sepal length of each species? (Bonus points 
# if you use `dplyr`)

# what was the widest sepal measured?


# the iris data is in "wide format". For many data analysis applications
# we need the data to be in "long format". There are lots of ways to turn 
# wide format data into long format. We will use the `reshape2` package today.
install.packages("reshape2")
library(reshape2)

# melt() takes wide data and makes it long
# it tries to guess how to do this, and
# in this case it guesses correctly
iris.long <- melt(iris)

# what does the message that melt() gives us mean?

# view the data in R Studio's data viewer
View(iris.long)

# plot the data
ggplot(iris.long, aes(x = Species, y = value, fill = variable)) +
  geom_boxplot()

# which species had the widest measured sepal?

# which species is the biggest on average?


# we've seen that plotting the data can be an efficient way to answer
# some questions about our data. Let's say we're interested in whether
# or not Petal.Length is correlated with Sepal.Length. Modify the following
# line of code to explore this question
ggplot(iris, aes(x = , y = , colour = Species)) +
  geom_point()

# is there a statistically significant relationship between Petal.Length and
# Sepal.Length? Bonus points if you "cheat" by using Google to find code that
# you can use or adapt, and extra bonus points if you can explain what your code
# actually does and can interpret the output correctly

