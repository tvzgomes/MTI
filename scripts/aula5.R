###Prática no R! Roteiro 5 - Regressão linear
# https://luisfelipebr.github.io/mti2020/roteiros/roteiro5.html

#1. introdução

install.packages("tidyverse")
install.packages("performance")
install.packages("broom")

library(tidyverse)
library(performance)
library(broom)

BD_dist <- read.csv2("C:/Users/tvzgo/OneDrive/Área de Trabalho/programação/Aulas/MTI/dados/BD_20210814.csv", encoding="UTF-8")

#2. regressão linear simples

modelo1 <- lm(formula = dif_EuclRede ~ IDH, data = BD_dist, na.action = na.exclude)
summary(modelo1)

plot(modelo1, which = 1)

plot(modelo1, which = 2)

plot(modelo1, which = 3)

plot(modelo1, which = 4)

plot(modelo1, which = 5)

plot(modelo1, which = 6)

plot(x = BD_dist$IDH, 
     y =  BD_dist$dif_EuclRede,
     xlab = "IDH",
     ylab = "distância")
abline(modelo1, col = "red") 

ggplot(data = BD_dist , aes(x = IDH, y = dif_EuclRede)) +
  geom_point() +
  geom_smooth(data = lm(formula = dif_EuclRede ~ IDH, data = BD_dist), method = "lm", col = "red", se = FALSE) +
  theme_bw() +
  xlab("IDH") +
  ylab("distância")

#3. regressão linear multipla

modelo2 <- lm(formula = dif_EuclRede ~ IDH + POP_URB_10, data = BD_dist, na.action = na.exclude)
modelo3 <- lm(formula = dif_EuclRede ~ IDH + POP_URB_10 + PD, data = BD_dist, na.action = na.exclude)

summary(modelo2)
summary(modelo3)

#4. comparando modelos

tabela_modelos <- compare_performance(modelo1, modelo2, modelo3, rank = TRUE)
tabela_modelos

#5. regressão linear mmultipla - stepwise

modelo4 <- lm(formula = dif_EuclRede ~ IDH + RENDA + POP_URB_10 + PD + PDMU + POP_2016 + PRIN_ATIVIDADE, data = BD_dist, na.action = na.exclude)
summary(modelo4)
              
modelo5 <- step(modelo4, direction = "both")
summary(modelo5)

tabela_modelos <- compare_performance(modelo1, modelo2, modelo3, modelo4, modelo5, rank = TRUE)
tabela_modelos
