###Aula 4 - banco de dados novos com distancias

#1. introdução

install.packages("tidyverse")
install.packages("corrplot")
install.packages("Hmisc")

library(tidyverse)
library(corrplot)
library(Hmisc)

BD_dist <- read.csv2("C:/Users/tvzgo/OneDrive/Área de Trabalho/programação/Aulas/MTI/dados/BD_20210814.csv", encoding="UTF-8")

#histograma
ggplot(data = BD_dist, aes(x = dif_EuclRede)) +
  geom_histogram()

#histograma por região
ggplot(data = BD_dist, aes(y = dif_EuclRede, fill = RM)) +
  geom_histogram() +
  facet_wrap(~RM) +
  ggtitle("Histograma de veículo/habitante por RM") +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(legend.position = "none")

#boxplot por região
ggplot(data = BD_dist, aes(y = dif_EuclRede, fill = RM)) +
  geom_boxplot() +
  facet_wrap(~RM) +
  ggtitle("Histograma da diferença de distâncias por RM") +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(legend.position = "none")

#violin por região
ggplot(data = BD_dist, aes(x = RM, y = dif_EuclRede)) +
  geom_violin() +
  ggtitle("Violin da diferença de distâncias por RM")

#2. diagrama de dispersão

ggplot(data = BD_dist , aes(x = dif_EuclRede, y = RENDA)) +
  geom_point() +
  theme_bw() +
  xlab("distância") +
  ylab("renda média per capta")

ggplot(data = BD_dist , aes(x = dif_EuclRede, y = IDH)) +
  geom_point() +
  theme_bw() +
  xlab("distância") +
  ylab("IDH")

ggplot(data = BD_dist , aes(x = dif_EuclRede, y = POP_2016)) +
  geom_point() +
  theme_bw() +
  xlab("distância") +
  ylab("população")

#3. coeficiente de correlação

cor(x = BD_dist$dif_EuclRede, 
    y = BD_dist$RENDA,
    method = "pearson",
    use = "complete.obs")

cor(x = BD_dist$dif_EuclRede, 
    y = BD_dist$IDH,
    method = "pearson",
    use = "complete.obs")

cor(x = BD_dist$dif_EuclRede, 
    y = BD_dist$POP_2016,
    method = "pearson",
    use = "complete.obs")

#4. teste de significância

cor.test(x = BD_dist$dif_EuclRede, 
         y = BD_dist$RENDA,
         method = "pearson",
         alternative = "two.sided",
         conf.level = 0.95)

cor.test(x = BD_dist$dif_EuclRede, 
         y = BD_dist$IDH,
         method = "pearson",
         alternative = "two.sided",
         conf.level = 0.95)

cor.test(x = BD_dist$dif_EuclRede, 
         y = BD_dist$POP_2016,
         method = "pearson",
         alternative = "two.sided",
         conf.level = 0.95)

#5. matriz de correlação

BD_dist %>%
  select(dif_EuclRede, RENDA, IDH, POP_2016) %>%
  cor(method = "pearson",
      use = "complete.obs") %>%
  round(digits = 2)

#plotar matriz
BD_dist %>%
  select(dif_EuclRede, RENDA, IDH, POP_2016) %>%
  cor(method = "pearson",
      use = "complete.obs") %>%
  corrplot(method = "number") #method = "color" ou method = "number"

BD_dist %>%
  select(dif_EuclRede, RENDA, IDH, POP_2016) %>%
  as.matrix() %>%
  rcorr(type = "pearson")
