library(rvest)
library(gsubfn)
library(readr)
library(dplyr)



link <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop"
stran <- html_session(link) %>% read_html()
skupno <- stran %>% html_nodes(xpath="//table") %>% .[[2]] %>%
  html_table(dec = ",", fill = TRUE) 
skupno <- skupno[,-c(1,2,3,7,8)]
colnames(skupno) <- c("igralec", "pozicija", "starost", "vrednost")
skupno <-na.omit(skupno)


link <- "https://www.transfermarkt.com/spieler-statistik/rekordmarktwerte/marktwertetop/plus/0/galerie/0?position=Torwart&land_id=alle&yt0=Show"
stran <- html_session(link) %>% read_html()
golmani <- stran %>% html_nodes(xpath="//table") %>% .[[2]] %>%
  html_table(dec = ",", fill = TRUE) 
golmani <- golmani[,-c(1,2,3,6,7)]
colnames(golmani) <- c("igralec", "pozicija", "datum", "vrednost")
golmani <-na.omit(golmani)



link <- "https://www.transfermarkt.com/spieler-statistik/rekordmarktwerte/marktwertetop/plus/0/galerie/0?position=Abwehr&land_id=alle&yt0=Show"
stran <- html_session(link) %>% read_html()
obramba <- stran %>% html_nodes(xpath="//table") %>% .[[2]] %>%
  html_table(dec = ",", fill = TRUE) 
obramba <- obramba[,-c(1,2,3,6,7)]
colnames(obramba) <- c("igralec", "pozicija", "datum", "vrednost")
obramba <-na.omit(obramba)

link <- "https://www.transfermarkt.com/spieler-statistik/rekordmarktwerte/marktwertetop/plus/0/galerie/0?position=Mittelfeld&land_id=alle&yt0=Show"
stran <- html_session(link) %>% read_html()
sredina <- stran %>% html_nodes(xpath="//table") %>% .[[2]] %>%
  html_table(dec = ",", fill = TRUE) 
sredina <- sredina[,-c(1,2,3,6,7)]
colnames(sredina) <- c("igralec", "pozicija", "datum", "vrednost")
sredina <-na.omit(sredina)


link <- "https://www.transfermarkt.com/spieler-statistik/rekordmarktwerte/marktwertetop/plus/0/galerie/0?position=Sturm&land_id=alle&yt0=Show"
stran <- html_session(link) %>% read_html()
napad <- stran %>% html_nodes(xpath="//table") %>% .[[2]] %>%
  html_table(dec = ",", fill = TRUE) 
napad <- napad[,-c(1,2,3,6,7)]
colnames(napad) <- c("igralec", "pozicija", "datum", "vrednost")
napad <-na.omit(napad)


link <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop?land_id=0&ausrichtung=alle&spielerposition_id=alle&altersklasse=alle&jahrgang=0&plus=1"
stran <- html_session(link) %>% read_html()
podrobno <- stran %>% html_nodes(xpath="//table") %>% .[[2]] %>%
  html_table(dec = ",", fill = TRUE) 
podrobno <- podrobno[,-c(1,2,3,7,8)]
colnames(podrobno) <- c("igralec", "pozicija", "starost", "vrednost", "odigrane tekme",
                        "zadeti goli", "avtogoli", "asistence", "rumeni kartoni", "drugi rumeni karton",
                        "rdeci karton","prisel kot menjava","odsel na klop")
podrobno <-na.omit(podrobno)


link <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop?land_id=0&ausrichtung=alle&spielerposition_id=alle&altersklasse=alle&jahrgang=0&plus=1"
stran <- html_session(link) %>% read_html()
podrobno1 <- stran %>% html_nodes(xpath="//table") %>% .[[2]] %>%
  html_table(dec = ",", fill = TRUE) 
podrobno1 <- podrobno1[,-c(1,2,3,7,8)]
colnames(podrobno1) <- c("igralec", "pozicija", "starost", "vrednost", "odigrane tekme",
                        "zadeti goli", "avtogoli", "asistence", "rumeni kartoni", "drugi rumeni karton",
                        "rdeci karton","prisel kot menjava","odsel na klop")
podrobno1 <-na.omit(podrobno1)




link <- "https://www.transfermarkt.com/spieler-statistik/wertvollstemannschaften/marktwertetop"
stran <- html_session(link) %>% read_html()
tabela111 <- stran %>% html_nodes(xpath="//table") %>% .[[1]] %>%
  html_table(dec = ",", fill = TRUE)
tabela111[1:2] <- list(NULL)



sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")



link <- "https://en.wikipedia.org/wiki/Deloitte_Football_Money_League#2015.E2.80.9316"
stran <- html_session(link) %>% read_html()
tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[1]] %>% html_table(dec = ",")




colnames(tabela) <- c("rang v 2018", "klub", "dobicek (milijon)", "drzava", "rang v 2017",
                      "sprememba")








  
  
  
  
  
  
  
  
  
  
  
  