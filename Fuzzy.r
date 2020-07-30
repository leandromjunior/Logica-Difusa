install.packages("sets", dependencies = T)
library(sets)

#Definição do universo // Universe definition
sets_options("universe", seq(1, 100, 1)) # seq de 1-100 de um em um

#Criação das variáveis // Variables creation
variaveis <- set(
  Frequencia = fuzzy_partition(varnames = c(menDuasSemanas = 30, maisDuasSemanas =60, diario = 70, continuo = 90), radius=20, FUN = fuzzy_cone),
  SABA = fuzzy_partition(varnames = c(menDuasSemanas = 20, maisDuasSemanas = 30, diario = 70, duasxDia = 90), sd = 10),
  DebitoExpiracao = fuzzy_partition(varnames = c(CinqOiten = 20, TrintTCinqCin = 30, maisTrintT = 70), sd = 10),
  Classificacao = fuzzy_partition(varnames = c(moderada = 20, agudaGrave = 40, riscoVida = 60), sd = 10)
)

#Definição das regras // Rules Definition
regras <- set(
  fuzzy_rule(Frequencia %is% menDuasSemanas && SABA %is% menDuasSemanas && DebitoExpiracao %is% CinqOiten, Classificacao %is% moderada), #CinqOiten: 50%-80%
  fuzzy_rule(Frequencia %is% menDuasSemanas && SABA %is% menDuasSemanas && DebitoExpiracao %is% TrintTCinqCin, Classificacao %is% moderada), #TrintTCinqCin: 33% - 55%
  fuzzy_rule(Frequencia %is% menDuasSemanas && SABA %is% menDuasSemanas && DebitoExpiracao %is% maisTrintT, Classificacao %is% moderada), #maisTrintT: >33%
  fuzzy_rule(Frequencia %is% menDuasSemanas && SABA %is% maisDuasSemanas && DebitoExpiracao %is% TrintTCinqCin, Classificacao %is% moderada),
  fuzzy_rule(Frequencia %is% maisDuasSemanas && SABA %is% menDuasSemanas && DebitoExpiracao %is% CinqOiten, Classificacao %is% moderada),
  fuzzy_rule(Frequencia %is% maisDuasSemanas && SABA %is% menDuasSemanas && DebitoExpiracao %is% maisTrintT, Classificacao %is% moderada),
  fuzzy_rule(Frequencia %is% maisDuasSemanas && SABA %is% maisDuasSemanas && DebitoExpiracao %is% CinqOiten, Classificacao %is% moderada),
  fuzzy_rule(Frequencia %is% maisDuasSemanas && SABA %is% maisDuasSemanas && DebitoExpiracao %is% TrintTCinqCin, Classificacao %is% moderada),
  fuzzy_rule(Frequencia %is% diario && SABA %is% diario && DebitoExpiracao %is% TrintTCinqCin, Classificacao %is% agudaGrave),
  fuzzy_rule(Frequencia %is% diario && SABA %is% diario && DebitoExpiracao %is% CinqOiten, Classificacao %is% agudaGrave),
  fuzzy_rule(Frequencia %is% diario && SABA %is% duasxDia && DebitoExpiracao %is% TrintTCinqCin, Classificacao %is% agudaGrave),
  fuzzy_rule(Frequencia %is% diario && SABA %is% duasxDia && DebitoExpiracao %is% maisTrintT, Classificacao %is% agudaGrave),
  fuzzy_rule(Frequencia %is% continuo && SABA %is% diario && DebitoExpiracao %is% TrintTCinqCin, Classificacao %is% riscoVida),
  fuzzy_rule(Frequencia %is% continuo && SABA %is% diario && DebitoExpiracao %is% maisTrintT, Classificacao %is% riscoVida),
  fuzzy_rule(Frequencia %is% continuo && SABA %is% duasxDia && DebitoExpiracao %is% TrintTCinqCin, Classificacao %is% riscoVida),
  fuzzy_rule(Frequencia %is% continuo && SABA %is% dusxDia && DebitoExpiracao %is% maisTrintT, Classificacao %is% riscoVida)
)

#Construção do sistema // System Building
sistema <- fuzzy_system(variaveis, regras)
sistema
plot(sistema)

#Fazendo inferencia
inferencia <- fuzzy_inference(sistema, list(Frequencia = 80, SABA = 70, DebitoExpiracao = 80))
inferencia
plot(inferencia)

#defuzication
#method = c("meanofmax", "smallestofmax", "largestofmax", "centroid")
gset_defuzzify(inferencia, "centroid")

#Analisando de forma "realista" o resultado (Executar ambas as linhas simultaneamente)
plot(sistema$variables$Classificacao)
lines(inferencia, col = "red", lwd = 4)

#Desfazendo o universo
sets_options("universe", NULL)
