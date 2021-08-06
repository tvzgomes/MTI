install.packages("edgebundle")
install.packages("igraph")
install.packages("ggforce")

library(edgebundle)
library(tidyverse)
library(igraph)
library(ggforce)

g <- us_flights
xy <- cbind(V(g)$longitude,V(g)$latitude)
verts <- data.frame(x=V(g)$longitude,y=V(g)$latitude)

fbundle <- edge_bundle_force(g,xy,compatibility_threshold = 0.6)
sbundle <- edge_bundle_stub(g,xy)
hbundle <- edge_bundle_hammer(g,xy,bw = 0.7,decay = 0.5)

states <- map_data("state")


p1 <- ggplot()+
  geom_polygon(data=states,aes(long,lat,group=group),col="white",size=0.1,fill=NA)+
  geom_path(data = fbundle,aes(x,y,group=group),col="#9d0191",size=0.05)+
  geom_path(data = fbundle,aes(x,y,group=group),col="white",size=0.005)+
  geom_point(data = verts,aes(x,y),col="#9d0191",size=0.25)+
  geom_point(data = verts,aes(x,y),col="white",size=0.25,alpha=0.5)+
  geom_point(data=verts[verts$name!="",],aes(x,y), col="white", size=3,alpha=1)+
  labs(title="Force Directed Edge Bundling")+
  ggraph::theme_graph(background = "black")+
  theme(plot.title = element_text(color="white"))

p2 <- ggplot()+
  geom_polygon(data=states,aes(long,lat,group=group),col="white",size=0.1,fill=NA)+
  geom_path(data = hbundle,aes(x,y,group=group),col="#9d0191",size=0.05)+
  geom_path(data = hbundle,aes(x,y,group=group),col="white",size=0.005)+
  geom_point(data = verts,aes(x,y),col="#9d0191",size=0.25)+
  geom_point(data = verts,aes(x,y),col="white",size=0.25,alpha=0.5)+
  geom_point(data=verts[verts$name!="",],aes(x,y), col="white", size=3,alpha=1)+
  labs(title="Hammer Edge Bundling")+
  ggraph::theme_graph(background = "black")+
  theme(plot.title = element_text(color="white"))

alpha_fct <- function(x,b=0.01,p=5,n=20){
  (1-b)*(2/(n-1))^p * abs(x-(n-1)/2)^p+b
}

p3 <- ggplot()+
  geom_polygon(data=states,aes(long,lat,group=group),col="white",size=0.1,fill=NA)+
  ggforce::geom_bezier(data = sbundle,aes(x,y,group=group,
                                          alpha=alpha_fct(..index..*20)),n=20,
                       col="#9d0191",size=0.1,show.legend = FALSE)+
  ggforce::geom_bezier(data = sbundle,aes(x,y,group=group,
                                          alpha=alpha_fct(..index..*20)),n=20,
                       col="white",size=0.01,show.legend = FALSE)+
  geom_point(data = verts,aes(x,y),col="#9d0191",size=0.25)+
  geom_point(data = verts,aes(x,y),col="white",size=0.25,alpha=0.5)+
  geom_point(data=verts[verts$name!="",],aes(x,y), col="white", size=3,alpha=1)+
  labs(title="Stub Edge Bundling")+
  ggraph::theme_graph(background = "black")+
  theme(plot.title = element_text(color="white"))
p1
p2
p3
