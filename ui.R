
# input -------------------------------------------------------------------

input_data_tab<-function(){
  tabItem(tabName = "input_data_tab",
          fluidRow(
            box(width=12,title=NULL,
                includeMarkdown("save_data.md"))
          ),
          fluidRow(
            box(width=12,title="",
                textInput(inputId="name",label="Name",placeholder="Change placeholder")%>%
                  shinyInput_label_embed(
                    icon("info") %>%
                      bs_embed_tooltip(title = "Please enter your full name.")
                  ),
                textInput(inputId="availability",label="Availability",placeholder="Change placeholder")%>%
                  shinyInput_label_embed(
                    icon("info") %>%
                      bs_embed_tooltip(title = "Please choose the time that suits you the best from the time mentioned in the banner.")
                  ),
                actionBttn("save", "Save", style = "fill", block = TRUE, no_outline = FALSE, color = "danger")
            )
            
          )
  )
}

# browse tab function ------------------------------------------------------------------

browse_data_tab<-function(){
  tabItem(tabName = "browse_data_tab",
          fluidRow(
            box(width=12, title=NULL,
                includeMarkdown("browse_data.md"))
          ),
          fluidRow(
            box(width=12, title="Pool Result",
                withSpinner(DT::dataTableOutput('data')),
                downloadButton("download_data")
            )
          )
          
  )
}

# live chat function ------------------------------------------------------------------

live_chat_tab<-function(){
  tabItem(tabName = "live_chat_tab",
          
          bootstrapPage(
            # We'll add some custom CSS styling -- totally optional
            includeCSS("shinychat.css"),
            
            # And custom JavaScript -- just to send a message when a user hits "enter"
            # and automatically scroll the chat window for us. Totally optional.
            includeScript("sendOnEnter.js"),
            
            div(
              # Setup custom Bootstrap elements here to define a new layout
              class = "container-fluid", 
              div(class = "row-fluid",
                  # Set the page title
                  tags$head(tags$title("ShinyChat")),
                  
                  br()
                  
                  # Create the header
                  # div(class="span6", style="padding: 10px 0px;",
                  #     h1("ShinyChat"), 
                  #     h4("Hipper than IRC...")
                  # ), div(class="span6", id="play-nice",
                  #   "IP Addresses are logged... be a decent human being."
                  # )
                  
              ),
              # The main panel
              div(
                class = "row-fluid", 
                mainPanel(
                  # Create a spot for a dynamic UI containing the chat contents.
                  uiOutput("chat")
                ),
                # The right sidebar
                sidebarPanel(
                  # Let the user define his/her own ID
                  h4("User Name:"),
                  textInput("user", NULL, value=""),
                  tags$hr(),
                  h4("Connected Users:"),
                  # Create a spot for a dynamic UI containing the list of users.
                  uiOutput("userList"),
                  # Create the bottom bar to allow users to chat.
                  hr(),
                  div(class="span10",
                      textAreaInput("entry", NULL)
                  ),
                  div(class="span2 center",
                      actionBttn("send", "Send", style = "fill", block = TRUE, no_outline = FALSE, color = "danger")
                  )
                  #tags$hr(),
                  #helpText(HTML("<p>Built using R & <a href = \"http://rstudio.com/shiny/\">Shiny</a>.<p>Source code available <a href =\"https://github.com/trestletech/ShinyChat\">on GitHub</a>."))
                )
              )
            )
          )
          
  )
}

# Developer tab function ------------------------------------------------------------------

developer_tab<-function(){
  tabItem(tabName = "developer_tab",
          # fluidRow(
          #   box(width=12, title=NULL,
          #       includeMarkdown("browse_data.md"))
          # ),
          # fluidRow(
          #   box(width=12, title="Pool Result",
          #       withSpinner(DT::dataTableOutput('data')),
          #       downloadButton("download_data")
          #   )
          # )
          fluidRow(
            div(
              class="container-fluid",
              div(class="row-fluid",
                  div(class="span6",
                      h2("Terminal"),  
                      aceEditor("code", mode="r", value="list(sql = list.files(pattern = \"sqlite\"),
    R_file = list.files(pattern = \"R\"),
    info = sessionInfo())"),
                      actionBttn("eval", "Evaluate", style = "fill", block = TRUE, color = "danger")
                  ),
                  div(class="span6",
                      h2("Output"),
                      verbatimTextOutput("code_output")
                  )
              )
            )
          )
          #
          ##
          #
          
  )
}

# browse tab function ------------------------------------------------------------------

about_tab<-function(){
  tabItem(tabName = "about_tab",
          fluidRow(
            box(width=12, title=NULL,
                
                tags$h5("This app is developed using", 
                        tags$a("R", href = "https://www.r-project.org/"), " and ", 
                        tags$a("shiny", href = "https://shiny.rstudio.com/"), "under", 
                        tags$a("MIT", href = "https://opensource.org/licenses/MIT"), "license."),
                br(),
                # tags$blockquote("Copyright  2019  Wanjun Gu"),
                # tags$blockquote("Permission is hereby granted, free of charge, 
                #                 to any person obtaining a copy of this software
                #                 and associated documentation files (the \"software\"),
                #                 to deal in the software without restriction, including 
                #                 without limitation the rights to use, copy, modify,
                #                 merge, publish, distribute, sublicense, and/or sell 
                #                 copies of the software, and to permit persons to whom
                #                 the software is furnished to do so, subject to the 
                #                 following conditions:"),
                # tags$blockquote("The above copyright notice and this permission notice 
                #                 shall be included in all copies or substantial portions
                #                 of the software."),
                # tags$blockquote("The software is provided \"as is\", without warranty
                #                 of any kind, express or implied, including but not limited to the warranties of 
                #                 merchantability, fitness for a particular purpose and noninfringement. in no event s
                #                 hall the authors or copyright holders be liable for any claim, damages or other liability,
                #                 whether in an action of contract, tort or otherwise, arising from, out of or in
                #                 connection with the software or the use or other dealings in the software."),
                tags$h5("Users can modify md files shown in \"Select When\" and \"See Result\" tab
                        to specify their needs. Developer's mode is deisgned for people who want to
                        have more access to the backend processes of the application. However, 
                        uncoutious actions may cause server malfunction. As MIT license states,
                        developers of Meeting Schedule will not be responsible for any technical 
                        issues of the application."),
                hr(),
                tags$p("The source code of this project can be found on Github."),
                tags$p("Project Github Repo: ", a("Meeting Scheduler", 
                                                  href="https://github.com/Broccolito/CES_Meeting_Helper"))
                
                
            )
          )
          
  )
}

# Dashboard ---------------------------------------------------------------

dashboardPage(
  skin = "black",
  dashboardHeader(title = "Meeting Scheduler"),
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Select When", tabName = "input_data_tab", icon=icon("poll")),
      menuItem("See Result",tabName = "browse_data_tab",icon = icon("eye")),
      menuItem("Live Chat", tabName = "live_chat_tab", icon = icon("comment-dots")),
      menuItem("Developer", tabName = "developer_tab", icon = icon("cogs")),
      menuItem("About", tabName = "about_tab", icon = icon("address-card"))
    )
    
  ),
  dashboardBody(
    #tags$head(includeScript("tracking.js")),
    useShinyjs(),
    #    shinyjs::inlineCSS(appCSS),
    tags$head(tags$style(HTML("
    .shiny-split-layout > div {
    overflow: visible;
    }
  "))),
    tabItems(
      input_data_tab(),
      browse_data_tab(),
      live_chat_tab(),
      developer_tab(),
      about_tab()
    ),
    use_bs_tooltip()
  )
)
