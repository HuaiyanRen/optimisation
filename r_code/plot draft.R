
# c3 general

a <- c3t10r0 
a <- a %>% mutate(dataset = '10 taxa, 3k sites')
b <- c3t25r0 
b <- b %>% mutate(dataset = '25 taxa, 3k sites')
c <- c3t50r0 
c <- c %>% mutate(dataset = '50 taxa, 3k sites')
d <- c3t100r0 
d <- d %>% mutate(dataset = '100 taxa, 3k sites')

plot_data <- rbind(a,b,c,d)
plot_data$dataset <- factor(plot_data$dataset, levels = c('10 taxa, 3k sites', '25 taxa, 3k sites', 
                                                          '50 taxa, 3k sites', '100 taxa, 3k sites'))

linedata <- data.frame(dataset = c('10 taxa, 3k sites', '25 taxa, 3k sites', 
                                   '50 taxa, 3k sites', '100 taxa, 3k sites'), 
                       lnl = c(-16772.5656, -47700.5921, -93807.7146, -200683.6429))
linedata$dataset <- factor(linedata$dataset, levels = c('10 taxa, 3k sites', '25 taxa, 3k sites', 
                                                          '50 taxa, 3k sites', '100 taxa, 3k sites'))

ggplot(plot_data, aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y") 
  #geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)
#geom_text(x = '5', y = -184976, label = 'control group', color = 'darkblue', family = 'serif',data = subset(plot_data, dataset == '50 taxa, 6k sites'))

# c3 detail

ggplot(plot_data %>% filter(method > 0 & class > 1), aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y")+
  geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)


# c3 time

times <- plot_data %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(plot_data %>%
              distinct(rep, method, dataset),
            by = "rep") %>%
  select(rep, runtime, method, dataset)
temptime <- plot_data %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method, dataset) %>%
  mutate(method = case_when(
    method == 0 ~ "0,c3",
    method == 1 ~ "1,c3",
    method == 2 ~ "2,c3"
  ))
times <- rbind(times, temptime)

ggplot(times, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)', x = 'initialisation method', color = 'initialisation method')+
  theme_bw()+
  facet_wrap(~dataset,nrow = 2,scale = "free_y")



# c6 detail

a <- c6t10r0 
a <- a %>% mutate(dataset = '10 taxa, 6k sites')
b <- c6t25r0 
b <- b %>% mutate(dataset = '25 taxa, 6k sites')
c <- c6t50r0 
c <- c %>% mutate(dataset = '50 taxa, 6k sites')
d <- c6t100r0 
d <- d %>% mutate(dataset = '100 taxa, 6k sites')

plot_data <- rbind(a,b,c,d)
plot_data$dataset <- factor(plot_data$dataset, 
                            levels = c('10 taxa, 6k sites', '25 taxa, 6k sites', 
                                       '50 taxa, 6k sites', '100 taxa, 6k sites'))

linedata <- data.frame(dataset = c('50 taxa, 6k sites', '100 taxa, 6k sites', '50 taxa, 30k sites', '100 taxa, 30k sites'), 
                       lnl = c(-184975.6612, -395528.5682, -923519.2429, -1970620.4804))

ggplot(plot_data %>% filter(method > 0 & class > 4), aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y") 
#geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)
#geom_text(x = '5', y = -184976, label = 'control group', color = 'darkblue', family = 'serif',data = subset(plot_data, dataset == '50 taxa, 6k sites'))

# c6 time

times <- plot_data %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(plot_data %>%
              distinct(rep, method, dataset),
            by = "rep") %>%
  select(rep, runtime, method, dataset)
temptime <- plot_data %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method, dataset) %>%
  mutate(method = case_when(
    method == 0 ~ "0,c6",
    method == 1 ~ "1,c6",
    method == 2 ~ "2,c6"
  ))
times <- rbind(times, temptime)

ggplot(times, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)', x = 'initialisation method', color = 'initialisation method')+
  theme_bw()+
  facet_wrap(~dataset,nrow = 2,scale = "free_y")

### 5k data

# c3 detail

a <- c3t10r05k 
a <- a %>% mutate(dataset = '10 taxa, 15k sites')
b <- c3t25r05k 
b <- b %>% mutate(dataset = '25 taxa, 15k sites')
c <- c3t50r05k 
c <- c %>% mutate(dataset = '50 taxa, 15k sites')
d <- c3t100r05k 
d <- d %>% mutate(dataset = '100 taxa, 15k sites')

plot_data <- rbind(a,b,c,d)
plot_data$dataset <- factor(plot_data$dataset, 
                            levels = c('10 taxa, 15k sites', '25 taxa, 15k sites',
                                       '50 taxa, 15k sites', '100 taxa, 15k sites'))

