# Clear session at the beginning -----------------------------------------
rm(list = ls())
cat("\014")  


# Read packages (download and install them if needed) --------------------
my_packages <- c()
my_packages <- c("readxl",
"writexl",
"stringr")

for(i in 1:length(my_packages)){
    if(!require(my_packages[i], character.only = TRUE)){
        install.packages(my_packages[i])
        library(my_packages[i], character.only = TRUE) 
    }else{
        library(my_packages[i], character.only = TRUE)
    }# close else...
}# close for(i in 1:length(my_packages)) loop...

source_file_path <- c()
source_file_path <- "C:/Users/Piotrek/Desktop/2026-11-04 Pediatria Otylosc.xlsx"

# Read data from given datapath ------------------------------------------
my.data1 <- c()
my.data1 <- read_xlsx(path = source_file_path, sheet = 2, range = "A1:N45", password = "607052814")
my.data1$grupa <- "Neuroatypowi"

my.data2 <- c()
my.data2 <- read_xlsx(path = source_file_path, sheet = 2, range = "A52:N72", password = "607052814")
my.data2$grupa <- "Bez neuroatypowości"

my.data <- c()
my.data <- rbind(my.data1, 
    my.data2)
    
    
    # Change column names for nice and smooth coding -------------------------
    names(my.data) <- c("lp",
"imie_i_nazwisko",
"wiek",
"plec",
"masa_ciala",
"wysokosc",
"LDL",
"HDL",
"TG",
"cholesterol",
"HOMA_IR",
"powiklania_metaboliczne",
"wiek_nieprawidlowych_przyrostow_masy",
"miejsce_zamieszkania",
"grupa")
    
    
    # Clear the mess ---------------------------------------------------------
    my.data$lp <- 1:nrow(my.data)
    
    my.data$masa_ciala <- gsub(x = my.data$masa_ciala, pattern = "kg ", replacement = "")
    my.data$masa_ciala <- gsub(x = my.data$masa_ciala, pattern = ",", replacement = ".")
    
    my.data$wysokosc <- gsub(x = my.data$wysokosc, pattern = "cm", replacement = "")
    my.data$wysokosc <- gsub(x = my.data$wysokosc, pattern = ",", replacement = ".")
    
    # Deal with 'wiek' -------------------------------------------------------
    my.data$wiek <- gsub(x = my.data$wiek, pattern = ".", replacement = "", fixed = TRUE)
    my.data$wiek <- gsub(x = my.data$wiek, pattern = "lat", replacement = "")
    my.data$wiek <- gsub(x = my.data$wiek, pattern = "mies", replacement = "")
    my.data$wiek <- str_squish(my.data$wiek)
    my.data$wiek <- strsplit(x = my.data$wiek, split = " ")
    
    
    for(i in 1:nrow(my.data)){
        if(length(my.data$wiek[[i]]) == 2){
            my.data$wiek[[i]] <- paste(as.numeric(my.data$wiek[[i]][1]) + as.numeric(my.data$wiek[[i]][2])/12)
        }
    }# close for(i in 1:nrow(my.data)) loop...
    
    my.data$wiek <- as.numeric(my.data$wiek)
    my.data$wiek <- round(my.data$wiek, 2)
    
    
    # Export final database --------------------------------------------------
    write_xlsx(x = my.data, path = "C:/Users/Piotrek/Desktop/1.xlsx")
    
