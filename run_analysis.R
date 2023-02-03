#read in data

var_names <- read.table("features.txt", header = F, sep = "")
vars <- var_names$V2

x_train <- read.table("X_train.txt", header = F, sep = "")
names(x_train) <- vars

x_test <- read.table("X_test.txt", header = F, sep = "")
names(x_test) <- vars

y_train <- read.table ("y_train.txt", header = F, sep = "")
y_train <- rename(y_train, activity = V1)

y_test <- read.table("y_test.txt", header = F, sep = "")
y_test <- rename(y_test, activity = V1)

id_train <- read.table("subject_train.txt", header = F, sep = "")
id_train <- rename(id_train, ID = V1)
unique(id_train$ID)

id_test <- read.table("subject_test.txt", header = F, sep = "")
id_test <- rename(id_test, ID = V1)
unique(id_test$ID)

#bind test and training data frames

train <- cbind(id_train, y_train, x_train)
test <- cbind(id_test, y_test, x_test)

#create new df selecting variables from test and train containing "mean" or "std"

train_mean_sd <- train %>% 
  select(matches("mean|std|^ID|^activity"))

test_mean_sd <- test %>%
  select(matches("mean|std|^ID|^activity"))

#Look-up vector for indexing

activities <- c("walking", "walking_upstairs", "walking_downstairs", "sitting", 
                "standing", "lying")

#use vector to rename activities

train_mean_sd$activity.names <- activities[train_mean_sd$activity]

test_mean_sd$activity.names <- activities[test_mean_sd$activity]

#rename variables to only contain letters, numbers or points (remove -, (), _)

colnames(train_mean_sd) <- gsub("-", ".", colnames(train_mean_sd))
colnames(train_mean_sd) <- gsub("[()]", "", colnames(train_mean_sd))
colnames(train_mean_sd) <- gsub(",", ".", colnames(train_mean_sd))

colnames(test_mean_sd) <- gsub("-", ".", colnames(test_mean_sd))
colnames(test_mean_sd) <- gsub("[()]", "", colnames(test_mean_sd))
colnames(test_mean_sd) <- gsub(",", ".", colnames(test_mean_sd))

names(train_mean_sd)

#create new data frame showing the mean of each variable grouped by ID and activity

tidy_train_mean_sd <- train_mean_sd %>%
  group_by(activity.names, ID) %>%
  summarise_all(mean)

tidy_test_mean_sd <- test_mean_sd %>%
  group_by(activity.names, ID) %>%
  summarise_all(mean)

