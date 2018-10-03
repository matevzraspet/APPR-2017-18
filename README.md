# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza nogometnega trga in prihodki klubov
Pri tem projektu bom analiziral nogometni trg v zadnjih letih in sicer gibanje višine najbolj odmevnih prestopov leta, gibanje tržnih cen igralcev, razporeditev plač igralcev po klubih italijanske lige ( Gazette dello Sport je namreč edini časopis, ki izda zanseljive letne plače igralcev v italijanski ligi), vrednost igralcev glede na pozicijo, vrednost cene igralca glede na starost in pa gibanje prihodkov nogometnih klubov. Skratka zanimalo me bo obnašanje nogometnega trga, ki vemo, da je sedaj zelo v razcvetu, saj so cene prestopov, plače ...,  "poletele" astronomsko v nebo.

Poskušal bom ugotoviti trende, kakšno je spreminjanje tržnih vrednosti igralcev. Za primer bom vzel enega izmed najboljših nogometašev na svetu, Lionela Messija, in bom pogledal kako starost in nogometna učinovitost vplivata na vrednost igralca. Nato bom v večji bazi igralcev pogledal katera leta so za igralce najbolj donosna. Na koncu pa bom poskušal dobiti še nekaj zanimivih zaključkov iz nemške lige

Podatki bodo v obliki CSV in HTML.

# Tabele:

1.TABELA: TRŽNE VREDNOSTI NAJDRAŽJIH IGRALCEV:

- stoplci: pozicija, starost, vrednost,država, klub

2.TABELA: KAZALNIKI MESSIJA:

- stolpci: sezona, starost, vrednost, goli, asistence

3. PRIHODKI KLUBOV SKOZI LETA:

-stolpci: pozicija,leto, klub, prihodek, država, rank prejšnje leto, sprememba pozicije

4.TABELA: OBISK TEKEM V NEMŠKI LIGI:

- stolpci: klub, pokrajina, stevilo tekem, povprecje, skupen obisk

kot zanimivost:

5.TABELA: POVPREČNE PLAČE V SLOVENIJI PO REGIJAH:

- stolpci: občina,leto, dohodek



Viri:
- https://www.transfermarkt.com/statistik/transferrekorde
- https://en.wikipedia.org/wiki/Deloitte_Football_Money_League#2015.E2.80.9316
- https://www.transfermarkt.com/statistik/transfererloese
- http://www.rossoneriblog.com/2016/09/07/milan-20162017-players-salary-chart/

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
