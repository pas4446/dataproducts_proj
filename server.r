# Baseball Trends App - Server

library(shiny)
library(ggplot2)
library(plyr)

# functions for statistics
# calculate batting average: http://en.wikipedia.org/wiki/Batting_average
BA <- function(b.data){
    round(sum(b.data$h,na.rm=T) / sum(b.data$ab,na.rm=T), 3)
}

# calculate OBP: http://en.wikipedia.org/wiki/On_base_percentage
OBP <- function(b.data){
    with(b.data,round(sum(h + bb + ibb + hbp,na.rm=T)/
                          sum(ab + bb + ibb + hbp + sh + sf,na.rm=T), 3))
}

# calculate SLG: http://en.wikipedia.org/wiki/Slugging_percentage
SLG <- function(b.data){
    with(b.data,round(sum(h-X2b-X3b-hr + 2*X2b + 3*X3b + 4*hr,na.rm=T) / sum(ab,na.rm=T), 3))
}

# calculate OPS: http://en.wikipedia.org/wiki/On_base_plus_slugging
OPS <- function(b.data){
    with(b.data,round(sum(h + bb + ibb + hbp,na.rm=T)/sum(ab + bb + ibb + hbp + sh + sf,na.rm=T) + 
                          sum(h-X2b-X3b-hr + 2*X2b + 3*X3b + 4*hr,na.rm=T) / sum(ab,na.rm=T), 3))
}

# calculate k/bb ratio: http://en.wikipedia.org/wiki/Strikeout-to-walk_ratio
K_BB <- function(b.data){
    with(b.data,round(sum(so,na.rm=T) / sum(bb,na.rm=T), 3))
}



shinyServer(function(input, output) { 
    
    ## baseball dataset from plyr package, subset by years
    sub_baseball <- reactive({
        data(baseball)
        subset(baseball, year >= input$years[1] & year <= input$years[2])
    })
    
    output$test1 <- renderText({
        sub_baseball <- sub_baseball()
        nrow(sub_baseball)
    })
        
    ## get desired metric by year
    final_data <- reactive({
        sub_baseball <- sub_baseball()
        
        if (input$statistic == "BA") func <- BA
        else if (input$statistic == "OBP") func <- OBP
        else if (input$statistic == "SLG") func <- SLG
        else if (input$statistic == "OPS") func <- OPS
        else func <- K_BB
        
        if (input$league == "no"){
            ddply(sub_baseball, c("year"),func)
        } else {
            ddply(sub_baseball, c("year","lg"),func)
        }
    })
    
    ## now the actual output

    output$plot <- renderPlot({
        final_data <- final_data()
        
        if (input$statistic == "BA") stat <- "Batting Average"
        else if (input$statistic == "OBP") stat <- "On-Base Percentage"
        else if (input$statistic == "SLG") stat <- "Slugging Percentage"
        else if (input$statistic == "OPS") stat <- "On-Base Plus Slugging"
        else stat <- "Strikes / Walks"
        
        plot <- ggplot(data=final_data,aes(year, V1)) + xlab("Year") + ylab(stat)
        
        if (input$league == "no"){
            plot + geom_line() + ggtitle(paste("MLB",stat,"for",input$years[1],"to",
                                               input$years[2]))
        } else {
            plot + geom_line(aes(color=lg)) + scale_color_discrete(name = "League") +
                ggtitle(paste("MLB",stat,"for",input$years[1],"to",input$years[2],"by League"))
        }
    })
    
})