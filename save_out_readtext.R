#uncomment this next line and run if it you want to totally clear your R environment.
#rm(list = ls())

#from https://tutorials.quanteda.io/basic-operations/tokens/tokens_compound/
#https://tutorials.quanteda.io/introduction/

#install.packages("quanteda")
#install.packages("readtext")
#install.packages("devtools")
#devtools::install_github("quanteda/quanteda.corpora")
#install.packages("spacyr")
#install.packages("newsmap")
#devtools::install_github("r-lib/rlang", build_vignettes = TRUE)
#install.packages("readtext")

library(rstudioapi) 
require(quanteda)
require(readtext)
require(quanteda.corpora)
require(newsmap)

#read in the pdfs from your directory and create a dataframe with readtext
#the default readtext object will have a "doc_id" and "text" column
dat_udhr <- readtext("/Users/mooncalfskb/Dropbox/skb/DataProjectsBankruptcy/2019/Tutorials/r_quanteda_tutorial/pdfs/*.pdf")

head(dat_udhr)

#make a new column called "stripped_text" that kills all extra spaces and newlines that aren't one space
dat_udhr$stripped_text <- gsub("\\s+", " ", dat_udhr$text)
#make a new column that trims that stripped column at the beginning and end
dat_udhr$trimmed_text <- trimws(dat_udhr$stripped_text)
#cut the dataframe down to just two columns
dat_udhr <- subset(dat_udhr, select = c("doc_id", "trimmed_text"))
#rename trimmed text to text
colnames(dat_udhr)[colnames(dat_udhr)=="trimmed_text"] <- "text"
#write out the new flattened data to a csv
write.table(dat_udhr,"/Users/mooncalfskb/Dropbox/skb/DataProjectsBankruptcy/2019/Tutorials/r_quanteda_tutorial/read_text_output/test_output.csv",sep=",",row.names=FALSE,quote = TRUE)
