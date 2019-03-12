require(quanteda)
require(quanteda.corpora)
require(lubridate)
corp_news <- download('data_corpus_guardian')
summary(corp_news)

toks_news <- tokens(corp_news, remove_punct = TRUE) 
head(toks_news)
dfmat_news <- dfm(toks_news)
head(dfmat_news)

tstat_key <- textstat_keyness(dfmat_news, 
                              target = year(docvars(dfmat_news, 'date')) >= 2016)
attr(tstat_key, 'documents') <- c('2016', '2012-2015')

textplot_keyness(tstat_key)

#print(docvars(dfmat_news, 'date'))

