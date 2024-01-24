pacman::p_load(
  shiny, 
  bslib,
  ggpubr,
  ggplot2
  )

source("scripts/script_clean.R")

glimpse(dengue_env)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  titlePanel("Dengue fever management"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("area_type","Area type",levels(data$area_type)),
      selectInput("house_type", "House type", levels(data$house_type))
    ),
    mainPanel(
      navset_card_underline(
        title = "Infrastructure Assessment",
        nav_panel("Data visualization", titlePanel("Data visualization"), plotOutput("ll_by_area_type")),
        nav_panel("Interpretation", titlePanel("Interpretation"), plotOutput("ll_by_area_type")),
        nav_panel("Recommendation", titlePanel("Recommendation"), plotOutput("ll_by_area_type"))
      ),
      p("Graph description"),
      tags$ul(
        tags$li(tags$b("Area"), " - the are of Dhaka district were dengue fever cases have been confirmed"),
        tags$li(tags$b("area_type"), " - the area type the case was confirmed"),
        tags$li(tags$b("house_type"), " - the house type the case was confirmed")
        )
      )
    )
  )

# Define server logic required to draw a histogram
server <- function(input, output) {
  filtered_data <- reactive({
    dengue_env <- dengue_env %>% filter(area_type == input$area_type & 
                             house_type == input$house_type)
  })
  
  output$ll_by_area_type <- renderPlot({
    ll_by_area_type <- filtered_data() %>%   
      tally()
    
      ggplot(ll_by_area_type, aes(x=area, y=n, fill=area_type)) + geom_col() +
      labs(title = "Distribution by area type", x = "Area in Dhaka", y = "Number of cases") + 
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
