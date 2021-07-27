#2. instalando o tidyverse

install.packages("tidyverse")
library(tidyverse) # é necessário abrir o pacote todas as vezes que o programa R/RStudio é aberto ou a sessão é reiniciada.

BD_20210714 <- read.csv2("C:/Users/tvzgo/OneDrive/Área de Trabalho/programação/Aulas/MTI/dados/BD_20210714.csv")
zonas <- read.csv2("C:/Users/tvzgo/OneDrive/Área de Trabalho/programação/Aulas/MTI/dados/zonas.csv")

#4. filtrar e selecionar

BD_20210714 [which(BD_20210714$RM == "São Paulo" & BD_20210714$IDH > 0.8),c("NOME_MUNIC", "IDH")] #filtro comum

BD_20210714 %>% #filtro com parâmetro %>% do tydeverse
  filter(RM == "São Paulo" & IDH > 0.8) %>%
  select(NOME_MUNIC, IDH)

#5. transformação

BD_20210714$VEIC_HAB <- BD_20210714$VEIC_2016 / BD_20210714$POP_2016
BD_20210714$AUTO_HAB <- BD_20210714$AUTO_2016 / BD_20210714$POP_2016
BD_20210714$MOTO_HAB <- BD_20210714$MOTO_2016 / BD_20210714$POP_2016 

# essa mesma criação com tidyverse
BD_20210726 <- BD_20210714 %>%
  mutate(VEIC_HAB = VEIC_2016 / POP_2016,
         AUTO_HAB = AUTO_2016 / POP_2016,
         MOTO_HAB = MOTO_2016 / POP_2016)

#6. união

#left_join(): Adiciona à primeira base as variáveis da segunda base que possuem correspondência ao identificador.
#right_join(): Adiciona à segunda base as variáveis da primeira base possuem correspondência ao identificador.
#inner_join(): O resultado é uma base de dados que exclui as observações sem correspondência ao identificador.
#full_join(): O resultado é uma base de dados com todas as observações, da primeira e segunda base, adicionando valores faltantes (NA) quando não há correspondência ao identificador.

BD_zonas <- zonas %>%
  select(-c(NOME_MUNIC, RM)) %>% 
  full_join(BD_20210726, by = "CODMUNDV") #tive muitos problemas pq uma base estava em UTF-8 e outra no padrão do sistema

#7. agrupar e resumir 

tabela_vechab <- BD_zonas %>%
  group_by(RM) %>%
  drop_na(VEIC_HAB) %>%
  summarize(n_obs = n(),
            media = mean(VEIC_HAB),
            desvio_padrao = sd(VEIC_HAB)) %>%
  mutate(erro = 1.96*desvio_padrao/sqrt(n_obs),
         limite_superior = media + erro,
         limite_inferior = media - erro)

tabela_vechab

#8. gráficos (ggplot)

#histograma
ggplot(data = BD_zonas, aes(x = VEIC_HAB)) +
  geom_histogram()

#histograma por região
ggplot(data = BD_zonas, aes(x = VEIC_HAB, fill = RM)) +
  geom_histogram() +
  facet_wrap(~RM) +
  ggtitle("Histograma de veículo/habitante por RM") +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(legend.position = "none")

#boxplot por região
ggplot(data = BD_zonas, aes(y = VEIC_HAB, fill = RM)) +
  geom_boxplot() +
  facet_wrap(~RM) +
  ggtitle("Histograma de veículo/habitante por RM") +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(legend.position = "none")

#colunas por região
ggplot(data = tabela_vechab, aes(x = RM, y = media, fill=RM)) +
  geom_col() +
  geom_errorbar(aes(ymin = limite_inferior, ymax = limite_superior)) +
  ggtitle("Média e intervalo de confiança de veículo/habitante por RM") +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(legend.position = "none")

write.csv2(BD_zonas, "dados_zonas.csv", row.names = FALSE)
