# June 2020
# http://therbootcamp.github.io

# Skript um alle nötigen Pakete zu installieren

Bootcamp_package_installation <- function() {
  
  installed_packages <- rownames(installed.packages())
  
  
  # Critical packages 
  critical <- c(
    
    # Utilities --------------
    # "devtools",
    
    # Tidyverse --------------
    
    "tidyverse"
    
  )
  
  # Optional packages
  optional <- c(
    
    # Plotting --------------
    "patchwork", 
    "ggmap",
    "plotly",
    "viridis",
    "ggthemes"
    )
  
  
  message("Welcome to the R Bootcamp!")
  message("We will now install some packages - this could take a while ...")
  
  critical_not_installed <- c()
  optional_not_installed <- c()
  
  for(package.i in sort(critical)) {
    
    if((package.i %in% installed_packages) == FALSE) {
      
      if(package.i == "Rcpp"){
        test <- try(install.packages(package.i))
        if(is.null(test)){
        } else {
          message(paste("Error: could not install package Rcpp"))
        }
      } else {
        install.packages(package.i)
      }
      
    }
    
    # If package wasn't installed, then send us an email
    if((package.i %in% rownames(installed.packages())) == FALSE) {
      
      critical_not_installed <- c(critical_not_installed, package.i)
      
    }
    
  }
  
  
  for(package.i in sort(optional)) {
    
    if((package.i %in% installed_packages) == FALSE) {
      
      if(package.i == "Rcpp"){
        test <- try(install.packages(package.i))
        if(is.null(test)){
          # message(paste("Installiere", package.i, "..."))
        } else {
          message(paste("Error: could not install package Rcpp"))
        }
      } else {
        install.packages(package.i)
      }
      
    }
    
    
    # If package wasn't installed, then send us an email
    if((package.i %in% rownames(installed.packages())) == FALSE) {
      
      optional_not_installed <- c(optional_not_installed, package.i)
      
    }
    
  }
  
  if(length(critical_not_installed) > 0 | length(optional_not_installed) > 0) {
    
    message("*** Bericht ***")
    
    warning(paste("The critical packages [", 
                  paste(critical_not_installed, sep = ", "), 
                  "] and the optional packages [", 
                  paste(optional_not_installed, sep = ", "), 
                  "] could not be installed. Please copy this text and send it to us at therbootcamp@gmail.com so that we can help you.")) 
  } else {
    message("*** Report ***")
    
    message("All packages were successfully installed.")
    
  }
  
  
  
  
  
  
  message("--------------------------------")
  message("See you in the R Bootcamp")
  message("therbootcamp@gmail.com")
  message("www.therbootcamp.com")
  message("--------------------------------")
  
}


# Run code!
Bootcamp_package_installation()