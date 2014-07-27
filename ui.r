# Baseball Trends App - UI

library(shiny)

shinyUI(fluidPage(
    titlePanel("Baseball Trends"),
    
    sidebarLayout(
        sidebarPanel(img(src = "mlb.png", height = 195, width = 195),
                     selectInput("statistic", label = h5("Choose a Stat"), 
                                 choices = list("Batting Average" = "BA", 
                                                "On-Base Percentage" = "OBP", 
                                                "Slugging Percentage" = "SLG",
                                                "On-Base Plus Slugging" = "OPS", 
                                                "Strikes / Walks" = "K_BB"),
                                                selected = "BA"),
                     radioButtons("league", label = h5("Compare Leagues?"), 
                                 choices = list("Yes" = "yes", "No" = "no"), selected = "no"),
                     sliderInput("years", "Date Range",
                                 min = 1871, max = 2007, value = c(1871, 2007), format="####"),
                     submitButton("Update Trend"),
                     br(),
                     p("For definitions of statistics, vist ",
                       a("Wikipedia.",
                         href = "http://en.wikipedia.org/wiki/Baseball_statistics")),
                     p("Note that metrics needed for OBP and OPS weren't available until 1955.")
                    ),
        
        mainPanel(
            tabsetPanel(
                tabPanel("Plot",plotOutput("plot")),
                tabPanel("Documenation",p("The Baseball Trends App allows the user to look at general trends that occurred over time in Major League Baseball. Once open, the app requires the user to specify a few fields to obtain a specific trend. Choose a stat: This drop-down allows the user to choose one of five baseball statistics to be displayed. The choices are Batting Average, On-Base Percentage, Slugging Percentage, On-Base Plus Slugging, and Strikes / Walks. Compare Leagues: Choose if you want to break out by the various leagues. Choosing No will display one black line that shows the trend for Major League Baseball as a whole, while choosing Yes will split the data by league and show one trendline for each league that existed in the given timeframe. Date Range: Use the slider to choose a set of years you wish to focus on. The dataset has data from 1871 to 2007. Update Trend: Once the previous three filters have been set, press the Update Trend button to update the plot with the new filters."))
            )
        )
    )
))