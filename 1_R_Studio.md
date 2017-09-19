*1. Using R Studio*
================
Bindoff, A.

2017-09-19

![all I learn](when_you.jpg)

R Studio is an Integrated Development Environment (IDE) for the R statistical programming language. It has a number of useful features such as syntax highlighting, package maintenance, integration with git and other version control systems, and can generate documents dynamically (like this one) where analysis, tables, and figures can be produced within the document itself.

#### 1.1 Getting to know R Studio

The bottom left pane is the console. This is where your code is sent to the R interpreter.

The top left pane is where you write your scripts or edit your documents. It is a text editor that integrates with the console to execute your code.

The bottom right pane is where you will find Files in the working directory, plot output from the console, a list of packages that you have installed, and Help files (which are not very helpful until you understand data structures in R).

The top right pane will have different tabs depending on what you are working on, but usually shows objects in your current environment, and a console history.

#### 1.2 Basic commands (functions) and data structures

R is a "functional" language, so we refer to commands as "functions". A function is a collection of other functions that receive input and return output. Think of mathematical functions like `sin(x)`, in fact, R has a function sin() that takes an input (the argument) and returns output. Type `sin(pi/2)` in your console and hit Enter.

The console sent the argument `pi/2` to the `sin()` function and should have returned `1`.

In an R Markdown file in R Studio we can embed this code in a "chunk". The tiple back-ticks \`\`\` tell the editor that code between them should be executed.

``` r
sin(pi/2)
```

    ## [1] 1

If we want to assign a value or values to a variable we use `<-` or `=`. Either is fine, but by convention we use `=` inside function arguments and `<-` outside of function arguments. The reason for `<-` is because we're assigning the value on the right hand side to the variable on the left hand side (this is not what `=` means in mathematics, it is really short-hand for saying "Let x = y").

``` r
k <- c(1:10)/4
k
```

    ##  [1] 0.25 0.50 0.75 1.00 1.25 1.50 1.75 2.00 2.25 2.50

The above code assigns a "vector" of values to `k`, then prints `k` to the console. `c()` is a function which tells R to "combine" the values inside the parentheses to a vector. `1:10` means "all the integers from 1 to 10 inclusive". `/4` means "divide by 4". Notice that every element of the vector is divided by 4.

The following code chunk assigns a vector of objects to `first.names` then attempts to divide them by 2.

``` r
first.names <- c("Donald", "Gary", "Sue", "Imelda", 4)
first.names/2 # remove the comment to run in R Studio
```

You should have got an error (how do you divide "Donald" by 2?) - but what about the `4` at the end of the list?

``` r
first.names
```

    ## [1] "Donald" "Gary"   "Sue"    "Imelda" "4"

R has silently co-erced all of the elements of `first.names` to character strings (you can tell because they are printed with double-quotations around each element), including the 4. This is because R won't let a vector contain mixed data types. This is a good way for the R interpreter to prevent unexpected errors, and it avoids unnecessarily allocating huge chunks of excess memory (think about how a computer might operate on a vector of integers vs a mixed vector of integers interspersed with characters).

When we work with data from experiments or studies, data types are often mixed. We store these mixed data types in a "data frame" or "list" (a data frame is a type of list).

``` r
k <- data.frame(num = c(1,2,3,4),
                letter = c("a", "b", "c", "d"),
                value = c(0.23, pi, 4.5, 999),
                condition = factor(c("A", "B", "A", "B")))
k
```

    ##   num letter      value condition
    ## 1   1      a   0.230000         A
    ## 2   2      b   3.141593         B
    ## 3   3      c   4.500000         A
    ## 4   4      d 999.000000         B

``` r
levels(k$condition)
```

    ## [1] "A" "B"

`levels` is a function that tells us how many levels there are of a data type called a `factor`.
`k$condition` tells the interpreter that we want the `condition` column from the `k` data frame.

``` r
a <- c(10,9,8,7)
b <- c(1,2,3)
cbind(a,b)
```

    ## Warning in cbind(a, b): number of rows of result is not a multiple of
    ## vector length (arg 2)

    ##       a b
    ## [1,] 10 1
    ## [2,]  9 2
    ## [3,]  8 3
    ## [4,]  7 1

`cbind` is a function that binds two vectors as columns. A warning was issued because the number of elements of each vector differed. `cbind` still returned two bound columns, but notice how the second column was constructed. R uses a "recycling rule" except where it would obviously have a catastrophic outcome, such that the vector is "recycled" starting at the beginning until empty rows are filled. This might have a catastrophic outcome in a data frame, so we get an Error which causes the code/code-chunk to cease execution -

``` r
data.frame(a, b)

# the '#' character is reserved for comments,
# the code below will not execute due to an error above it in this chunk
a + b
```

*Continue to tutorial 2,* [Working with data](https://github.com/ABindoff/R_tutorials/blob/master/2_Data.md)

### Resources

[R for psychologists](http://personality-project.org/r/#intro)

[Cookbook for R](http://www.cookbook-r.com/)
