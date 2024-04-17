
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
temptime <- c6t10r0 %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c6",
    method == 1 ~ "1_c6",
    method == 2 ~ "2_c6"
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
temptime <- c6t25r0 %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c6",
    method == 1 ~ "1_c6",
    method == 2 ~ "2_c6"
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
temptime <- c6t50r0 %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c6",
    method == 1 ~ "1_c6",
    method == 2 ~ "2_c6"
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
temptime <- c6t100r0 %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c6",
    method == 1 ~ "1_c6",
    method == 2 ~ "2_c6"
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


### 5k data

# c3 general

p1 <- ggplot(c3t10r05k, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p2 <- ggplot(c3t25r05k, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p3 <- ggplot(c3t50r05k, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p4 <- ggplot(c3t100r05k, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")


# c3 detail

p1 <- ggplot(c3t10r05k %>% filter(class > 1), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-83250,-83240)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p2 <- ggplot(c3t25r05k %>% filter(class > 1), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-238200,-238140)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p3 <- ggplot(c3t50r05k %>% filter(class > 1), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-465500,-465300)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p4 <- ggplot(c3t100r05k %>% filter(class > 1), aes(x = as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-1000000,-997500)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")

# c3 time

times <- c3t10r05k %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c3t10r05k %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c3t10r05k %>% filter(method < 3) %>% filter(class == 3) %>%
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

times <- c3t25r05k %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c3t25r05k %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c3t25r05k %>% filter(method < 3) %>% filter(class == 3) %>%
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

times <- c3t50r05k %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c3t50r05k %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c3t50r05k %>% filter(method < 3) %>% filter(class == 3) %>%
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

times <- c3t100r05k %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c3t100r05k %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c3t100r05k %>% filter(method < 3) %>% filter(class == 3) %>%
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

p1 <- ggplot(c6t10r05k, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p2 <- ggplot(c6t25r05k, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p3 <- ggplot(c6t50r05k, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p4 <- ggplot(c6t100r05k, aes(x = class, y = lnl, color = as.character(method)))+
  geom_point()+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")


# c6 detail

p1 <- ggplot(c6t10r05k %>% filter(class > 3), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-168975,-168960)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p2 <- ggplot(c6t25r05k %>% filter(class > 4), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-475810,-475800)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p3 <- ggplot(c6t50r05k %>% filter(class > 4), aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-923560,-923510)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

p4 <- ggplot(c6t100r05k %>% filter(class > 3), aes(x = as.character(class), y = lnl, color = as.character(method)))+
  geom_jitter(width = 0.25)+
  ylim(-1974000,-1970000)+
  geom_line(aes(group = rep))+
  theme_bw()+
  ggtitle("100 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

(p1 & p2) / (p3 & p4) + plot_layout(guides = "collect")

# c6 time

times <- c6t10r05k %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c6t10r05k %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c6t10r05k %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c6",
    method == 1 ~ "1_c6",
    method == 2 ~ "2_c6"
  ))
times_10 <- rbind(times, temptime)
p1 <- ggplot(times_10, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("10 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

times <- c6t25r05k %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c6t25r05k %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c6t25r05k %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c6",
    method == 1 ~ "1_c6",
    method == 2 ~ "2_c6"
  ))
times_25 <- rbind(times, temptime)
p2 <- ggplot(times_25, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("25 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

times <- c6t50r05k %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c6t50r05k %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c6t50r05k %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c6",
    method == 1 ~ "1_c6",
    method == 2 ~ "2_c6"
  ))
times_50 <- rbind(times, temptime)
p3 <- ggplot(times_50, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)')+
  theme_bw()+
  ggtitle("50 taxa")+
  theme(plot.title = element_text(hjust = 0.5))

times <- c6t100r05k %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(c6t100r05k %>%
              distinct(rep, method),
            by = "rep") %>%
  select(rep, runtime, method)
temptime <- c6t100r05k %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method) %>%
  mutate(method = case_when(
    method == 0 ~ "0_c6",
    method == 1 ~ "1_c6",
    method == 2 ~ "2_c6"
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

# HDR plot
a <- c6t50r0 %>% filter(class > 4) %>% filter( method == 1 | method == 5)
a <- a %>% mutate(dataset = '50 taxa, 6k sites')
b <- c6t100r0 %>% filter(class > 4) %>% filter( method == 1 | method == 5)
b <- b %>% mutate(dataset = '100 taxa, 6k sites')
c <- c6t50r05k %>% filter(class > 4) %>% filter( method == 1 | method == 5)
c <- c %>% mutate(dataset = '50 taxa, 30k sites')
d <- c6t100r05k %>% filter(class > 4) %>% filter( method == 1 | method == 5)
d <- d %>% mutate(dataset = '100 taxa, 30k sites')

plot_data <- rbind(a,b,c,d)
plot_data <- plot_data %>% mutate(method = case_when(
  method == 1 ~ 'method 1',
  method == 5 ~ 'method new'
))

ggplot(plot_data, aes(x =  as.character(class), y = lnl, color = as.character(method)))+
  geom_boxplot()+
  theme_bw()+
  labs(x = 'number of classes', y = 'log-likelihood', color = 'initialising method')+
  facet_wrap(~dataset,nrow = 2,scale = "free_y")

times <- plot_data %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(plot_data %>%
              distinct(rep, method, dataset),
            by = "rep") %>%
  select(rep, runtime, method, dataset)
temptime <- plot_data %>% filter(method == 'method 1') %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method, dataset) %>%
  mutate(method = 'method 1, c6 only')
times <- rbind(times, temptime)

ggplot(times, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)', x = 'initialising method', color = 'initialising method')+
  theme_bw()+
  facet_wrap(~dataset,nrow = 2,scale = "free_y")
