---
title       : Baseball Trends App
subtitle    : Developing Data Products
author      : Preston Smith
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

## Motivation

Baseball has always been a game of numbers. The *baseball* dataset in the *plyr* R package allows us to analyze some of the basic baseball statistics that have been measured going back to 1871. It's easy enough to look at things like the number of home runs by year in this dataset with a few lines of code.




```r
hr <- ddply(baseball, "year", function(data) sum(data$hr))
ggplot(data=hr,aes(year, V1)) + geom_line() + xlab("Year") + ylab("Home Runs")
```

<img src="assets/fig/unnamed-chunk-2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

---


## Baseball Trends App

What if we want to change the statistic, compare by leagues, or limit the range of years to focus on a certain time period? We could write separate code each time, or simply use the Baseball Trends App.

<img src="assets/img/app-default.png" alt="Default" style="width: 1000px;"/>

---

## Example

Perhaps we want to see how much of an increase in OPS took place during the steroid era while also looking at how the American League's designated hitter gives them an edge compared to the National League. After a few selections, you quickly have the desired plot.

<img src="assets/img/steroid_league.png" alt="Default" style="width: 1000px;"/>

---

## Conclusion

This app is a quick way for baseball fans to look at various hitting trends over time. The breakout by league adds one more dimension to play with. The Baseball Trends App is a fun tool that could be used by fans to get quick graphs or even inserted into a baseball website for visitors to play with.




