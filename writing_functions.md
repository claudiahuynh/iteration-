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

    ##  [1]  0.25515995  0.48598760 -2.00531678  0.23707246 -0.73166767 -0.71012901
    ##  [7] -1.04081482 -0.17777850 -1.16523074 -0.04730929  1.36706657 -1.11034355
    ## [13] -0.27418169 -0.17678379 -0.44046111  2.10700387  0.91768707  0.86262844
    ## [19]  0.46748068 -0.54839990 -1.46292844  1.62185498  0.45887012  0.02530461
    ## [25]  1.08522895

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

    ##  [1]  0.25515995  0.48598760 -2.00531678  0.23707246 -0.73166767 -0.71012901
    ##  [7] -1.04081482 -0.17777850 -1.16523074 -0.04730929  1.36706657 -1.11034355
    ## [13] -0.27418169 -0.17678379 -0.44046111  2.10700387  0.91768707  0.86262844
    ## [19]  0.46748068 -0.54839990 -1.46292844  1.62185498  0.45887012  0.02530461
    ## [25]  1.08522895

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

## A new function

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

mean_and_sd(x_vec)
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  9.80  3.73

## Check stuff using a simulation

``` r
sim_df = 
  tibble(
    x = rnorm(30,10,5)
  )

sim_df |> 
  summarize(
    mean = mean(x),
    sd = sd(x)
  )
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  8.87  4.26

Simulation function to check sample mean and sd

``` r
sim_mean_sd = function(samp_size, true_mean, true_sd) {
  sim_df = 
    tibble(
      x = rnorm(samp_size, true_mean, true_sd)
  )

out_df = 
  sim_df |> 
  summarize(
    mean = mean(x),
    sd = sd(x)
  )

return(out_df)
}
sim_mean_sd(samp_size = 3000, true_mean = 4, true_sd = 12)
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  3.90  11.9

## Revisit LoTR words

``` r
fellowship_df = 
  read_excel("data/LoTR_Words.xlsx", range = "B3:D6") |> 
  mutate(movie = "fellowship") |> 
  janitor::clean_names()

two_towers_df = 
  read_excel("data/LoTR_Words.xlsx", range = "F3:H6") |> 
  mutate(movie = "two_towers") |> 
  janitor::clean_names()

return_king_df = 
  read_excel("data/LoTR_Words.xlsx", range = "J3:L6") |> 
  mutate(movie = "return_king") |> 
  janitor::clean_names()
```

Do this using a function instead What are the inputs (stuff that change?
like cell range, movie title)

``` r
lotr_import = function(cell_range, movie_title) {
  
  movie_df = 
    read_excel("data/LoTR_Words.xlsx", range = cell_range) |> 
    mutate(movie = movie_title) |> 
    janitor::clean_names() |> 
    pivot_longer(
      cols = female:male,
      names_to = "sex",
      values_to = "words"
    ) |> 
    select(movie, everything())

  return(movie_df)
  
}

lotr_df = bind_rows(
  lotr_import(cell_range = "B3:D6", movie_title = "fellowship"),
  lotr_import(cell_range = "F3:H6", movie_title = "two_towers"),
  lotr_import(cell_range = "J3:L6", movie_title = "return_king")
)
```

## NSDUH

``` r
nsduh_url = "http://samhda.s3-us-gov-west-1.amazonaws.com/s3fs-public/field-uploads/2k15StateFiles/NSDUHsaeShortTermCHG2015.htm"

nsduh_html = read_html(nsduh_url)

marj_table = 
  nsduh_html |> 
  html_table() |> 
  nth(1) |> 
  slice(-1) |> 
  mutate(drug = "marj")

cocaine_table = 
  nsduh_html |> 
  html_table() |> 
  nth(4) |> 
  slice(-1) |> 
  mutate(drug = "cocaine")

heroin_table = 
  nsduh_html |> 
  html_table() |> 
  nth(5) |> 
  slice(-1) |> 
  mutate(drug = "heroin")
```

Function that does data import from NSDUH

``` r
drug_import = function(html, nth, drug) {

  out_table = 
    html |> 
    html_table() |> 
    nth(nth) |> 
    slice(-1) |> 
    mutate(drug = drug) |> 
    select(-contains("P Value"))
  
  return(out_table)
}
drug_table = 
  bind_rows(
    drug_import(html = nsduh_html, nth = 1, drug = "marj"),
    drug_import(html = nsduh_html, nth = 4, drug = "cocaine"),
    drug_import(html = nsduh_html, nth = 1, drug = "heroin")
  )
```

Can also save the function in a source folder (not necessary, but can be
more efficient)

``` r
source("source/drug_import.R")

drug_table = 
  bind_rows(
    drug_import(html = nsduh_html, nth = 1, drug = "marj"),
    drug_import(html = nsduh_html, nth = 4, drug = "cocaine"),
    drug_import(html = nsduh_html, nth = 1, drug = "heroin")
  )
```

ˆ
