# 98-14
dat_98_14 = fread('data/1998-2014.csv',skip = 4, nrows=99, select=c(2:19))

sectors = c(5,6,8:10,11,12,15:25,27:34,36:37,39:42,44:51,53:56,58,60,63:64,66:68,69,
            71:72,73,75:78,80:81,83:84,85,89:90,91,94:95,96)

datf_98_14 = dat_98_14[sectors,]
datf_98_14 = as.data.table(t(datf_98_14))
datf_98_14 = datf_98_14[-1,]
datf_98_14 = apply(datf_98_14,2,function(x) {as.numeric(as.character(x))})

medians_98_14 = apply(datf_98_14,1,median)

# 88-97
dat_88_97 = fread('data/1988-1997.csv',skip = 4, nrows=86, select=c(2:12))

sectors2 = c(5:6,8:12,15:25,27:36,39:45,47:48,49:51,53:54,56:58,61:70,72:75,79:81,84:86)

datf_88_97 = dat_88_97[sectors2,]
datf_88_97 = as.data.table(t(datf_88_97))
datf_88_97 = datf_88_97[-1,]
datf_88_97 = apply(datf_88_97,2,function(x) {as.numeric(as.character(x))})

medians_88_97 = apply(datf_88_97,1,median)

## 70-87

dat_70_87 = fread('data/1970-1987.csv',skip = 4, nrows=86, select=c(2:20))

datf_70_87 = dat_70_87[sectors2,]
datf_70_87 = as.data.table(t(datf_70_87))
datf_70_87 = datf_70_87[-1,]
datf_70_87 = apply(datf_70_87,2,function(x) {as.numeric(as.character(x))})

medians_70_87 = apply(datf_70_87,1,median,na.rm=T)

medians = c(medians_70_87,medians_88_97,medians_98_14)

rm(datf_70_87,datf_88_97,datf_98_14,dat_70_87,dat_88_97,dat_98_14,medians_70_87,medians_88_97,medians_98_14)

othersectors = data.frame(year=dat$year,median.comp=medians,gdp=dat$gdp)
othersectors = othersectors %>% mutate(perc.gdp = (medians/gdp)*100)

ggplot() + geom_line(data=othersectors,aes(x=year,y=perc.gdp,group=""),color="red")
