# Aula inicial de de R: 1.abertura/importação dos arquivos, 2. criando novo script, 


#3. definindo diretório de trabalho,
getwd()

#4. importando base de dados
BD_20210714 <- read.csv2("~/dados/BD_20210714.csv", encoding="UTF-8")

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

BD_20210714$VEIC_HAB <- BD_20210714$VEIC_2016 / BD_20210714$POP_2016
#criando a relação veiculo/habitante


#9. calculando estatísticas básicas
    #argumento opcional na.rm = TRUE para remover os valores faltantes (NA).

mean(BD_20210714$VEIC_HAB, na.rm = TRUE) #calulando a média
median(BD_20210714$VEIC_HAB, na.rm = TRUE) #calulando a mediana
var(BD_20210714$VEIC_HAB, na.rm = TRUE) #calulando a variancia
sd(BD_20210714$VEIC_HAB, na.rm = TRUE) #calulando o desvio padrão


#9. desenhando graficos

#box-plot
boxplot(BD_20210714$VEIC_HAB)

#histograma
hist(BD_20210714$VEIC_HAB)

#qqplot
qqnorm(BD_20210714$VEIC_HAB)
qqline(BD_20210714$VEIC_HAB, col = "red")


#10. exportando gráficos
    #pgn() para selecionar a figura e dev.off() para finalizar o comando 

# box-plot
png("graficos/boxplot_vec_hab16.png")
boxplot(BD_20210714$VEIC_HAB)
dev.off()

#histograma
png("graficos/hist_vec_hab16.png")
hist(BD_20210714$VEIC_HAB)
dev.off()

#qqplot
png("graficos/qqplot_vec_hab16.png")
qqnorm(BD_20210714$VEIC_HAB)
qqline(BD_20210714$VEIC_HAB, col = "red")
dev.off()


#11. exportanto a base de dados

write.csv2 (BD_20210714, "dados/BD_20210718.csv", row.names = FALSE)


