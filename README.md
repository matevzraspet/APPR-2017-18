# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza nogometnega trga in prihodki klubov
Pri tem projektu bom analiziral nogometni trg v zadnjih letih in sicer gibanje višine najbolj odmevnih prestopov leta, gibanje tržnih cen igralcev, razporeditev plač igralcev po klubih italijanske lige ( Gazette dello Sport je namreč edini časopis, ki izda zanseljive letne plače igralcev v italijanski ligi) in pa gibanje prihodkov nogometnih klubov. Skratka zanimalo me bo obnašanje nogometnega trga, ki vemo, da je sedaj zelo v razcvetu, saj so cene prestopov, plače ...,  "poletele" astronomsko v nebo.

Poskušal bom ugotoviti trende, kako spreminjanje tržnih vrednosti igralcev, spreminjanje višin prestopnih klavzul igralcev vpliva na prihodke klubov in obnašanje nogometnega trga,  poleg tega pa bi rad ugotovil vzorce razporeditve plač (v italijanski ligi ; kdo zasluži največ, kje je procentualno skoncentriranega največ denarja v odvisnosti od različnih parametrov(narodnost, položaj igranja, starost...).
Kot zanimivost bom analiziral, še razliko med višino prestopov in dejanskimi cenami igralcev ob prestopu(cena vrednotena na Transfermarktu).

Podatki bodo v obliki CSV in HTML.

#Tabele:

1.TABELA: GIBANJE VIŠINE NAJVEČJIH NOGOMETNIH PRESTOPOV SKOZI LETA:

- stoplci: sezona, starost igralca ob prestopu, klub odhoda, klub prihoda, cena

2.TABELA: GIBANJE TRŽNIH CEN IGRALCEV SKOZI LETA:

- stolpci: leto, starost, pozicija, klub, narodnost

3. PRIHODKI KLUBOV SKOZI LETA:

-stolpci: pozicija,leto, klub, prihodek, država, rank prejšnje leto, sprememba pozicije

4.TABELA: PLAČE ITALIJANSKIH IGRALCEV SKOZI LETA:

- stolpci: klub, narodnost, starost, pozicija, leto

kot zanimivost:

5.TABELA: Razlika med prestopno ceno in tržno ceno igralca:

- stolpci: leto, tržna cena, prestopna cena, razlika, klub odhoda, klub prihoda



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
