```@setup data
root = pwd() |> dirname |> dirname
f = joinpath(root, "test", "assets", "burneyex.cex")
```

# The `data` function

The `data` function can:

- select data lines from a list of `Block`s for a specified block type
- optionally filter data by a URN value

It always returns a (possibly empty) Vector of string values representing CEX data lines.





## Filter by URN