UIreport <- function() {
  
    box(
            width=12,title="Reporting information", solidHeader = TRUE, status = "primary",collapsible = F, 
            
            
            fluidRow(
              column(4,  HTML('Report title')),
              column(8,textInput(  "title", placeholder='Report title',label=NULL))
            ),
            
            fluidRow(
              column(4,  HTML('Compound name')),
              column(8,textInput(  "cmp_name", placeholder='Compound x',label=NULL))
            ),
            
            fluidRow(
              column(4,  HTML('Description')),
              column(8,  textAreaInput("description", placeholder= 'Description', height=150,width = "100%",label=NULL))
            ),
            
            fluidRow(
              
              column(6,  downloadButton("report", "Generate report",style='background-color: #FF9933; ',width='100%'))
              
            )
            
          )
          
          
          
          
  
  
}


