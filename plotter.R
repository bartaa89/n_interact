path = "data.csv"

malt = 0.814 # Malthusian parameter

data <- read.csv(path)

t = table(data$type)

N = max(data$type)
freq = c()

plot(0,0, ylim = c(0,log(max(t))), xlim = c(0,max(data$time)), t = 'n', 
     ylab = "Number of individuals (log)", xlab = "Time", cex.lab = 2)

for(tp in seq(1,max(data$type))){
  x = data$time[data$type==tp]
  y = seq(1,length(x))
  freq = c(freq, y[length(y)])
  lines(x,log(y),t='l',col=tp+1)
}

legend("topleft",legend = paste(1:N,"-cliques",sep = ''), col = 2:(N+1), 
       pch = 19, cex = 1.4, bty = 'n' , y.intersp=0.5)
abline(0,malt, lty = 2)
grid()
