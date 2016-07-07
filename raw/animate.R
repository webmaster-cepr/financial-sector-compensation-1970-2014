source('raw/exploratory.R')
#source('raw/othersectors.R')

require(animation)

seq_list = mapply(seq,0,dat$perc.gdp,length.out=4L,SIMPLIFY = F)

n = nrow(dat)
o = 0
totals = c()

animate.list = list()

lappend = function(lst,...) {
  lst = c(lst,list(...))
  return(lst)
}

for(i in seq_list) {
 totals = append(totals,rep(0,o))
 totals = append(totals,i)
 totals = append(totals,rep(i[[length(i)]],n))
 animate.list = lappend(animate.list,totals)
 o = o + 1
 n = n - 1
 totals = c()
}

years = as.factor(c(1970:2014))
staggered.dat = data.frame(year = years, matrix(unlist(animate.list),nrow=45,byrow=T))
staggered.dat$final = staggered.dat[,ncol(staggered.dat)]

trace.bar = function(column) {
  p = ggplot() +
    geom_bar(data=staggered.dat,
             aes_string(colnames(staggered.dat)[1],colnames(staggered.dat)[column],fill=colnames(staggered.dat)[column]),stat="identity",width=.65) +
    geom_line(data=othersectors,aes(x=year,y=perc.gdp,group=""),color="red") +
    annotate("text", x="1970", y=0.58,label="Median Other Sectors",size=4,hjust=0,family="Verdana") +
    labs(x="Year\n\nSource: Bureau of Economic Analysis\nhttp://cepr.net",y="Percent of GDP") +
    scale_y_continuous(breaks = seq(0,max(dat$perc.gdp),by=.5),
                       expand = c(0,0),
                       labels=paste(seq(0,max(dat$perc.gdp),by=.5),"%",sep="")) +
    scale_fill_continuous(guide=F) +
    coord_cartesian(ylim=c(0,max(dat$perc.gdp)+.1)) +
    ggtitle("Financial Sector Employee Compensation as Share of GDP, 1970-2014") +
    theme(panel.background=element_blank(),
          axis.text.x=element_text(family="Verdana",size=10,angle=90,vjust=.5),
          axis.text.y=element_text(family="Verdana",size=10),
          axis.line.y=element_line(size=.15),
          axis.line.x=element_line(size=.15),
          axis.title.x=element_text(family="Verdana",size=12),
          axis.title.y=element_text(family="Verdana",size=12),
          plot.title=element_text(family="Verdana",face="bold",size=13))
  print(p) 
} 

trace.animate <- function() {
  lapply(seq(2,49,1), function(i) {
    trace.bar(i)
  })
}

saveGIF(trace.animate(),interval=.45,movie.name = "financial-sector-1970-2014.gif", ani.height=450, ani.width=600)
