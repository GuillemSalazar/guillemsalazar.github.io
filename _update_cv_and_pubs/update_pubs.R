source("doi2pubs.R")
doi_list<-read.csv(file = "doi_list.txt",header = F)
doi2df(doi_list$V1)
