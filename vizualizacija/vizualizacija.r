# 3. faza: Vizualizacija podatkov
source("lib/uvozi.zemljevid.r", encoding = "UTF-8")

graf.messi <- ggplot(data = messi_sezone) +
  geom_line(aes(x = starost,y = vrednost),size = 1.5, color = "red")+
  labs(title ="Povezava med starostjo in vrednostjo Messija")+
  scale_y_continuous(limits = c(3, 190))+
  scale_x_continuous(limits = c(17, 31))+
  xlab("STAROST") + ylab("VREDNOST")
graf.messi

