###Prática no R! Roteiro 7 - Regressão Espacial
# https://luisfelipebr.github.io/mti2020/roteiros/roteiro7.html

#1. introdução

install.packages("tidyverse")
install.packages("sf")
install.packages("spdep")
install.packages("spatialreg")
install.packages("spgwr")
install.packages("Rcpp")

library(tidyverse)
library(sf)
library(spdep)
library(spatialreg)
library(spgwr)

BD_dist_sf <- read_sf("C:/Users/tvzgo/OneDrive/Área de Trabalho/programação/Aulas/MTI/dados/BD_20210815.gpkg")

BD_dist_sf <- BD_dist_sf %>%
  filter(!is.na(dif_EuclRede) & !is.na(POP_URB_10) & !is.na(IDH) & !is.na(POP_2016))

BD_dist_sf <- BD_dist_sf %>%
  mutate(LON = st_coordinates(st_centroid(BD_dist_sf))[,1],
         LAT = st_coordinates(st_centroid(BD_dist_sf))[,2])

str(BD_dist_sf)

plot(BD_dist_sf)


#2. modelos de regressão espacial global

modelo1 <- lm(formula = dif_EuclRede ~ IDH, 
              data = BD_dist_sf, 
              na.action = na.exclude)

w <- poly2nb(pl = BD_dist_sf, 
             row.names = BD_dist_sf$CD_GEOCODM)

summary(w)

wm <- nb2mat(neighbours = w, style='B', zero.policy = TRUE)
rwm <- mat2listw(x = wm, style='W')

lm.morantest(model = modelo1, 
             listw = rwm, 
             alternative = "two.sided",
             zero.policy = TRUE)

lm.LMtests(model = modelo1,
           listw = rwm,
           test = c("LMerr","LMlag","RLMerr","RLMlag"),
           zero.policy = TRUE)


