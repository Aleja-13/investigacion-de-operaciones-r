install.packages("lpSolve")
library(lpSolve)

# Muebleria Jamar

### Max: Z= 18000X1+7500X2+22500X3+27000X4

# Sujeto a:

# 5X1 + X2 + 9X3 + 12X4 <= 3600
# 2X1 + 3X2 + 4X3 + 3X4 <= 2000
# 3X1 + 2X2 + 5X3 + 10X4 <= 1200
# X1 >= 40
# X2 >= 130
# X1 >= 30
# X1 <= 10


funcion_objetivo<- c(18000,7500,22500,27000)
restricciones1<-matrix(c(5,1,9,12,2,3,4,3,3,2,5,10,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1), nrow = 7, byrow = TRUE)
restricciones1
direccion<- c("<=", "<=","<=",">=", ">=", ">=", "<=")
restricciones2<-c(3600,2000,1200,40,130,30,10)

lp(direction = "max", objective.in = funcion_objetivo, const.mat = restricciones1, const.dir = direccion, const.rhs = restricciones2,int.vec = c(1,2,3,4,5), all.int = TRUE)

lp(direction = "max", objective.in = funcion_objetivo, const.mat = restricciones1, const.dir = direccion, const.rhs = restricciones2,int.vec = c(1,2,3,4,5), all.int = TRUE)$solution


# HEINZ

### ????????????(????)=0.2????+0.3????+0.4????

# Sujeto a:

# 120000 + 90000B + 72000C <= 7200000
# A <= 24
# B <= 15
# C <= 12
# 2A-B >= 0
# B-C >= 0




funcion_objetivo2<- c(0.2,0.3,0.4)
restriccionesH<-matrix(c(120000,90000,72000,1,0,0,0,1,0,0,0,1, 2,-1,0, 0,1,-1), nrow = 6, byrow = TRUE)
restriccionesH
direccionH<- c("<=", "<=","<=","<=", ">=", ">=")
restriccionesH2<-c(7200000,24,15,12,0,0)

lp(direction = "max", objective.in = funcion_objetivo2, const.mat = restriccionesH, const.dir = direccionH, const.rhs = restriccionesH2,int.vec = c(1,2,3,4,5), all.int = TRUE)

lp(direction = "max", objective.in = funcion_objetivo2, const.mat = restriccionesH, const.dir = direccionH, const.rhs = restriccionesH2,int.vec = c(1,2,3,4,5), all.int = TRUE)$solution
