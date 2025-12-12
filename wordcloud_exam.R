library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

#setting up
setwd("C:/Users/Mc Marteen/Documents/Feedback_DM")
text <- readLines("feedback.txt", encoding = "UTF-8", warn = FALSE)
text <- paste(text, collapse = " ")

corpus <- VCorpus(VectorSource(text))

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus,removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)


tdm <- TermDocumentMatrix(corpus)

m <- as.matrix(tdm)

word_freq <- sort(rowSums(m), decreasing = TRUE)

df <- data.frame(word = names(word_freq), freq = word_freq)



#setting up worldcloud - part 2
#set.seed(1234)
#wordcloud(
  #words = df$word,
  #freq = df$freq,
  #max.words = 10,
  #min.freq = 2,
  #random.order = FALSE,
  #rot.per = 0.35,
  #scale = c(4, 0.5))


#Part 3
#set.seed(1234)
#wordcloud(
#  words = df$word,
#  freq = df$freq,
#  max.words = 1000,
#  min.freq = 2,
#  random.order = FALSE,
#  scale = c(4, 0.5),
#  colors = brewer.pal(8,"Dark2"))


#rare words
set.seed(1234)
rare_df <- df[df$freq == 3, ]

wordcloud(
  words = rare_df$word,
  freq  = rare_df$freq,
  rot.per = .35,
  random.order = FALSE,
  colors = brewer.pal(8, "Dark2")
)


