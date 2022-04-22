#' ---
#' title: 'Target Practice with **ggplot2** and **ggimage**'
#' author: "`r Sys.getenv('USERNAME')`"
#' output: md_document
#' ---
#+ setup, include=FALSE
knitr::opts_chunk[['set']](collapse=FALSE, message=FALSE, warning=FALSE, prompt=FALSE)
#+ libs
library(ggimage)

# credits for `circleFun()` go to
# * https://stackoverflow.com/a/6863490
# * https://stackoverflow.com/a/19296181
# 
# bullet hole is licensed under the creative commons license and available at
# https://www.vhv.rs/viewpic/hTJRihb_bullet-png-free-image-download-bullet-hole-transparent/

circleFun = function(
    center = c(0, 0)
    , diameter = 1
    , npoints = 100
) {
  r = diameter / 2
  tt = seq(0, 2*pi, length.out = npoints)
  xx = center[1] + r * cos(tt)
  yy = center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

## create circles with decrementing diameter
diameters = seq(0.05, 0.005, -0.005)

circles = Map(
  \(i) {
    circleFun(
      c(0.78, 0.78)
      , diameter = i
      , npoints = 100
    )
  }
  , diameters
) |> 
  data.table::rbindlist(
    idcol = "ring"
  )

## specify ring colors
colors = rep(
  c("#ddc385", "black")
  , each = 5L
)
names(colors) = as.character(1:10)

## create target plot
p0 = ggplot(
  circles
  , aes(x, y, fill = factor(ring))
) + 
  geom_polygon(
    color = "grey85"
    , show.legend = FALSE
  ) + 
  scale_fill_manual(
    values = colors
  ) + 
  coord_fixed() + 
  theme_bw() + 
  theme(
    panel.grid = element_blank()
  )

## add some bullet holes
set.seed(1899L)

dat = matrix(
  runif(
    20L
    , min = 0.78 - 0.025
    , max = 0.78 + 0.025
  )
  , ncol = 2L
  , dimnames = list(NULL, c("x", "y"))
)

dat = data.frame(
  dat
  , image = "inst/extdata/bullet_hole.png"
)

p0 + 
  geom_image(
    aes(
      x = x
      , y = y
      , image = image
    )
    , data = dat
    , inherit.aes = FALSE
  )

#'
#' ### ZZ. Final things last
#'
#' <details><summary>Session info (click to view)</summary>
devtools::session_info()
#' </details>