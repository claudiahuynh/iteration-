Writing Functions
================
My An Huynh
2024-10-31

## Writing functions

z-score computation

``` r
x_vec = rnorm(n = 25, mean = 10, sd = 3.5)

(x_vec - mean(x_vec))/sd(x_vec)
```

    ##  [1]  1.59935620  0.21757584 -0.44038123  0.96632591  0.76212319 -1.93460107
    ##  [7] -0.42099318 -0.77119509 -1.28852936  1.18918657  0.04412212  0.34292812
    ## [13] -0.82761966 -0.58375794  1.20698726  0.71127825 -1.25900220 -0.76899295
    ## [19] -1.23019938  0.68982179  1.30674519  0.11183067  0.13867642 -1.11689061
    ## [25]  1.35520515

Write a function to do this.

``` r
z_scores = function(x){
  if( !is.numeric(x)) {
    stop("x needs to be numeric")
  }
  if(length(x) < 5) {
    stop("you need at least five numbers to compute the z score")
  }
  z = (x - mean(x))/sd(x)
  
  return(z)
}

z_scores(x = x_vec)
```

    ##  [1]  1.59935620  0.21757584 -0.44038123  0.96632591  0.76212319 -1.93460107
    ##  [7] -0.42099318 -0.77119509 -1.28852936  1.18918657  0.04412212  0.34292812
    ## [13] -0.82761966 -0.58375794  1.20698726  0.71127825 -1.25900220 -0.76899295
    ## [19] -1.23019938  0.68982179  1.30674519  0.11183067  0.13867642 -1.11689061
    ## [25]  1.35520515

Does this always work?

error = TRUE allows rmd to knit with errors

``` r
z_scores(x = 3)
```

    ## Error in z_scores(x = 3): you need at least five numbers to compute the z score

``` r
z_scores(x = c("my", "name", "is", "Claudia"))
```

    ## Error in z_scores(x = c("my", "name", "is", "Claudia")): x needs to be numeric
