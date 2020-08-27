library(ggplot2)
library(plotly)
library(slickR)

ggiris = qplot(Petal.Width, Sepal.Length, data = iris, color = Species)


### . w/carousel ----
### (https://cran.r-project.org/web/packages/slickR/vignettes/plots.html)

p1 = ggplotly(ggiris, width = 600)
lst1 = lapply(1:3, function(i) p1)

slick_up = slickR(
  lst1
  , slideType = "iframe"
  , height = 475
)

lst2 = lapply(
  1:3
  , function(i) {
    svglite::xmlSVG(
      code = {
        show(ggiris + theme(plot.margin = unit(c(2, 1, 1.5, 1.2), "cm")))
      }
      , standalone = TRUE
      , height = 5
    )
  }
)

slick_down = slickR(
  lst2
  , height = 100
) + 
  settings(
    slidesToScroll = 1
    , slidesToShow = 3
    , centerMode = TRUE
    , focusOnSelect = TRUE
  )

slick_up %synch% slick_down


### . w/dots ----
### (https://cran.r-project.org/web/packages/slickR/vignettes/iframes.html)

# https://cran.r-project.org/web/packages/slickR/vignettes/iframes.html

slickR::slickR(
  lst1
  , slideType = 'iframe'
  , height = 500
) + 
  settings(
    dots  = TRUE
  )
