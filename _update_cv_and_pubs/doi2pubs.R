
doi2df<-function(dois=NULL,pattern_bold="Guillem Salazar",tsv_output_path="publications.tsv",md_output_path="../_pages/publications.md",bib_output_path="cv_input_data/my_pubs.bib"){
  library(rcrossref)
  library(tidyverse)
  library(readr)
  
  
  # Query DOIs
  cat("Retrieving DOI info and saving a .bib file to",bib_output_path,"\n")
  my_citations_bibtext<-cr_cn(dois = dois)
  readr::write_lines(my_citations_bibtext, bib_output_path)
  
  cat("Retrieving DOI info and parsing it to a data frame\n")
  res<-cr_works(dois = dois) # Get publication info
  
  # Parse author names
  get_author<-function(list=NULL){
    list %>%
      as.data.frame() %>%
      mutate(name=paste(given,family,sep=" ")) %>%
      summarise(author_string=paste(name,collapse = ", "))
  }
  
  # Collect info on each paper
  author_string<-unlist(sapply(res$data$author,get_author))
  title_string<-res$data$title
  #journal_string<-paste("**",res$data$container.title,"**"," ",res$data$volume," (",res$data$issue,"), ",res$data$page,sep="")
  url_string<-res$data$url
  doi_string<-res$data$doi
  year_month_day<-res$data$created
  
  # Build Markdown string for each paper
  cat("Building markdown string\n")
  res_df<-data.frame(year_month_day,author_string,title_string,journal=res$data$container.title,volume=res$data$volume,issue=res$data$issue,page=res$data$page,doi_string,url_string,stringsAsFactors = F) %>%
    arrange(desc(year_month_day)) %>%
    separate(col = "year_month_day",into = c("year","month","day"),sep = "-",remove = F,fill="right") %>%
    mutate(issue=paste0("(",issue,")")) %>% mutate(issue=ifelse(issue=="(NA)",NA,issue)) %>%
    replace(., is.na(.), "") %>%
    mutate(journal_string=paste("**",journal,"**"," ",volume," ",issue," ",page,sep="")) %>%
    mutate(author_string=gsub(pattern_bold,paste("**",pattern_bold,"**",sep=""),author_string)) %>%
    mutate(markdown_string=paste("- ",author_string,". ","(",year,") ",paste("[",title_string,"](",sep=""),url_string,")",". ",journal_string,"\n",sep=""))
  
  # Build Markdown file
  cat("Saving Publications markdown file",md_output_path,"\n")
  header_string<-'---\nlayout: archive\ntitle: "Publications"\npermalink: /publications/\nauthor_profile: true\n---\n\n'
  cat(header_string,file = md_output_path)
  for (i in 1:nrow(res_df)){
    cat(res_df$markdown_string[i],file = md_output_path,append = T)
  }
  
  saveRDS(res_df,file = "pubs_data.rds")
  cat("DONE\n")
}
