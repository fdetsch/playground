library(data.table)

## conversion from/to `data.frame`
dt = setDT(
  copy(iris)
)

df = setDF(
  copy(dt)
)

## select 1 col
dt[, Species] # factor
dt[, "Species"] # data.table

## select 2+ cols
dt[, c("Species", "Sepal.Length")]
dt[, .(Species, Sepal.Length)]

## drop columns
dt[, !"Species"]

## use `.SD` without `.SDcols`
dt[
  , lapply(
    .SD[, 1:4]
    , mean
  )
  , by = Species
]

## set keys to speed up binary search
?setkey

# Resources
# * https://hutsons-hacks.info/data-table-everything-you-need-to-know-to-get-you-started-in-r