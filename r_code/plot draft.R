
# c3 general

p1 <- ggplot(c3t10r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()

p2 <- ggplot(c3t25r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()

p3 <- ggplot(c3t50r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()

p4 <- ggplot(c3t100r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")
