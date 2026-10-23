set.seed(1234567)
library(queueing)
library(simmer)
library(simmer.plot)

tasa_llegada7 <- 1:6
n_clientes7 <- 7
for (i in tasa_llegada7){
  I7_mmck <- NewInput.MMCK(lambda = i, mu = n_clientes7, k=1)
  Output7_mmck <- QueueingModel(I7_mmck)
  Report(Output7_mmck)
  Summary(Output7_mmck)
}
lambda7 <- 1
while (lambda7 < 7)
{
  texto_general <- paste("Lambda entre 1 y 7 ",lambda7, "mu 6")
  print(texto_general)
  modelo_mmck<-NewInput.MMCK((lambda7),(6),1,1)
  lambda7 <- lambda7 + 1
}
lambda<- 1
while (lambda < 8)
{
  texto_general <- paste("Lambda",lambda, "y miu entre 3 y 9")
  print(texto_general)
  modelo_mm1<-NewInput.MMCK((lambda),(3:9))
  lambda <- lambda + 1
}

lambda7 <- 1:6
mu7 <-7
m.mck.7 <- trajectory() %>%
  seize("server", amount = 1) %>%
  timeout(function() rexp(1, mu7))%>%
  release("server", amount = 1)

mmck7.env <- simmer()%>%
  add_resource("server", capacity =1, queue_size = 1) %>%
  add_generator("arrival",m.mck.7,function() rexp(1,lambda7)) %>%
  run(until = 2000)

#se rechaza cuando el sistema está saturado
get_mon_arrivals(mmck7.env)%>%
  with(sum(!finished) / length(finished))
#analizar el comportamiento del sistema 

rho_mmck <- lambda7/mu7
#Evolución del número promedio de clientes 

plot(get_mon_resources(mmck7.env), "usage", "server", items="system") +
  geom_hline(yintercept=0.01613717)
