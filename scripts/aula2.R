#5. explorando os dados

View(BD_20210714) #função View(), que permite a visualização interativa de uma tabela, existem diversas outras funções que permitem explorar uma base de dados
names(BD_20210714) #A função names() exibe o nome de todas as variáveis da base de dados no Console
head(BD_20210714) #A função head() exibe as primeiras observações da base de dados no Console, sem a necessidade de abrir uma nova aba em Source
tail(BD_20210714) #A função tail(), de forma similar, exibe as últimas observações da base de dados no Console.'
str(BD_20210714) #A função str() exibe a estrutura da base de dados, com a classe da base de dados, o número de observações e variáveis, o nome de cada variável, a classe de cada variável (se é numérica, lógica, caractére ou outra) e as primeiras observações
summary(BD_20210714)#A função summary() apresenta um sumário de estatísticas descritivas (mínimo, 1º quartil, mediana, média, 3º quartil, máximo e valores faltantes - NA’s) para todas as variáveis numéricas
    

#6. criando um subconjunto

BD_20210714 [1:6,] #similar ao head
BD_20210714 [1:6,2] #head + seleção de uma coluna (numero)
BD_20210714 [1:6,'NOME_MUNIC'] #head + seleção de uma coluna (nome da coluna)
BD_20210714 [1:6,]$NOME_MUNIC #head + seleção de uma coluna (operador $)

BD_20210714 [1:6,c('NOME_MUNIC', 'RM')] #head + seleção de duas colunas (função concatenar)

BD_20210714 [ which(BD_20210714$RM == 'São Paulo' & BD_20210714$POP_2010 > 250000),c("NOME_MUNIC","POP_2010")] #filtro (RMSP e pop>250k) com colunas muni e pop


#7. criando tabela de contigência

table(BD_20210714$RM) #contagem da variavel RM
table(BD_20210714$RM, BD_20210714$PART_16) #tabela RM x Partido em 2016


#8. definindo uma nova variável


