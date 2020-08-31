### continuous range ----

a = 1:3
b = 10:12
d = c(a, b)

out = expand.grid(rep(list(d), length(a)))
ids = logical(nrow(out))
for (i in 1:nrow(out)) {
  ids[i] = any(duplicated(unlist(out[i, ])))
}

out = out[!ids, ]
out


### min, max ---

combiner = function(x, y = x) {
  out = vector("list"); n = 1
  for (i in x) {
    for (j in y) {
      # if (i %in% j) {
      #   next
      # }
      
      out[[n]] = c(i, j)
      n = n + 1
    }
  }
  return(out)
}

wrapper = function(x = list(c(1, 10), c(2, 11), c(3, 12)), n = length(x)) {
  for (h in (n - 1):1) {
    out = if (h == n - 1) {
      combiner(x[[h]], x[[h + 1]])
    } else {
      combiner(x[[h]], out)
    }
  }
  return(out)
}

wrapper(list(c(1, 10), c(1, 11), c(3, 12), c(4, 12)))

## test: ndvi
sapply(
  wrapper(x = list(c(1, 10), c(2, 11)))
  , function(i) {
    (i[1] - i[2]) / (i[1] + i[2])
  }
)
