
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
  facet_wrap(~ dataset, nrow = 4, scale = "free_y")+
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

linedata <- data.frame(dataset = c('10 taxa, 6k sites', '25 taxa, 6k sites', 
                                   '50 taxa, 6k sites', '100 taxa, 6k sites'), 
                       lnl = c(-33559.4087, -94754.1193, -184975.6612, -395528.5682),
                       bic = c(67466.79799,190117.2046,370995.2642,792971.0296))
linedata$dataset <- factor(linedata$dataset, 
                            levels = c('10 taxa, 6k sites', '25 taxa, 6k sites', 
                                       '50 taxa, 6k sites', '100 taxa, 6k sites'))

ggplot(plot_data %>% filter(method > 0 & class > 3), aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y")+ 
  geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)

ggplot(plot_data %>% filter(method > 0 & class > 4), aes(x = as.character(class), y = bic)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'BIC', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y")+ 
  geom_hline(data = linedata, aes(yintercept = bic), color = "darkblue", linetype = "dashed", size = 0.75)


lrt_results <- b %>%
  group_by(rep) %>%
  summarize(lrt_detail = paste(lrt, collapse = "_"))

table(lrt_results)

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

ggplot(times %>% filter(method != 0 & method != '0,c6'), aes(x = as.character(method), y = runtime, color = method))+
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

linedata <- data.frame(dataset = c('10 taxa, 15k sites', '25 taxa, 15k sites',
                                   '50 taxa, 15k sites', '100 taxa, 15k sites'), 
                       lnl = c(-83242.9907, -238152.0907, -465310.2191, -998319.9531))
linedata$dataset <- factor(linedata$dataset, 
                            levels = c('10 taxa, 15k sites', '25 taxa, 15k sites',
                                       '50 taxa, 15k sites', '100 taxa, 15k sites'))

ggplot(plot_data %>% filter(method > 0 & class > 1), aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y")+
  geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)
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

ggplot(times , aes(x = as.character(method), y = runtime, color = method))+
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

linedata <- data.frame(dataset = c('10 taxa, 30k sites', '25 taxa, 30k sites',
                                   '50 taxa, 30k sites', '100 taxa, 30k sites'), 
                       lnl = c(-168965.4571, -475802.7081, -923519.2429, -1970620.4804))
linedata$dataset <- factor(linedata$dataset, 
                            levels = c('10 taxa, 30k sites', '25 taxa, 30k sites',
                                       '50 taxa, 30k sites', '100 taxa, 30k sites'))

ggplot(plot_data %>% filter(method > 0 & class > 4), aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y")+
  geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)

ggplot(plot_data %>% filter(method > 0 & class > 4), aes(x = as.character(class), y = bic)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'BIC', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y")

ggplot(plot_data %>% filter(method > 0 & class > 4) %>% filter(dataset == '100 taxa, 30k sites'), aes(x = as.character(class), y = bic)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw()+
  ylim(3943000,3945000) +
  labs(x = 'Number of Classes', y = 'BIC', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 2, scale = "free_y")

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

ggplot(times %>% filter(method != 0 & method != '0,c6'), aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)', x = 'initialisation method', color = 'initialisation method')+
  theme_bw()+
  facet_wrap(~dataset,nrow = 2,scale = "free_y")

### reps

# c6 detail
# r1
c6t25r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t25r1/sum_result.csv", show_col_types = FALSE)
c6t50r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t50r1/sum_result.csv", show_col_types = FALSE)
c6t100r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t100r1/sum_result.csv", show_col_types = FALSE)

# r2
c6t25r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t25r2/sum_result.csv", show_col_types = FALSE)
c6t50r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t50r2/sum_result.csv", show_col_types = FALSE)
c6t100r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t100r2/sum_result.csv", show_col_types = FALSE)



b <- c6t25r2 
b <- b %>% mutate(dataset = '25 taxa, 6k sites')
c <- c6t50r2 
c <- c %>% mutate(dataset = '50 taxa, 6k sites')
d <- c6t100r2 
d <- d %>% mutate(dataset = '100 taxa, 6k sites')

plot_data <- rbind(b,c,d)
plot_data$dataset <- factor(plot_data$dataset, 
                            levels = c('25 taxa, 6k sites', 
                                       '50 taxa, 6k sites', '100 taxa, 6k sites'))

linedata <- data.frame(dataset = levels(plot_data$dataset), 
                       lnl = (plot_data %>% filter(method == 6))$lnl)
linedata$dataset <- factor(linedata$dataset,levels = levels(plot_data$dataset))

ggplot(plot_data %>% filter(method > 0 & method < 6 & class > 3), aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 1, scale = "free_y")+ 
  geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)

ggplot(plot_data %>% filter(method > 0 & method < 6 & class > 3), aes(x = as.character(class), y = bic)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'BIC', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 1, scale = "free_y")

lrt_results <- d %>%
  group_by(rep) %>%
  summarize(lrt_detail = paste(lrt, collapse = "_"))

table(lrt_results)

# r1 5k
c6t25r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t25r15k/sum_result.csv", show_col_types = FALSE)
c6t50r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t50r15k/sum_result.csv", show_col_types = FALSE)
c6t100r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t100r15k/sum_result.csv", show_col_types = FALSE)

# r2 5k
c6t25r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t25r25k/sum_result.csv", show_col_types = FALSE)
c6t50r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t50r25k/sum_result.csv", show_col_types = FALSE)
c6t100r2 <- read_csv("C:/Users/u7151703/Desktop/research/optimisation/data/f81_qmix/c6t100r25k/sum_result.csv", show_col_types = FALSE)

b <- c6t25r2 
b <- b %>% mutate(dataset = '25 taxa, 30k sites')
c <- c6t50r2 
c <- c %>% mutate(dataset = '50 taxa, 30k sites')
d <- c6t100r2 
d <- d %>% mutate(dataset = '100 taxa, 30k sites')

plot_data <- rbind(b,c,d)
plot_data$dataset <- factor(plot_data$dataset, 
                            levels = c('25 taxa, 30k sites', 
                                       '50 taxa, 30k sites', '100 taxa, 30k sites'))

linedata <- data.frame(dataset = levels(plot_data$dataset), 
                       lnl = (plot_data %>% filter(method == 6))$lnl,
                       bic = (plot_data %>% filter(method == 6))$bic)
linedata$dataset <- factor(linedata$dataset,levels = levels(plot_data$dataset))

ggplot(plot_data %>% filter(method > 0 & method < 6 & class > 3), aes(x = as.character(class), y = lnl)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'Log-likelihood', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 1, scale = "free_y")+ 
  geom_hline(data = linedata, aes(yintercept = lnl), color = "darkblue", linetype = "dashed", size = 0.75)

ggplot(plot_data %>% filter(method > 0 & method < 6 & class > 3), aes(x = as.character(class), y = bic)) +
  geom_boxplot(aes(color = as.character(method))) +
  theme_bw() +
  labs(x = 'Number of Classes', y = 'BIC', color = 'Initialisation Method') +
  facet_wrap(~ dataset, nrow = 1, scale = "free_y")

ggplot(plot_data %>% filter(method > 0 & method < 6 & class > 3) %>% filter(dataset == '100 taxa, 30k sites'), aes(x = as.character(class), y = bic)) +
  geom_boxplot(aes(color = as.character(method))) +
  ylim(3563500,3564000)+
  theme_bw() +
  labs(x = 'Number of Classes', y = 'BIC', color = 'Initialisation Method') 

lrt_results <- c %>%
  group_by(rep) %>%
  summarize(lrt_detail = paste(lrt, collapse = "_"))

table(lrt_results)

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
    method == 1 ~ "1,c6",
    method == 2 ~ "2,c6"
  ))
times <- rbind(times, temptime)

ggplot(times %>% filter(method > 0 & method < 6), aes(x = as.character(method), y = runtime, color = method))+
  geom_boxplot()+
  scale_y_log10()+
  labs(y = 'runtime(s)', x = 'initialisation method', color = 'initialisation method')+
  theme_bw()+
  facet_wrap(~dataset,nrow = 1,scale = "free_y")



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
