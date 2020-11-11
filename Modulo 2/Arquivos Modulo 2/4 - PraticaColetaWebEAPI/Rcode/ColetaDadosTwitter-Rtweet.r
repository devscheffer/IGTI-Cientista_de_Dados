#instalar pacote
install.packages("rtweet")

#importar o pacote/biblioteca
library(rtweet)


# plotting and pipes - tidyverse!
library(ggplot2)
library(dplyr)
# text mining library
library(tidytext)

# Credenciais para utilização da API do Twitter

API_key <- ""
API_secret_key <- ""
Access_token <- ""
Access_token_secret <- ""

APP_Name = "Segundo Exemplo IGTI"
API_key = "NQeq6TrRV9ysmnrny1Fe23Wsk"
API_secret_key = "Sfojb4megUAYodpwkyJ2wUMqCo7MtA3m6AiSgsZvsWnYWEvXJV"
Access_token = "2372825446-sjsr2ZcwJ4kS78RZfCIoObowoqL7lZ5224F8sIc"
Access_token_secret = "1qBePRAwScQOfsY24GvqsBM2qdGY2ILz1d7R5c5DHrIG3"

APP_Name <- "Primeiro Exemplo IGTI"
API_key <- "7eQNUEl5SG1A8bsRbzirZPeZj"
API_secret_key <- "1XXvmDZcf4t0V1Fc1NBGm8rr9ZyoHTb5j1WhueLYFzltqYSf3d"
Access_token <- "2372825446-v3SVbGKb6O3wjhNBMKPSxZInZZaF0yQjvPAn0vb"
Access_token_secret <- "jTRbDw58HobJnlrL7pmOlz0fEHCnsO40gDIzzqMx1Sqw5"


# criar token com authenticação 

token <- create_token(
  app = APP_Name,
  consumer_key = API_key,
  consumer_secret = API_secret_key,
  access_token = Access_token,
  access_secret = Access_token_secret)

#Post tweet in your account
post_tweet("Look, i'm tweeting from R.")

string <- c("corona OR coronavirus OR covid OR covid-19 OR covid19")
count  <-   100              #número de tweets solicitados por palavra 27000+ funciona bem
since  <-  c("2020-01-01") #data limite inferior no formato AAAA-MM-DD
until  <-  c("2020-07-31") #data limite superior
type   <-  "popular"        #"recent", "mixed" ou "popular"

#include_rts <- TRUE      #Incluir retweets ou não na pesquisa
#retryonratelimit <- TRUE #Continuar ou não depois do limite de 18000 tweets por 15 minutos


options(timeout = 4000000) 
#timeout(4000000)

## search for 100 tweets using the string key words
tweets <- search_tweets(q = string,n = count,type = type,include_rts = TRUE,retryonratelimit = TRUE)

# view the first 3 rows of the dataframe
head(tweets, n = 3)


#Salvando o data frame como CSV na codificação do portugues
write_as_csv(tweets, "TweetsData.csv", fileEncoding = "latin1//TRANSLIT")

## preview users data
users_data(tweets)

## plot time series (if ggplot2 is installed)
ts_plot(tweets)

# plot time series of tweets
ts_plot(tweets, "3 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of covid words Twitter statuses from past 9 days",
    subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

# how many locations are represented in tweets
length(unique(tweets$location))

#Plot graph
tweets %>%
  count(location, sort = TRUE) %>%
  mutate(location = reorder(location, n)) %>%
  top_n(20) %>%
  ggplot(aes(x = location, y = n)) +
  geom_col() +
  coord_flip() +
      labs(x = "Count",
      y = "Location",
      title = "Where tweets are from - unique locations ")

## identify tweet source
table(tweets$source)

# what users are tweeting with #covid
users <- search_users("#covid",
                      n = 500)
# just view the first 2 users - the data frame is large!
head(users, n = 2)

# how many locations are represented
length(unique(users$location))
## [1] 299

users %>%
  ggplot(aes(location)) +
  geom_bar() + coord_flip() +
      labs(x = "Count",
      y = "Location",
      title = "Twitter users - unique locations ")

## get most recent 200 tweets posted by Donald Trump's account
tweets_timeline <- get_timeline("IGTI_Oficial", n = 200)


ts_plot(tweets_timeline)

# plot time series of tweets
ts_plot(tweets_timeline, "3 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of covid words Twitter statuses from past 9 days",
    subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )
