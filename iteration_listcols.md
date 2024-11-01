Iterations and list cols
================
My An Huynh
2024-10-31

## Here’s some lists

``` r
l = list(
  vec_numeric = 1:4,
  unif_sample = runif(1:100),
  mat = matrix(1:8, nrow = 2, ncol = 4, byrow = TRUE),
  summary = summary(rnorm(1000))
)

l[["mat"]][1, 3]
```

    ## [1] 3

Make a list that’s hopefully a bit more useful

``` r
list_norm = 
  list(
    a = rnorm(20, 0, 5),
    b = rnorm(20, 4, 5),
    c = rnorm(20, 0, 10),
    d = rnorm(20, 4, 10)
  )

list_norm[["a"]]
```

    ##  [1] -0.2043721  5.5741232 -2.7096382 -5.1706158 -2.5576096  3.7641337
    ##  [7]  2.7191589  0.4704631 -0.7636810 -3.3692680  6.5224554  2.3787231
    ## [13]  3.8441407 -2.4087889  2.0443634 -0.1817329  5.7585729 -7.3311083
    ## [19] -4.5415373  4.2755080

Reuse the function we wrote last time.

``` r
mean_and_sd = function(x) {
  
  mean_x = mean(x)
  sd_x = sd(x)
  
  out_df = 
    tibble(
      mean = mean_x,
      sd = sd_x
    )
  
  return(out_df)
}
```

Let’s use the function to take mean and sd of all samples

``` r
mean_and_sd(list_norm[["a"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 0.406  3.98

``` r
mean_and_sd(list_norm[["b"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  4.31  5.11

``` r
mean_and_sd(list_norm[["c"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -3.63  7.52

``` r
mean_and_sd(list_norm[["d"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  7.61  10.6

## Use a for loop

Create output list, and run a for loop We have 4 lists of normal
(a,b,c,d). For any of those, we have an output list to catch each output
separately

``` r
output = vector("list", length = 4)

for (i in 1:4)  {
  
  output[[i]] = mean_and_sd(list_norm[[i]])
}

output
```

    ## [[1]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 0.406  3.98
    ## 
    ## [[2]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  4.31  5.11
    ## 
    ## [[3]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -3.63  7.52
    ## 
    ## [[4]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  7.61  10.6
