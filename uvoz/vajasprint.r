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
igralci1$vrednost <- parse_number(igralci1$vrednost, locale = locale(decimal_mark = ","))
igralci2 <- igralci[,c("igralec","odigrane.tekme","zadeti.goli","avtogoli","asistence",
                       "rumeni.kartoni","drugi.rumeni.karton","rdeci.karton","prisel.kot.menjava",
                       "odsel.na.klop")] %>% melt(id.vars = "igralec",
                                                  variable.name = "spremenljivka",
                                                  value.name = "stevilo")




link <- sprintf("https://www.transfermarkt.com/lionel-messi/leistungsdatendetails/spieler/28003")
tabela5 <- html_session(link) %>% read_html() %>% html_nodes(xpath="//table") %>% .[[2]]
messi <- tabela5 %>% html_table(dec = ",", fill = TRUE)

messi <- messi[-c(1),-c(2,4,11)]
colnames(messi) <- c("sezona", "tekmovanje", "stevilo.predstav", "povpr.tock.na.tekmo", "goli","asistence","rumeni.2rumeni.rdeci","odigrane.minute")
messi$goli <- parse_number(messi$goli, na = "-")
messi$asistence <- parse_number(messi$asistence, na = "-")
messi$odigrane.minute <- parse_number(messi$odigrane.minute, na = "-", locale = locale(grouping_mark = "."))

#messi$starost <- parse_number(messi$sezona) + 13
#messi["vrednost"]<- c("180","180","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120","120",
#                     "100","100","100","100","100","100","100","100","100","100","80","80","80","80","55","55","55","55","55","55",
#                     "55","55","55","40","40","40","15","15","15","15","15","5","5","5","3","3","3")
#messi$vrednost <- parse_number(messi$vrednost)

messi_sezone <- data.frame(sezona = sprintf("%02d/%02d", 4:18, 5:19),
                           starost = 17:31,
                           vrednost = c(3, 5, 15, ...))

#messi_skupaj <- inner_join(messi, messi_sezone, by = "sezona")

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


placa <- read_delim("podatki/povprecnaplaca.csv", ";",
                    locale = locale(encoding = "Windows-1250", decimal_mark = "."))
colnames(placa) <- c("obcina","2010","2011","2012","2013","2014","2015","2016","2017")
placa <- melt(placa, id.vars = "obcina", variable.name = "leto", value.name = "placa") %>%
  mutate(leto = parse_number(leto))

link <- "http://www.rossoneriblog.com/2016/09/07/milan-20162017-players-salary-chart/"
stran <- html_session(link) %>% read_html()
tabela1 <- stran %>% html_nodes(xpath="//table") %>%
  .[[1]] %>% html_table(dec = ",")


link <- "http://www.rossoneriblog.com/2016/09/07/milan-20162017-players-salary-chart/"
stran <- html_session(link) %>% read_html()
tabela1111 <- stran %>% html_nodes(xpath="//table") %>%
  .[[2]] %>% html_table(dec = ",")


  https://gadm.org/maps/DEU_1.html




