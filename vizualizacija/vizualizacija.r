# 3. faza: Vizualizacija podatkov
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")


graf.messi <- ggplot(data = messi_sezone) +
  geom_line(aes(x = starost,y = vrednost),size = 1.5, color = "red")+
  labs(title ="Povezava med starostjo in vrednostjo Messija")+
  scale_y_continuous(limits = c(3, 190))+
  scale_x_continuous(limits = c(17, 31))+
  xlab("STAROST") + ylab("VREDNOST")
graf.messi

graf.statistika <- ggplot(data = messi_sezone, aes(x= starost)) +
  geom_line(aes(y=goli),size= 1.4, color ="blue")+
  geom_line(aes(y= asistence),size = 1.4, color = "red")+
  labs(title = "Povezava med starostjo in ucinkovitostjo Messija")+
  scale_y_continuous(limits = c(0, 70))+
  scale_x_continuous(limits = c(17, 31))+
  xlab("Starost") + ylab("Goli in asistence")
graf.statistika