linedata <- data.frame(dataset = c('50 taxa, 6k sites', '100 taxa, 6k sites', '50 taxa, 30k sites', '100 taxa, 30k sites'), 
                       lnl = c(-184975.6612, -395528.5682, -923519.2429, -1970620.4804))

ggplot(plot_data %>% filter(method > 0 & class > 1), aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y") 
#geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)
#geom_text(x = '5', y = -184976, label = 'control group', color = 'darkblue', family = 'serif',data = subset(plot_data, dataset == '50 taxa, 6k sites'))


# c3 time

times <- plot_data %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(plot_data %>%
              distinct(rep, method, dataset),
            by = "rep") %>%
  select(rep, runtime, method, dataset)
temptime <- plot_data %>% filter(method < 3) %>% filter(class == 3) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method, dataset) %>%
  mutate(method = case_when(
    method == 0 ~ "0,c3",
    method == 1 ~ "1,c3",
    method == 2 ~ "2,c3"
  ))
times <- rbind(times, temptime)

ggplot(times, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)', x = 'initialisation method', color = 'initialisation method')+
  theme_bw()+
  facet_wrap(~dataset,nrow = 2,scale = "free_y")


# c6 detail

a <- c6t10r05k 
a <- a %>% mutate(dataset = '10 taxa, 30k sites')
b <- c6t25r05k 
b <- b %>% mutate(dataset = '25 taxa, 30k sites')
c <- c6t50r05k 
c <- c %>% mutate(dataset = '50 taxa, 30k sites')
d <- c6t100r05k 
d <- d %>% mutate(dataset = '100 taxa, 30k sites')

plot_data <- rbind(a,b,c,d)
plot_data$dataset <- factor(plot_data$dataset, 
                            levels = c('10 taxa, 30k sites', '25 taxa, 30k sites',
                                       '50 taxa, 30k sites', '100 taxa, 30k sites'))

linedata <- data.frame(dataset = c('50 taxa, 6k sites', '100 taxa, 6k sites', '50 taxa, 30k sites', '100 taxa, 30k sites'), 
                       lnl = c(-184975.6612, -395528.5682, -923519.2429, -1970620.4804))

ggplot(plot_data %>% filter(method > 0 & class > 4), aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y") 
#geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)
#geom_text(x = '5', y = -184976, label = 'control group', color = 'darkblue', family = 'serif',data = subset(plot_data, dataset == '50 taxa, 6k sites'))



# c6 time

times <- plot_data %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(plot_data %>%
              distinct(rep, method, dataset),
            by = "rep") %>%
  select(rep, runtime, method, dataset)
temptime <- plot_data %>% filter(method < 3) %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method, dataset) %>%
  mutate(method = case_when(
    method == 0 ~ "0,c6",
    method == 1 ~ "1,c6",
    method == 2 ~ "2,c6"
  ))
times <- rbind(times, temptime)

ggplot(times, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)', x = 'initialisation method', color = 'initialisation method')+
  theme_bw()+
  facet_wrap(~dataset,nrow = 2,scale = "free_y")


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
  method == 1 ~ 'old method',
  method == 5 ~ 'new method'
))
plot_data$dataset <- factor(plot_data$dataset,levels = c('50 taxa, 6k sites', '100 taxa, 6k sites', '50 taxa, 30k sites', '100 taxa, 30k sites'))


linedata <- data.frame(dataset = c('50 taxa, 6k sites', '100 taxa, 6k sites', '50 taxa, 30k sites', '100 taxa, 30k sites'), 
                       lnl = c(-184975.6612, -395528.5682, -923519.2429, -1970620.4804))
linedata$dataset <- factor(linedata$dataset, levels = c('50 taxa, 6k sites', '100 taxa, 6k sites', '50 taxa, 30k sites', '100 taxa, 30k sites'))

ggplot(plot_data, aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y") +
  geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)
  #geom_text(x = '5', y = -184976, label = 'control group', color = 'darkblue', family = 'serif',data = subset(plot_data, dataset == '50 taxa, 6k sites'))

times <- plot_data %>%
  group_by(rep) %>%
  summarize(runtime = sum(time)) %>%
  left_join(plot_data %>%
              distinct(rep, method, dataset),
            by = "rep") %>%
  select(rep, runtime, method, dataset)
temptime <- plot_data %>% filter(method == 'old method') %>% filter(class == 6) %>%
  mutate(runtime = time) %>%
  select(rep, runtime, method, dataset) %>%
  mutate(method = 'old method, c6 only')
times <- rbind(times, temptime)

ggplot(times, aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)', x = 'initialisation method', color = 'initialisation method')+
  theme_bw()+
  facet_wrap(~dataset,nrow = 2,scale = "free_y")
