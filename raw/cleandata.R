library(data.table)

# YEARLY COMPENSATION FOR FINANCIAL SECTOR

dat_98_14 = fread('data/1998-2014.csv',skip = 4, nrows=99, select=c(2:19))
dat_88_97 = fread('data/1988-1997.csv',skip = 4, nrows=59, select=c(2:12))
dat_70_87 = fread('data/1970-1987.csv',skip = 4, nrows=59, select=c(2:20))


clean_dat = function(df,row) {
  temp = as.data.frame(t(df[row,]))
  temp$industry = temp$V1[1]
  temp$year = as.factor(rownames(temp))
  colnames(temp)[1] = "compensation"
  temp = temp[-1,]
  rownames(temp) = c(1:nrow(temp))
  temp
}

dat_70_87_commod = clean_dat(dat_70_87,55)
dat_70_87_other = clean_dat(dat_70_87,59)
dat_88_97_commod = clean_dat(dat_88_97,55)
dat_88_97_other = clean_dat(dat_88_97,59)
dat_98_14_commod = clean_dat(dat_98_14,59)
dat_98_14_other = clean_dat(dat_98_14,61)


dat_70_14 = rbind(dat_70_87_commod,
                  dat_70_87_other,
                  dat_88_97_commod,
                  dat_88_97_other,
                  dat_98_14_commod,
                  dat_98_14_other)

rm(list=setdiff(ls(),"dat_70_14"))

dat_70_14$compensation = as.numeric(as.character(dat_70_14$compensation))

# GDP

gdp = fread("data/gdp-1970-2014.csv",skip=3,nrows=1,select=c(3:47))
