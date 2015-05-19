## load dplyr
require(dplyr)

## set working directory
working_dir <- "~/datacourse/GettingAndCleaning/Project/UCI HAR Dataset"
setwd(working_dir)

## check for files

for(filename in c("features_info.txt", "features.txt", "activity_labels.txt", "test", "train")) {
        if (!file.exists(filename)) {
                stop(paste("Incomplete or missing data in", working_dir))
        }
        
}

## load files

activities <- read.table("activity_labels.txt",stringsAsFactors = FALSE)
features <- read.table("features.txt", stringsAsFactors = FALSE)
test_subject <- read.table("test/subject_test.txt", stringsAsFactors = FALSE)
test_x <- read.table("test/X_test.txt", stringsAsFactors = FALSE)
test_y <- read.table("test/y_test.txt", stringsAsFactors = FALSE)
train_y <- read.table("train/y_train.txt", stringsAsFactors = FALSE)
train_x <- read.table("train/X_train.txt", stringsAsFactors = FALSE)
train_subject <- read.table("train/subject_train.txt", stringsAsFactors = FALSE)

## fix names
names(features)[2] <- "feature"
names(activities) <- c("activity_id","activity")
names(test_y) <- "activity_id"
names(train_y) <- "activity_id"
names(test_subject) <- "subject"
names(train_subject) <- "subject"

## apply feature names to the x data sets
names(test_x) <- features[,"feature"]
names(train_x) <- features[,"feature"]


## merge data sets

test_data <- bind_cols(test_subject, test_y, test_x)
train_data <- bind_cols(train_subject, train_y, train_x)
all_data <- rbind(test_data, train_data)

## pull out the means and stds

std_vec <- grep("*[Ss]td*", features$feature)
mean_vec <- grep("*[Mm]ean*", features$feature)
select_vec <- features[c(mean_vec, std_vec), 1]
select_vec <- select_vec <- c(1, 2, select_vec + 2) # make space for the first 2 cols
extracted_data <- all_data[, select_vec]

## add activity names

activity_data <- merge(x = extracted_data, y = activities, by = "activity_id", all.x=TRUE)

## pull redundant activity_id column

activity_data <- select(activity_data, -activity_id)

## clean up after yerself

rm(list = c("activities", "all_data", "extracted_data", "features", "test_data", 
            "test_subject", "test_x", "test_y", "train_data", "train_subject", "train_x", "train_y",
            "mean_vec", "select_vec", "std_vec", "working_dir", "filename"))

## generate tidy data set and save it

tidy_data <- activity_data %>% group_by(activity, subject) %>% summarise_each(funs(mean))

write.table(tidy_data, file = "tidy_data.txt", row.name = FALSE)

## if you want to get this file back, ensure you are in the correct working
## directory and call:
## tidy_read <- read.table(file = "tidy_data.txt", header = TRUE)
