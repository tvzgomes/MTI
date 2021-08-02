###Prática no R! Roteiro 4 - Correlação 
# https://luisfelipebr.github.io/mti2020/roteiros/roteiro4.html

#1. introdução

install.packages("tidyverse")
install.packages("corrplot")
install.packages("Hmisc")

library(tidyverse)
library(corrplot)
library(Hmisc)

#2. diagrama de dispersão

plot(x = BD_20210726$VEIC_HAB, 
     y = BD_20210726$RENDA)

#É possível ainda aprimorar o diagrama de dispersão adicionando alguns argumentos: 
    # xlab: um rótulo para o eixo x
    # ylab: um rótulo para o eixo y
plot(x = BD_20210726$VEIC_HAB, 
     y = BD_20210726$RENDA,
     xlab = "veículo por habitante",
     ylab = "renda média per capta")

ggplot(data = BD_20210726 , aes(x = VEIC_HAB, y = RENDA)) +
  geom_point() +
  theme_bw() +
  xlab("veículo por habitante") +
  ylab("renda média per capta")

#3. coeficiente de correlação

cor(x = BD_20210726$VEIC_HAB, 
    y = BD_20210726$RENDA,
    method = "pearson",
    use = "complete.obs")

#4. teste de significância

cor.test(x = BD_20210726$VEIC_HAB, 
         y = BD_20210726$RENDA,
         method = "pearson",
         alternative = "two.sided",
         conf.level = 0.95)

#5. matriz de correlação

BD_20210726 %>%
  select(VEIC_HAB, RENDA, VEIC_HAB, PIB_PER_CAP, IDH) %>%
  cor(method = "pearson",
      use = "complete.obs") %>%
  round(digits = 2)

#plotar matriz
BD_20210726 %>%
  select(VEIC_HAB, RENDA, VEIC_HAB, PIB_PER_CAP, IDH) %>%
  cor(method = "pearson",
      use = "complete.obs") %>%
  corrplot() #method = "color" ou method = "number"

BD_20210726 %>%
  select(VEIC_HAB, RENDA, VEIC_HAB, PIB_PER_CAP, IDH) %>%
  as.matrix() %>%
  rcorr(type = "pearson")


