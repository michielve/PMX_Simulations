UIsiminfo <- function() {
  
  
  
  fluidRow(
    box(title="Dosing and simulation information", solidHeader = TRUE, width=12, status = "primary",collapsible = F ,
        
        
        fluidRow(
          column(6,  HTML('<b>Route of administration</b>')),
          column(6,  
                 selectInput('admin', label=NULL, c("Depot","I.V. bolus","I.V. Infusion")))
        ),
        
          fluidRow(
            column(6,  HTML('<b>Dose (units) </b><br><em> (Add multiple cohorts: 100, 200, 300)</em>')),
            column(6,textInput(  "dos", value=100, label=NULL))

        ),
        
        
        
        ## Include infusion time when there is an infusion
        conditionalPanel(
          condition = "input.admin == 'I.V. Infusion'",
          fluidRow(
            column(6,  HTML('<b>Infusion time (h)</b>')),
            column(6,  
                   numericInput("dur", label=NULL, value = 1,min=0))
          )
          
        ),
        
        
        fluidRow(
          column(6,  HTML('<b>Repeat dose every x hours</b>')),
          column(6,  
                 numericInput("int", label=NULL, value = 12,min=0))
        ),
        tags$hr(),
        
        h4("Additonal simulation information"),
        
        fluidRow(
          column(6,  HTML('<b>Simulate for x hours</b>')),
          column(6, 
                 numericInput("sim_time", label=NULL, value = 12,min=0))
        ),
        
        fluidRow(
          column(6,  HTML('<b>Simulated number of individuals</b>')),
          column(6, 
                 numericInput("nsamples", label=NULL, value = 100,min=0))
        )
        

        
        
    )
  )
  
}



















