############################################
## Create pdf with model simulations
UIreport <- function() {
  
    box(
            width=12,title="Reporting information", solidHeader = TRUE, status = "primary",collapsible = F, 
            # Set title of report
            fluidRow(
              column(4,  HTML('Report title')),
              column(8,textInput(  "title", placeholder='Report title',label=NULL))
            ),
            fluidRow(
              column(4,  HTML('Report author')),
              column(8,textInput("author", placeholder='Author name',label=NULL))
            ),
            # Set compound name
            fluidRow(
              column(4,  HTML('Compound name')),
              column(8,textInput(  "cmp_name", placeholder='Compound x',label=NULL))
            ),
            # Add description text to the report
            fluidRow(
              column(4,  HTML('Description')),
              column(8,  textAreaInput("description", placeholder= 'Description', height=150,width = "100%",label=NULL))
            ),
            
            # Start report rendering
            fluidRow(
              column(6,  downloadButton("report", "Generate report",style='background-color: #FF9933; ',width='100%'))
              
            )
            
          )
          
          
          
          
  
  
}


