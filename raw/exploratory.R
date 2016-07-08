source("raw/cleandata.R")

require(dplyr)
require(ggplot2)
require(cowplot)

dat = dat_70_14 %>% group_by(year) %>% summarize(total.comp=sum(compensation))
dat$gdp = t(gdp) * 1000
dat = dat %>% mutate(perc.gdp = (total.comp/gdp)*100)
write.csv(dat,"data/totalcomps_w_gdp.csv",row.names = F)

p = ggplot(subset(dat,year=="1970" | year=="2014"),
           aes(x=year,y=perc.gdp, fill=perc.gdp, label=paste(round(perc.gdp,2),"%",sep=""))) +
  geom_bar(stat="identity",width=.65) +
  geom_text(aes(y=perc.gdp+.05),size=5,family="Verdana") +
  labs(x="Year",y="Percent of GDP") +
  scale_y_continuous(breaks = seq(0,max(dat$perc.gdp),by=.5),
                     expand = c(0,0),
                     labels=paste(seq(0,max(dat$perc.gdp),by=.5),"%",sep="")) +
  scale_fill_continuous(guide=F) +
  coord_cartesian(ylim=c(0,max(dat$perc.gdp)+.1)) +
  ggtitle("Securities and Commodities Trading Compensation as Share of GDP, 1970 and 2014") +
  theme(panel.background=element_blank(),
        axis.text.x=element_text(family="Verdana",size=10,vjust=.5),
        axis.text.y=element_text(family="Verdana",size=10),
        axis.line.y=element_line(size=.15),
        axis.line.x=element_line(size=.15),
        axis.title.x=element_text(family="Verdana",size=12),
        axis.title.y=element_text(family="Verdana",size=12),
        plot.title=element_text(family="Verdana",face="bold",size=13))

p_final = add_sub(p,
                  "Source:Bureau of Economic Analysis\nhttp://cepr.net",
                  x=0, hjust=0, fontfamily="Verdana",size=10)
ggdraw(p_final)
