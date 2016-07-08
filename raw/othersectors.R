require(data.table)
require(ggplot2)
require(dplyr)

sector_names = c("Agriculture","Manufacturing (Durable Goods)", "Manufacturing (Nondurable Goods)")

# 98-14
dat_98_14 = fread('data/1998-2014.csv',skip = 4, nrows=99, select=c(2:19))

sectors = c(4,14,26)
years = as.factor(c(1998:2014))

datf_98_14 = dat_98_14[sectors,]
datf_98_14 = as.data.table(t(datf_98_14))
datf_98_14 = as.data.frame(datf_98_14[-1,])

final_98_14 = rbind(data.frame(sector=rep(sector_names[1],length(years)),year=years,comp=datf_98_14[,1]),
                    data.frame(sector=rep(sector_names[2],length(years)),year=years,comp=datf_98_14[,2]),
                    data.frame(sector=rep(sector_names[3],length(years)),year=years,comp=datf_98_14[,3]))

rm(dat_98_14,datf_98_14)

# 88-97

years = as.factor(c(1988:1997))

dat_88_97 = fread('data/1988-1997.csv',skip = 4, nrows=86, select=c(2:12))

datf_88_97 = dat_88_97[sectors,]
datf_88_97 = as.data.table(t(datf_88_97))
datf_88_97 = as.data.frame(datf_88_97[-1,])

final_88_97 = rbind(data.frame(sector=rep(sector_names[1],length(years)),year=years,comp=datf_88_97[,1]),
                    data.frame(sector=rep(sector_names[2],length(years)),year=years,comp=datf_88_97[,2]),
                    data.frame(sector=rep(sector_names[3],length(years)),year=years,comp=datf_88_97[,3]))

rm(dat_88_97,datf_88_97)

## 70-87

dat_70_87 = fread('data/1970-1987.csv',skip = 4, nrows=86, select=c(2:20))

datf_70_87 = dat_70_87[sectors,]
datf_70_87 = as.data.table(t(datf_70_87))
datf_70_87 = as.data.frame(datf_70_87[-1,])

years = as.factor(c(1970:1987))

final_70_87 = rbind(data.frame(sector=rep(sector_names[1],length(years)),year=years,comp=datf_70_87[,1]),
                    data.frame(sector=rep(sector_names[2],length(years)),year=years,comp=datf_70_87[,2]),
                    data.frame(sector=rep(sector_names[3],length(years)),year=years,comp=datf_70_87[,3]))

rm(dat_70_87,datf_70_87)

# FINAL DF

othersectors = rbind(final_70_87,final_88_97,final_98_14)

agriculture = othersectors %>% filter(sector == "Agriculture") %>% arrange(year)
agriculture$gdp = dat$gdp[,1]
agriculture$comp = as.numeric(as.character(agriculture$comp))
agriculture = agriculture %>% mutate(perc.gdp = (comp/gdp) * 100)


durable = othersectors %>% filter(sector == sector_names[2]) %>% arrange(year)
durable$gdp = dat$gdp[,1]
durable$comp = as.numeric(as.character(durable$comp))
durable = durable %>% mutate(perc.gdp = (comp/gdp) * 100)

nondurable = othersectors %>% filter(sector == sector_names[3]) %>% arrange(year)
nondurable$gdp = dat$gdp[,1]
nondurable$comp = as.numeric(as.character(nondurable$comp))
nondurable = nondurable %>% mutate(perc.gdp = (comp/gdp) * 100)

ggplot() + geom_line(data=agriculture,aes(x=year,y=perc.gdp,group=""))
