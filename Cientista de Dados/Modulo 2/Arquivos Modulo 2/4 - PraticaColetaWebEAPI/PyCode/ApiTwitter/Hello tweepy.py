#!/usr/bin/env python
# coding: utf-8

# # Hello tweepy
# 

# #### Detalhes sobre o pacote Tweepy:
# * http://docs.tweepy.org/en/latest/
# 

# In[ ]:


#import o pacote
import tweepy


# In[ ]:


# Chaves de acesso
consumer_key = ''
consumer_secret = ''
access_token = ''
access_token_secret = ''


# In[ ]:


# Autenticação
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)


# In[ ]:


# Token de acesso a API
api = tweepy.API(auth)


# ## Coleta tweets da timeline de um usuário

# In[ ]:


# Coleta tweets da timeline do Ministério da Saúde
tweets = api.user_timeline('minsaude')


# In[ ]:


print("Total de tweets coletados %s." % (len(tweets)))


# In[ ]:


#Exibe os tweets
for tweet in tweets:
    print(tweet.text)


# In[ ]:


minsaude


# In[ ]:


# Get the User object for twitter...
user = api.get_user('minsaude')


# In[ ]:


print("Total de seguidores do usuário @%s: %s" % (user.screen_name,user.followers_count))


# In[ ]:


for friend in user.friends():
    print(friend.screen_name)


# Fim!
