install.packages("readxl")
install.packages("writexl")
library(readxl)
library(writexl)
dane = read_xlsx("C:/Users/kahan/Desktop/kopia.xlsx", sheet = 2, password = "607052814")

tabela_neuroatypowi = read_xlsx("C:/Users/kahan/Desktop/kopia.xlsx", sheet = 2, range = "A1:N45", password = "607052814")
tabela_bezneuroatypowości = read_xlsx("C:/Users/kahan/Desktop/kopia.xlsx", sheet = 2, range = "A52:N72", password = "607052814")

tabela_neuroatypowi$Grupa = "Neuroatypowi"
tabela_bezneuroatypowości$Grupa = "Bez neuroatypowości"
dwie_tabele = rbind(tabela_neuroatypowi, tabela_bezneuroatypowości)

install.packages("stringr")
library(stringr)
lata = as.numeric(str_extract(dwie_tabele$Wiek, "\d+(?=\s[Ll])"))
miesiace = as.numeric(str_extract(dwie_tabele$Wiek, "\d+(?=\s[Mm])"))
miesiace[is.na(miesiace)] = 0
dwie_tabele$Wiek = lata + (miesiace /12)

dwie_tabele$`Masa ciała` = gsub("kg| ","", dwie_tabele$`Masa ciała`)
dwie_tabele$`Masa ciała` = gsub("\.",",", dwie_tabele$`Masa ciała`)
dwie_tabele$`Masa ciała`
dwie_tabele$`Wysokość ciała`= gsub("cm| ","", dwie_tabele$`Wysokość ciała`)
dwie_tabele$`Wysokość ciała`= gsub("\.",",", dwie_tabele$`Wysokość ciała`)
dwie_tabele$`Wysokość ciała`

dwie_tabele$Wiek = round(dwie_tabele$Wiek, 2)
dwie_tabele$Numer = 1:nrow(dwie_tabele)

write_xlsx(dwie_tabele, "C:/Users/kahan/Desktop/nowa.xlsx")

# test
