#instala pacote
#install.packages('readr')

#importa pacote
library('readr')


datasetpath <- 'C:/Bootcamp/Datasets/CSV'

# Importar (ler) os dados do arquivo CSV de valores separados por virgulas
file1 <- paste(datasetpath,"/contabilidade.csv",sep="")

data0 <- read.csv(file1)
print(data0)

data1 <- read.csv2(file1)
print(data1)

data2 <- read.table(paste(datasetpath,"/Iris.csv",sep=""),header=T,sep=",")
head(data2)

summary(data2)

datasetpath <- 'C:\\Bootcamp\\Datasets\\TXT'
file3 <- paste(datasetpath,"\\noticias.txt",sep="")
data3 <- read.delim(file3,encoding='utf-8')
data3

data4 <- read.delim(file.choose(),encoding='utf-8')
data4

install.packages("readxl")

library(readxl)

data5 <- read_excel(file.choose())
data5

# Importar (ler) os dados do arquivo CSV de valores separados por virgulas
iris <- read.csv('C:/Bootcamp/Datasets/CSV/Iris.csv')

# Imprimir as 6 primeiras linhas do vetor iris 
head (iris);

# Imprimir as 3 primeiras linhas do vetor iris 
head (iris, 3);

# Imprimir todas as linhas do vetor iris
print(iris);

#Resumo das estatísticas descritivas: a observação mínima, 1a quartil (25%), 
# mediana (50%), media aritmética, 3a quartil (75%) e a máxima são 
#exibidos para cada amostra.
summary(iris);

# Boxplot mostrando a mediana (linha horizontal, quartis 25 % e 75 % (caixa verde - col=3) e observações máxima e
#mínima (linhas verticais) – ylab e xlab são as etiquetas dos eixos y e x, respectivamente.
boxplot(iris, col=3, ylab="Valores(cm)", xlab="Característica")

#Usa range=0 para não mostrar os outliers (observações extremas representadas como pontos)
boxplot(iris, range=0, col=2, ylab="Valores(cm)", xlab="Característica")
