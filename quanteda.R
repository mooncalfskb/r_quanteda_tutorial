rm(list = ls())

rm(list = ls())

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

#note, you can change number of threads depending on ram of your machine
#For instance, quanteda_options("threads" = 10) will use ten threads 
#which massively reduces the time to execute the parralelised functions.

library(rstudioapi) 
require(quanteda)
require(readtext)
require(quanteda.corpora)
require(newsmap)

#helpful instructions about vectors, dataframes and matrices
#https://tutorials.quanteda.io/introduction/r-commands/

#import readtext sample files
#path_data <- system.file("extdata/", package = "readtext")
#"/Library/Frameworks/R.framework/Versions/3.5/Resources/library/readtext/extdata/"

#dataframe of inauguration data
#dat_inaug <- read.csv(paste0(path_data, "/csv/inaugCorpus.csv"))
#print(dat_inaug)

#using readtext to look at tab-separated-values
#readtext object consisting of 33 documents and 9 docvars.
#dat_inaug2 <- readtext(paste0(path_data, "/tsv/dailsample.tsv"), text_field = "speech")

# # Description: data.frame [33 × 11]
# doc_id         text             speechID memberID partyID constID title                       date     member_name                  party_name const_name    
# <chr>          <chr>               <int>    <int>   <int>   <int> <chr>                       <chr>    <chr>                        <chr>      <chr>         
#   1 dailsample.ts… "\"Molaimse d\"…        1      977      22     158 1. CEANN COMHAIRLE I gCOIR… 1919-01… Count George Noble, Count P… Sinn Féin  Roscommon Nor…

#print(dat_inaug2)

###############################################
#Adam: here is what you need

#find your directory
my_path = rstudioapi::getActiveDocumentContext()$path
print(my_path)
#remove "quanteda.R" from path
my_dir = substr(my_path, 1, nchar(my_path)-10) 
print(my_dir)

#must name your files <filename>_en.pdf
#dat_udhr <- readtext(paste0(my_dir, "pdfs/*.pdf"), docvarsfrom = "filenames", docvarnames = c("document", "language"), sep = "_")

#print(dat_udhr)

#corpus = corpus(dat_udhr)

#print(corpus)

dat_udhr <- readtext(paste0(my_dir, "pdfs/*.pdf"))

print(dat_udhr)
print(dat_udhr[1,"doc_id"])

print(dat_udhr[2,"doc_id"])
print(dat_udhr[3,"doc_id"])

#row 3, column text
print(dat_udhr[3,"text"])

dat_udhr$stripped_text <- gsub("[[:space:]]+", " ", dat_udhr$text)
dat_udhr$trimmed_text <- trimws(dat_udhr$stripped_text)
dat_udhr$white_space_text <- gsub("\r?\n|\r|\n|\t", " ", dat_udhr$trimmed_text, perl=TRUE)

# for (dt in dat_udhr2){
#   print(dt[2][1][0])
# }

# df <- data.frame(doc_id=character(), 
#                  text=character(), 
#                  stringsAsFactors=FALSE) 
# 
# for (row in 1:nrow(dat_udhr)) {
#   doc_id <- dat_udhr[row, "doc_id"]
#   text  <- dat_udhr[row, "text"]
#   
#   text2 = gsub("\r?\n|\r", " ", text)
#   print(text2)
#   
#   
# }


print(dat_udhr[,"doc_id"])
print(dat_udhr[,"text"])
print(dat_udhr[,"stripped_text"])

dat_udhr <- subset(dat_udhr, select = c("doc_id", "white_space_text"))
print(dat_udhr)
colnames(dat_udhr)[colnames(dat_udhr)=="white_space_text"] <- "text"

write.table(dat_udhr,paste0(my_dir,"read_text_output/test_output.csv"),sep=",",row.names=FALSE,quote = TRUE)
write.ta

#my_df = data.frame('col_1'= c(1,2,3), 'col_2'= c(2,3,4))
#dat_udhr <- apply(dat_udhr, 2, insert_zero)
#print(dat_udhr)

#print(dat_udhr[1,"doc_id"])

#print(dat_udhr[2,"doc_id"])
#print(dat_udhr[3,"doc_id"])

#print(dat_udhr[1,"text"])

###############################################

#do your analysis on text
#readtext object consisting of 3 documents and 2 docvars.
# Description: data.frame [3 × 4]
#doc_id                 text                document        language
#<chr>                  <chr>               <chr>           <chr>   
#  1 DismissalOrder_en.pdf  "\"  Case 07-\"..." DismissalOrder  en      
#2 MotiontoDismiss_en.pdf "\"          \"..." MotiontoDismiss en      
#3 Variables_en.pdf       "\"ID    Name\"..." Variables       en  
