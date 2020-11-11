# Instalar o pacote RMariaD se for a primeira vez que for utlizar.

install.packages("RMariaDB")

#importação do pacote deve ser SEMPRE realizada

#Importa pacote RMariaDB se ele ainda não foi carregado
if(!"RMariaDB" %in% (.packages())){require(RMariaDB)}

#Conecta ao SGBD MySQL --> Banco de dados bootcamp
con <- dbConnect(MariaDB(), user = "root", password = "igti",
                 dbname = "bootcamp", host = "localhost",serverTimezone='UTC')

#Para listar quais tabela existem no esquema .bootcamp. execute:

#Lê a lista de tabelas no BD
tables <- dbListTables(con) 
tables

#Para consultar quais os dados de uma tabela execute:
# dbReadTable(nome-da-conexao,"nome-da-tabela")

#Consulta os dados da tabela *estado*
tabledata <- dbReadTable(con,"estado")
tabledata

#Consulta os dados da tabela *tipounidade*
tabledata <- dbReadTable(con,"tipounidade")
tabledata

#Para executar um comando SQL execute:
#dbSendQuery(nome-da-conexao,"comando")

# Vamos inserir uma nova linha na tabela tipounidade
# Cria o comando e salva na variável query
query <-  "INSERT INTO tipounidade(idTipoUnidade,dscTipoUnidade) VALUES(7,'Loft');"

results <- dbSendQuery(con,query)
print(results)

# Limpa resultados
dbClearResult(results)

#Consulta os dados da tabela *tipounidade*
tabledata <- dbReadTable(con,"tipounidade")
tabledata

id <- 8
desc <- 'Chácara'

query <-  paste("INSERT INTO tipounidade(idTipoUnidade,dscTipoUnidade) VALUES(",id,",'",desc,"');",sep='')

results <- dbSendQuery(con,query)
print(results)

# Limpa resultados
dbClearResult(results)

#Consulta os dados da tabela *tipounidade*
tabledata <- dbReadTable(con,"tipounidade")
tabledata

# Instalar o pacote xlsx se for a primeira vez que for utlizar.
install.packages('xlsx')

#Importa pacote xlsx se ele ainda não foi carregado
if(!"xlsx" %in% (.packages())){require(xlsx)}

#Antes de excutar esta célula, garanta que o caminho do arquivo estados.xlsx esteja correto.

filename <- "C:/Bootcamp/Datasets/XLS/estados.xlsx"
print(filename)

insertdata <- read.xlsx(filename, sheetIndex=1, header=TRUE,encoding="UTF-8")
print("Lista de estados existentes no arquivo:")
insertdata

# Escrever ou gravar os dados na tabela estado

dbWriteTable(con,'estado',insertdata,append = TRUE)

#Consulta os dados da tabela *estado*
results <- dbReadTable(con,"estado")
results

#Consulta os dados da tabela *estado*
query <- "SELECT * FROM estado;"

results <- dbSendQuery(con,query)
results

# Limpa os dados da variável results
dbClearResult(results)

results <- dbGetQuery(con,query)
results

#Realizar o commit dos dados use o comando abaixo. 

#dbCommit(con)


# Verifique se o caminho do arquivo existe.

#Salvar o resultado da query no arquivo CSV
write.csv(results,"C:/Bootcamp/Datasets/CSV/estadosDB.csv",row.names=FALSE,quote=FALSE)


# Desconectar do banco de dados
dbDisconnect(con)
