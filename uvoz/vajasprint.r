library(rvest)
library(gsubfn)
library(readr)
library(dplyr)
library(stringr)


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


uvozi.igralce <- function(stran) {
  link <- sprintf("https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop?land_id=0&ausrichtung=alle&spielerposition_id=alle&altersklasse=alle&jahrgang=0&plus=1&page=%d", stran)
  tabela <- html_session(link) %>% read_html() %>% html_nodes(xpath="//table") %>% .[[2]]
  podrobno <- tabela %>% html_table(dec = ",", fill = TRUE) %>%
    .[, -c(1, 2, 3, 7, 8)] %>% na.omit()
  colnames(podrobno) <- c("igralec", "pozicija", "starost", "vrednost", "odigrane.tekme",
                          "zadeti.goli", "avtogoli", "asistence", "rumeni.kartoni", "drugi.rumeni.karton",
                          "rdeci.karton", "prisel.kot.menjava", "odsel.na.klop")
  podrobno$drzava <- tabela %>% html_nodes(xpath="./tbody/tr/td[4]/img[1]") %>% html_attr("alt")
  podrobno$klub <- tabela %>% html_nodes(xpath="./tbody/tr/td[5]/a/img[1]") %>% html_attr("alt")
  return(podrobno)
}
igralci <- lapply(1:4, uvozi.igralce) %>% bind_rows()



igralci1 <- igralci[,c("igralec","pozicija","starost","vrednost","drzava","klub")]
igralci1$vrednost <- parse_number(igralci1$vrednost)/100
igralci2 <- igralci[,c("odigrane.tekme","zadeti.goli","avtogoli","asistence","rumeni.kartoni","drugi.rumeni.karton","rdeci.karton",
                       "prisel.kot.menjava","odsel.na.klop")]




link <- sprintf("https://www.transfermarkt.com/lionel-messi/leistungsdatendetails/spieler/28003")
tabela5 <- html_session(link) %>% read_html() %>% html_nodes(xpath="//table") %>% .[[2]]
messi <- tabela5 %>% html_table(dec = ",", fill = TRUE)
messi <- messi[-c(1),-c(2,4)]
colnames(messi) <- c("sezona", "tekmovanje", "stevilo.predstav", "povpr.tock.na.tekmo", "goli","asistence","rumeni.2rumeni.rdeci","odigrane.minute","starost")
messi["starost"] <- c("31","31","30","30","30","30","29","29","29","29","28","28","28","28","28","28","27","27","27","26","26","26","26","25","25","25","25","24","24","24",
                      "24","24","24","23","23","23","23","22","22","22","22","22","22","21","21","21","20","20","20","19",
                      "19","19","19","19","18","18","18","17","17","17")
messi$starost <- parse_number(messi$starost)
messi["vrednost"]<- c("180","180","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120",
                     "100","100","100","100","100","100","100","100","100","100","80","80","80","80","55","55","55","55","55","55",
                     "55","55","55","40","40","40","15","15","15","15","15","5","5","5","3","3","3")
messi$vrednost <- parse_number(messi$vrednost)
analiza <- messi[,c("sezona","stevilo.predstav","povpr.tock.na.tekmo","goli","asistence","odigrane.minute","starost","vrednost")]


link <- "https://www.transfermarkt.com/spieler-statistik/wertvollstemannschaften/marktwertetop"
stran <- html_session(link) %>% read_html()
tabela111 <- stran %>% html_nodes(xpath="//table") %>% .[[1]] %>%
  html_table(dec = ",", fill = TRUE)
tabela111[1:2] <- list(NULL)



link <- "https://www.worldfootball.net/attendance/bundesliga-2017-2018/1/"
stran <- html_session(link) %>% read_html()
tab <- stran %>% html_nodes(xpath="//table") %>% .[[2]] %>%
  html_table(dec = ",", fill = TRUE)
tab <- tab[,-c(1,2)]
tab["pokrajina"] <- c("Nordrhein-Westfalen","Bayern","Nordrhein-Westfalen","Baden-Württemberg","Nordrhein-Westfalen","Hamburg",
                 "Hessen","Nordrhein-Westfalen","Berlin","Niedersachsen","Bremen","Sachsen","Rheinland-Pfalz","Baden-Württemberg",
                 "Nordrhein-Westfalen","Bavaria","Niedersachsen","Baden-Württemberg","")
                
sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")



link <- "https://en.wikipedia.org/wiki/Deloitte_Football_Money_League#2015.E2.80.9316"
stran <- html_session(link) %>% read_html()
tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[1]] %>% html_table(dec = ",")




colnames(tabela) <- c("rang v 2018", "klub", "dobicek (milijon)", "drzava", "rang v 2017",
                      "sprememba")

placa <- read_csv2("povprecnaplaca.csv",
                   locale = locale(encoding = "Windows-1250"))
colnames(placa) <- c("obcina","2010","2011","2012","2013","2014","2015","2016","2017")
placa$`2012` <- placa$`2012` /100
placa$`2013` <- placa$`2013` /100
placa$`2014` <- placa$`2014` /100
placa$`2015` <- placa$`2015` /100
placa$`2016` <- placa$`2016` /100
placa$`2017` <- placa$`2017` /100
placa$`2010` <- parse_number(placa$`2010`)/100
placa$`2011` <- parse_number(placa$`2011`)/100

link <- "http://www.rossoneriblog.com/2016/09/07/milan-20162017-players-salary-chart/"
stran <- html_session(link) %>% read_html()
tabela1 <- stran %>% html_nodes(xpath="//table") %>%
  .[[1]] %>% html_table(dec = ",")


link <- "http://www.rossoneriblog.com/2016/09/07/milan-20162017-players-salary-chart/"
stran <- html_session(link) %>% read_html()
tabela1111 <- stran %>% html_nodes(xpath="//table") %>%
  .[[2]] %>% html_table(dec = ",")
  
  
  
  
  
  
  
  
