#!/usr/bin/env python
# coding: utf-8

# # <font color=blue>Coleta de Dados no MySQL utilizando o Python</font>

# #### Para mais detalhes sobre o pacote mysql.connector consulte:
# * https://www.w3schools.com/python/python_mysql_getstarted.asp

# ### <font color=blue>Instalar o pacote</font>
# 
# Antes de executar este notebook pela primeira vez, instale o pacote mysql.connector
# 
# Para instalar o pacote, utilizando o prompt do Anaconda, execute o comando abaixo:
# * *conda install -c anaconda mysql-connector-python*
# 
# Para instalar o pacote, utilizando o Jupyter Notebook ou o IDE Spider, execute o comando abaixo:
# * *!pip install mysql-connector-python*

# ### <font color=blue>Importar o pacote</font>
# 
# Sempre que for utilizar o pacote é necessário importá-lo primeiro

# In[ ]:


#importar pacote
import mysql.connector


# #### Conectar ao MySQL Server sem selecionar um banco de dados

# In[ ]:


mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='igti'
)

print(mydb)

mycursor = mydb.cursor()

#Para criar um banco de dados use o comando abaixo
#mycursor.execute("CREATE DATABASE mydatabase")


# In[ ]:


#Retorna todos os esquemas criados no seu servidor de Banco de Dados
mycursor.execute("SHOW DATABASES") 

for db in mycursor:
    print(db)


# #### Conectar ao MySQL Server selecionand um banco de dados específico

# In[ ]:



mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='igti',
    database='bootcamp'
)

print(mydb)

mycursor = mydb.cursor()


# In[ ]:


#Retorna todas as tabelas criados no seu esquema de Banco de Dados 
mycursor.execute("SHOW TABLES")

for db in mycursor:
    print(db)


# In[ ]:


# Inserir dados em uma tabela

query = "INSERT INTO caracteristicasgerais (idcaracteristicasGerais, dsccaracteristicasGerais) VALUES (%s, %s)"
values = (1, "Portaria 24 horas")

mycursor.execute(query, values)


# Por padrão, não é efetuado commit automaticamente.

# In[ ]:


#Fazer a confirmação da inserção
mydb.commit()

print(mycursor.rowcount, "registro(s) inserido(s).")


# In[ ]:


#Inserindo multiplos valores
values = [(2, "Elevador"),(3,"Piscina")]

mycursor.executemany(query, values)

#Fazer a confirmação da inserção
mydb.commit()

print(mycursor.rowcount, "registro(s) inserido(s).")


# In[ ]:


#Consultar a tabela
mycursor.execute("SELECT * FROM caracteristicasgerais")

myresult = mycursor.fetchall() #todos os registros

for mydata in myresult:
    print(mydata)


# In[ ]:


mycursor.execute("SELECT idcaracteristicasGerais, dsccaracteristicasGerais FROM caracteristicasgerais")

myresult = mycursor.fetchone() #apenas primeiro registro

print(myresult)


# Agora vamos realizar a carga na tabela "cidade" a partir dos dados coletados no arquivo cidades.csv.
# 
# Para abrir ler o arquivo será necessário o pacote *"CSV"*.

# ### <font color=blue>Importar o pacote</font>

# In[ ]:


#importa pacote

import csv


# In[ ]:


#Leitura de arquivo sem utilizar biblioteca Pandas
# Conferir se seu arquivo foi salvo no caminho abaixo

filename = 'C:\Bootcamp\Datasets\CSV\cidades.csv'

#Abrir arquivo e inserir cada linha do arquivo na tabela cidade

with open(filename, 'r') as incsvfile:
    reader = csv.reader(incsvfile, delimiter=',')
    next(reader, None)  # skip the headers
    for line in reader:       
        mycursor.execute ("INSERT INTO cidade (CodigoCompletoIBGE, CodigoCidadeIBGE,NomeCidade, CodEstadoIBGE)                  VALUES (%s, %s, %s, %s)",line)        
mydb.commit()

#db.close()
incsvfile.close() #Fechar arquivo


# **OBSERVAÇÃO:**
# 
#  Caso o erro abaixo ocorra, em qualquer momento deste notebook, significa que sua conexão com o banco de dados foi fechada, devido ao tempo de *timeout*. Basta executar a conexão novamente e executar os comando em seguida.

# ![image.png](attachment:image.png)

# In[ ]:


#Consutar a tabela cidade listando a quantidade de registros existentes nela. Seu resultado deve imprimir 5570.

mycursor.execute("SELECT count(*) FROM cidade")

myresult = mycursor.fetchone()

print(myresult)


# In[ ]:


mydb.close() #Fechar o banco de dados


# ##### Fim
