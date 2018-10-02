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
  xlab("Pozicija") + ylab("Vrednost") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  ggtitle("Vrednost igralcev po pozicijah")
graf.igralci

zemljevid <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_DEU_shp.zip",
                             "gadm36_DEU_1") %>% pretvori.zemljevid()

zem.obisk <- ggplot() + geom_polygon(data = tab %>% group_by(pokrajina) %>% summarise(obisk = sum(obisk_skupaj)) %>%
                                       right_join(zemljevid, by = c("pokrajina" = "NAME_1")),
                                     aes(x = long, y = lat, group = group, fill = obisk/1000000)) +
  guides(fill = guide_colorbar("Obisk v milijonih"))




