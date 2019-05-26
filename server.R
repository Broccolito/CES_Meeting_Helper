function(input, output, session) {
  
  ##########################################################################
  #Live chat controller
  ##########################################################################
  
  # Create a spot for reactive variables specific to this particular session 
  sessionVars <- reactiveValues(username = "")
  
  # Track whether or not this session has been initialized. We'll use this to
  # assign a username to unininitialized sessions.
  init <- FALSE
  
  # When a session is ended, remove the user and note that they left the room. 
  session$onSessionEnded(function() {
    isolate({
      vars$users <- vars$users[vars$users != sessionVars$username]
      vars$chat <- c(vars$chat, paste0(linePrefix(),
                                       tags$span(class="user-exit",
                                                 sessionVars$username,
                                                 "left the room.")))
    })
  })
  
  # Observer to handle changes to the username
  observe({
    # We want a reactive dependency on this variable, so we'll just list it here.
    input$user
    
    if (!init){
      # Seed initial username
      sessionVars$username <- paste0("User", round(runif(1, 10000, 99999)))
      isolate({
        vars$chat <<- c(vars$chat, paste0(linePrefix(),
                                          tags$span(class="user-enter",
                                                    sessionVars$username,
                                                    "entered the Conference.")))
      })
      init <<- TRUE
    } else{
      # A previous username was already given
      isolate({
        if (input$user == sessionVars$username || input$user == ""){
          # No change. Just return.
          return()
        }
        
        # Updating username      
        # First, remove the old one
        vars$users <- vars$users[vars$users != sessionVars$username]
        
        # Note the change in the chat log
        vars$chat <<- c(vars$chat, paste0(linePrefix(),
                                          tags$span(class="user-change",
                                                    paste0("\"", sessionVars$username, "\""),
                                                    " changed name to ",
                                                    paste0("\"", input$user, "\""))))
        
        # Now update with the new one
        sessionVars$username <- input$user
      })
    }
    # Add this user to the global list of users
    isolate(vars$users <- c(vars$users, sessionVars$username))
  })
  
  # Keep the username updated with whatever sanitized/assigned username we have
  observe({
    updateTextInput(session, "user", 
                    value=sessionVars$username)    
  })
  
  # Keep the list of connected users updated
  output$userList <- renderUI({
    tagList(tags$ul( lapply(vars$users, function(user){
      return(tags$li(user))
    })))
  })
  
  # Listen for input$send changes (i.e. when the button is clicked)
  observe({
    if(input$send < 1){
      # The code must be initializing, b/c the button hasn't been clicked yet.
      return()
    }
    isolate({
      # Add the current entry to the chat log.
      vars$chat <<- c(vars$chat, 
                      paste0(linePrefix(),
                             tags$span(class="username",
                                       tags$abbr(title=Sys.time(), sessionVars$username)
                             ),
                             ": ",
                             tagList(input$entry)))
    })
    # Clear out the text entry field.
    updateTextInput(session, "entry", value="")
  })
  
  # Dynamically create the UI for the chat window.
  output$chat <- renderUI({
    if (length(vars$chat) > 500){
      # Too long, use only the most recent 500 lines
      vars$chat <- vars$chat[(length(vars$chat)-500):(length(vars$chat))]
    }
    # Save the chat object so we can restore it later if needed.
    saveRDS(vars$chat, "chat.Rds")
    
    # Pass the chat log through as HTML
    HTML(vars$chat)
  })
  
  ##########################################################################
  
  dataset_to_save<-reactive({
    my_data <- tibble(
      name=input$name,
      availability=input$availability)
    return(my_data)})
  
  registerData<-observeEvent(input$save,{
    
    my_dataset<-dataset_to_save()
    
    withProgress(message="Registering",value=0.2,{
      dbWriteTable(conn, datatable, my_dataset,append=TRUE)
    }) 
    showModal(modalDialog(
      
      title = "Thank you!",
      "Data has been saved"
    ))
  })
  allData<-function(){
    
    my_data<-tbl(conn,datatable)%>%collect()
    shiny::validate(need(nrow(my_data)>0,"no data"))
    return(my_data)
  }
  output$data <- DT::renderDataTable({
    
    data<-allData()
    
    data<-data%>%select(
      everything())
    
    DT::datatable(data,  selection = 'single',
                  filter='top',
                  rownames= FALSE,
                  escape=FALSE,
                  options = list(
                    scrollX = TRUE)
    )
  })
  output$download_data <- downloadHandler(
    filename = function() {
      paste("download_data", ".csv", sep = "")
    },
    content = function(file) {
      write_csv(allData(), file)
    }
  )
  
  ##########################################################################
  #Developer Tab Controller
  ########################################################################## 
  output$code_output <- renderPrint({
    input$eval
    return(isolate(eval(parse(text=input$code))))
  }) 
  
}
