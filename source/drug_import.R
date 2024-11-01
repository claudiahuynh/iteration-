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
