
# c3 general

p1 <- ggplot(c3t10r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p2 <- ggplot(c3t25r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p3 <- ggplot(c3t50r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p4 <- ggplot(c3t100r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")


# c3 detail

p1 <- ggplot(c3t25r0 %>% filter(class > 1), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-47710,-47700)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p2 <- ggplot(c3t50r0 %>% filter(class > 1), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-93850,-93800)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p3 <- ggplot(c3t100r0 %>% filter(class > 1), aes(x = as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-200900,-200600)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1) / (p2 & p3) + plot_layout(guides = "collect")

# c3 time

times <- c3t10r0 %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c3t10r0 %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c3t10r0 %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c3",
    method == 1 ~ "1_c3",
    method == 2 ~ "2_c3"
  ))
times_10 <- rbind(times, temptime)
p1 <- ggplot(times_10, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

times <- c3t25r0 %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c3t25r0 %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c3t25r0 %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c3",
    method == 1 ~ "1_c3",
    method == 2 ~ "2_c3"
  ))
times_25 <- rbind(times, temptime)
p2 <- ggplot(times_25, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

times <- c3t50r0 %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c3t50r0 %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c3t50r0 %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c3",
    method == 1 ~ "1_c3",
    method == 2 ~ "2_c3"
  ))
times_50 <- rbind(times, temptime)
p3 <- ggplot(times_50, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

times <- c3t100r0 %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c3t100r0 %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c3t100r0 %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c3",
    method == 1 ~ "1_c3",
    method == 2 ~ "2_c3"
  ))
times_100 <- rbind(times, temptime)
p4 <- ggplot(times_100, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")



# c6 general

p1 <- ggplot(c6t10r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p2 <- ggplot(c6t25r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p3 <- ggplot(c6t50r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p4 <- ggplot(c6t100r0, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")


# c6 detail

p1 <- ggplot(c6t10r0 %>% filter(class > 3), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-33565,-33555)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p2 <- ggplot(c6t25r0 %>% filter(class > 4), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-94765,-94750)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p3 <- ggplot(c6t50r0 %>% filter(class > 4), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-184981,-184972)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p4 <- ggplot(c6t100r0 %>% filter(class > 4), aes(x = as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-395600,-395525)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")

# c6 time

times <- c6t10r0 %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c6t10r0 %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c6t10r0 %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c3",
    method == 1 ~ "1_c3",
    method == 2 ~ "2_c3"
  ))
times_10 <- rbind(times, temptime)
p1 <- ggplot(times_10, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

times <- c6t25r0 %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c6t25r0 %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c6t25r0 %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c3",
    method == 1 ~ "1_c3",
    method == 2 ~ "2_c3"
  ))
times_25 <- rbind(times, temptime)
p2 <- ggplot(times_25, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

times <- c6t50r0 %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c6t50r0 %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c6t50r0 %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c3",
    method == 1 ~ "1_c3",
    method == 2 ~ "2_c3"
  ))
times_50 <- rbind(times, temptime)
p3 <- ggplot(times_50, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

times <- c6t100r0 %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c6t100r0 %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c6t100r0 %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c3",
    method == 1 ~ "1_c3",
    method == 2 ~ "2_c3"
  ))
times_100 <- rbind(times, temptime)
p4 <- ggplot(times_100, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")









