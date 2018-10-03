# 3. faza: Vizualizacija podatkov
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")
library(ggplot2)
library(reshape2)


graf.messi <- ggplot(data = messi_sezone) +
  geom_line(aes(x = starost,y = vrednost),size = 1.5, color = "red")+
  labs(title ="Povezava med starostjo in vrednostjo Messija")+
  scale_y_continuous(limits = c(3, 190))+
  scale_x_continuous(limits = c(17, 31))+
  xlab("STAROST") + ylab("VREDNOST")
graf.messi


graf.statistika <- ggplot(data = messi %>% group_by(sezona) %>%
                            summarise(goli = sum(goli, na.rm = TRUE),
                                      asistence = sum(asistence, na.rm = TRUE)) %>%
                            melt(id.vars = "sezona", variable.name = "spremenljivka",
                                 value.name = "stevilo") %>%
                            mutate(starost = parse_number(sezona) + 13),
                          aes(x = starost, y = stevilo, color = spremenljivka)) +
  geom_line(size = 1.4) +
  labs(title = "Povezava med starostjo in učinkovitostjo Messija")+
  xlab("Starost") + ylab("Goli in asistence")
graf.statistika

graf.igralci <- ggplot(igralci1 %>% group_by(pozicija) %>% summarise(vrednost = sum(vrednost)),
                       aes(x = pozicija, y = vrednost)) +
  geom_col(position = "dodge", fill = "blue") +
  xlab("Pozicija") + ylab("Vrednost (v mio €)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  ggtitle("Vrednost igralcev po pozicijah")
graf.igralci

graf.starost <- ggplot(igralci1 %>% group_by(starost) %>% summarise(vrednost = sum(vrednost)),
                       aes(x = starost, y = vrednost)) +
  geom_col(position = "dodge", fill = "peachpuff3") +
  xlab("Pozicija") + ylab("Vrednost (v mio €)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  ggtitle("Vrednost igralcev po pozicijah")
graf.starost



mesta <- data.frame(lon = c(7.468429,11.576124,7.12283,9.17702,6.44172,9.993682,8.682127,6.958307,13.404954,9.73322,8.806422,12.387772,8.2791,8.840872,6.98432,10.894446,10.780420,7.85222),
                    lat = c(51.514244,48.137154,51.5075,48.78232,51.18539,53.551086,50.110924,50.941357,52.520008,52.37052, 53.073635,51.343479,49.98419,49.272097,51.0303,48.366512,52.427547,47.9959))

zemljevid <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_DEU_shp.zip",
                             "gadm36_DEU_1") %>% pretvori.zemljevid()

zem.obisk <- ggplot() + geom_polygon(data = tab %>% group_by(pokrajina) %>% summarise(obisk = sum(obisk_skupaj)) %>%
                                       right_join(zemljevid, by = c("pokrajina" = "NAME_1")),
                                     aes(x = long, y = lat, group = group, fill = obisk/1000000)) +
  guides(fill = guide_colorbar("Obisk v milijonih")) + ggtitle("Obisk nemških prvoligaških tekem glede na pokrajine") +
  geom_point(data=mesta, aes(x=lon, y=lat), color="black", size=2, alpha=1)



###################################### zemljevidi za shiny


slovenija <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip",
                          "OB/OB", encoding = "UTF-8") %>%
  pretvori.zemljevid()

placa_2010 <- ggplot() + geom_polygon(data = placa1 %>% 
                                       right_join(slovenija, by = c("obcina" = "NAME_1")),
                                     aes(x = long, y = lat, group = group, fill = dohodek)) +
                                      ggtitle("Povprečna plača v letu 2010 po občinah")











