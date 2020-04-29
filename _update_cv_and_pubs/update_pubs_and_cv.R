source("doi2pubs.R")
doi_list<-read.csv(file = "cv_input_data/doi_list.txt",header = F)
doi2df(doi_list$V1)
rmarkdown::render("cv.Rmd")
