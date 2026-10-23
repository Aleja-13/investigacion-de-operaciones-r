library(deaR)
require(lpSolve)
require(xlsReadWrite)
library(xlsx) 


#Import dataset

data <- read_excel("datos/DEA_R.xlsx")
inputs <- data.frame(data[2])
outputs<-data.frame(data[c(3,4,5)])
N <- dim(data)[1]
s <- dim(inputs)[2]
m <- dim(outputs)[2] 

#CRS model
f.rhs <- c(rep(0,1,N),1)
f.dir <- c(rep("<=",1,N),"=")
aux <- cbind(-1*inputs,outputs)

for (i in 1:N) {
  f.obj <- c(0*rep(1,s),as.numeric(outputs[i,]))
  f.con <- rbind(aux ,c(as.numeric(inputs[i,]), rep(0,1,m)))
  results <- lp ("max",as.numeric(f.obj), f.con, f.dir, f.rhs,scale=0, compute.sens=TRUE)
  if (i==1) {
    weights <- results$solution
    effcrs <- results$objval
    lambdas <- results$duals[seq(1,N)]
  } else {
    weights <- rbind(weights, results$solution)
    effcrs <- rbind(effcrs , results$objval)
    lambdas <- rbind(lambdas, results$duals[seq(1,N)] )
  }
}

#### merge the efficiency and multipliers
spreadsheet <- cbind(effcrs,weights)
spreadsheet
rownames(spreadsheet) <- data[,1]
colnames(spreadsheet) <- c('efficiency',names(inputs),names(outputs))
write.xlsx(spreadsheet ,"resultscrs.xls",colNames = TRUE,sheet = 1,from = 1)

###Visualizing the results
palette(gray(0:8 / 8)) # set color palette
virtual<-weights[,(s+1):(s+m)]*outputs # virtual outputs
rownames(virtual)<-data[,1] # assign utilities’ names to the rows of the object virtual
barplot(t(virtual),col=palette()[c(1,4,7)],ylab="Efficiency",cex.axis=1,cex.lab=1,cex.names=1,las=3)
legend("topright",inset=c(-0.45,0),colnames(virtual),fill=palette()[c(1,4,7)],bty="n") # add legend

#Obtain Lambdas

spreadsheet2<-lambdas
spreadsheet2
rownames(spreadsheet2)<-data[,1]
colnames(spreadsheet2)<- data[,1] 
write.xlsx(spreadsheet2 ,"dualscrs.xls",col.names = TRUE)

###Visualizing the results

palette(gray(0:8 / 8)) # set color palette
rownames(lambdas)<-data[,1] # assigns utilities’ names to the rows of duals variables matrix
colnames(lambdas)<-data[,1] # assigns utilities’ names to the colimns of duals variables matrix
peer<-which(apply(lambdas,2,sum)>0) # identifies reference units (efficiency units)
barplot(t(lambdas[,peer]),col=palette()[c(1,4,7)],cex.axis=1,cex.lab=1,cex.names=1,las=3)
legend("topright",colnames(lambdas)[peer],fill=palette()[c(1,4,7)],bty="n") # add legend


#####VRS model
f.rhs <- c(rep(0,1,N),1)
f.dir<-c(rep("<=",1,N), "=")
aux <- cbind(-1*inputs,outputs,1,-1) 

for (i in 1:N) {
  f.obj<-c(rep(0,1,s),as.numeric(outputs[i,]),1,-1) # 1 and -1 represents u+ - u-
  f.con <- rbind(aux,c(as.numeric(inputs[i,]),rep(0,1,m),0,0))
  results <- lp ("max",as.numeric(f.obj), f.con, f.dir, f.rhs,scale=1, compute.sens=TRUE)
  multipliers <- results$solution
  u0 <- multipliers[s+m+1]-multipliers[s+m+2]
  if (i==1) {
    weights <- c(multipliers[seq(1,s+m)],u0)
    effvrs <- results$objval
    lambdas <- results$duals[seq(1,N)]
  } else {
    weights<-rbind(weights,c(multipliers[seq(1,s+m)],u0))
    effvrs <- rbind(effvrs , results$objval)
    lambdas <- rbind(lambdas,results$duals[seq(1,N)])
  }
}

spreadsheet2<-cbind(effvrs,weights) # merge de results
rownames(spreadsheet2)<-data[,1] # assign the utilities’ names to spreadsheet rows
colnames(spreadsheet2)<-c('efficiency',names(inputs), names(outputs),'u0')
write.xlsx(spreadsheet2,"resultsvrs.xls",col.names = TRUE) 


#Visualisation 
scale <- effcrs/effvrs
spreadsheet3 <- cbind(effcrs,effvrs,scale)
rownames(spreadsheet3) <- data[,1]
colnames(spreadsheet3) <- c("CRS","VRS","SE")
barplot(t(spreadsheet3),
        col=palette()[c(1,4,7)],ylab="Efficiency",beside=TRUE,cex.axis=1,cex.lab=1,cex.names=1,las=3)
legend("topright",inset=c(-0.2,0),colnames(spreadsheet),fill=palette()[c(1,4,7)],bty="n") # add legend

