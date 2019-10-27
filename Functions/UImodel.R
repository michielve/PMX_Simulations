UImodel <- function() {
  
  
  
  fluidRow(
   
    box(solidHeader = TRUE, status = "primary",collapsible = F,title="Insert model parameters",width=12,
        
        fluidRow(
          column(5,  HTML('Model structure')),
          column(6,  
                 selectInput('cmt_structural', label=NULL, c("1 CMT","2 CMT","3 CMT")))
        ),
        
        
        ## Insert parameters in main panel
        fluidRow(
          column(5,  style='border-bottom:0px solid;', HTML('<b>Parameter</b>')),
          column(3,  style='border-bottom:0px solid; padding: 0px;',HTML('<b>Value</b>')),
          column(3,  style='border-bottom:0px solid; padding: 0px;',HTML('<b>Variance (&omega;<sup>2</sup>)</b>'))
          
        ),
        
        
        ########################
        ## absorption rate
        conditionalPanel(
          condition = "input.admin == 'Depot'",
          
          fluidRow(
            column(5,  HTML('Absorption rate constant (/h)')),
            column(3,  style='padding:0px;',
                   numericInput("ka", label=NULL, value = 1,min=0)),
            column(3,  style='padding:0px;',
                   numericInput("etaka", label=NULL, value = 0,min=0,step = 0.01))
          )
        ),
        
        ########################
        ## Central volume of distribution
        fluidRow(
          column(5,  HTML('Central volume of distribution (L)')),
          column(3,  style='padding:0px;',
                 numericInput("vd", label=NULL, value = 10,min=0)),
          column(3,  style='padding:0px;',
                 numericInput("etavd", label=NULL, value = 0.09,min=0,step = 0.01))
        ),
        
        
        ########################
        ## Periperhal volume of distribution
        conditionalPanel(
          condition = "input.cmt_structural != '1 CMT'",
          
          fluidRow(
            column(5,  HTML('Periperhal volume of distribution (L)')),
            column(3,  style='padding:0px;',
                   numericInput("vd2", label=NULL, value = 1,min=0)),
            column(3,  style='padding:0px;',
                   numericInput("etavd2", label=NULL, value = 0,min=0,step = 0.01))
          )
        ),
        ########################
        ## Periperhal volume of distribution 2
        conditionalPanel(
          condition = "input.cmt_structural == '3 CMT'",
          
          fluidRow(
            column(5,  HTML('Periperhal volume of distribution 2 (L)')),
            column(3,  style='padding:0px;',
                   numericInput("vd3", label=NULL, value = 1,min=0)),
            column(3,  style='padding:0px;',
                   numericInput("etavd3", label=NULL, value = 0,min=0,step = 0.01))
          )
        ),
        
        ########################
        ## Q 1
        conditionalPanel(
          condition = "input.cmt_structural != '1 CMT'",
          
          fluidRow(
            column(5,  HTML('Q - central-peripheral (L/h)')),
            column(3,  style='padding:0px;',
                   numericInput("q1", label=NULL, value = 1,min=0)),
            column(3,  style='padding:0px;',
                   numericInput("etaq1", label=NULL, value = 0,min=0,step = 0.01))
          )
        ),
        
        ########################
        ## Q 2
        conditionalPanel(
          condition = "input.cmt_structural == '3 CMT'",
          
          fluidRow(
            column(5,  HTML('Q - central-peripheral 2 (L/h)')),
            column(3,  style='padding:0px;',
                   numericInput("q2", label=NULL, value = 1,min=0)),
            column(3,  style='padding:0px;',
                   numericInput("etaq2", label=NULL, value = 0,min=0,step = 0.01))
          )
        ),
        
        ########################
        ## Clearance
        fluidRow(
          column(5,  HTML('Clearance (L/h)')),
          column(3,  style='padding:0px;',
                 numericInput("cl", label=NULL, value = 1,min=0)),
          column(3,  style='padding:0px;',
                 numericInput("etacl", label=NULL, value = 0.09,min=0,step = 0.01))
        ),
        
        
        ########## Residual
        
        fluidRow(
          column(5,  style='border-bottom:0px solid;', HTML('<b>Residual error</b>'))
          
        ),
        
        ########################
        ## proportional
        fluidRow(
          column(5,  HTML('&sigma;<sup>2</sup> proportional')),
          column(3,  style='padding:0px;',
                 numericInput("sigmaprop", label=NULL, value = 0,min=0,step = 0.005))
        ),
        ########################
        ## proportional
        fluidRow(
          column(5,  HTML('&sigma;<sup>2</sup> additive')),
          column(3,  style='padding:0px;',
                 numericInput("sigmaadd", label=NULL, value = 0,min=0,step = 0.01))
        )
    
        
    )
  )
  
}


