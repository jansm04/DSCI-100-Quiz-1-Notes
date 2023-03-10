library(tidyverse)

library(readxl)
getwd()

# ==========================
# CHAPTER 2: READING IN DATA
# ==========================





# Absolute vs Relative Paths:

# Absolute:
#  - where file is with respect to computer's organization system
# Ex:
avocado <- read_csv("/Users/jansmailbegovic/Playground/R/data/avocado_prices.csv")
avocado

# Relative:
#  - where file is with respect to current file
# Ex:
avocado2 <- read_csv("data/avocado_prices.csv")
avocado2






# Libraries:
#  - library(tidyverse) gives us access to 'readr' package
#         - read_csv
#         - read_tsv
#         - read_csv2
#         - read_delim
#  - library(readxl) gives us access to 'readxl' package
#         - read_excel






# Types of Read Functions:
# read_csv - delim = ',' (comma separated files)
# read_tsv - delim = "\t" (tab separated files)         NOTE: can be located in a .csv file
# read_csv2 - delim = ";" (semicolon separated files)   NOTE: can be located in a .csv file
# read_delim - various formats
# read_excel - .xlsx files








# Reading an Excel File:

library(readxl)
url <- "https://s3.amazonaws.com/happiness-report/2018/WHR2018Chapter2OnlineData.xls"

download.file(url, destfile = "data/WHR2018Chapter2OnlineData.xls")
# download.file(url, destfile = <relative path>)

happy_df <- read_excel("data/WHR2018Chapter2OnlineData.xls", sheet = 3)
# number specifies which sheet to read, if there are multiple
happy_df









# Managing .csv Files:

# Ex 1: no columns
# avocado <- read_csv("data/avocado_prices.csv", col_names = FALSE)
# avocado

# Ex 2: need to skip rows
# avocado <- read_csv("data/avocado_prices.csv", skip = 3)
# avocado

# Ex 3: both scenarios combined
# avocado <- read_csv("data/avocado_prices.csv", skip = 2, col_names = FALSE)
# avocado






# Changing Column Names:

# Ex 1:
colnames(happy_df) <- make.names(colnames(happy_df))
happy_df
# removes spaces in column names and replaces them with '.'

# Ex 2:
colnames(happy_df) <- c("country", "changes_in_happiness_scores", "whisker_high", "whisker_low")
happy_df








# Databases:

# Process:
#  - connect to db using dbConnect function from DBI package
# Ex:
library(RSQLite)
library(DBI)
conn_lang_data <- dbConnect(RSQLite::SQLite(), "data/can_lang.db")

#  - to reference a table from the database, we need to use the tbl() function from the dbplyr package
# Ex:
library(dbplyr)
lang_db <- tbl(conn_lang_data, "lang")

#  - with dbplyr package, we can use functions such as filter(), or select()
#  - however, here lang_db is NOT an actual data frame - it is actually a REFERENCE

#  - in order to store lang_db as a data frame, we need to use the collect() function
# Ex:
aboriginal_lang_data <- collect(lang_db)
aboriginal_lang_data

# We can also use PostgreSQL database, as such:
library(RPostgres)
conn_mov_data <- dbConnect(RPostgres::Postgres(), dbname = "can_mov_db",
                           host = "fakeserver.stat.ubc.ca", port = 5432,
                           user = "user0001", password = "abc123")
#  - uses a client-server db engine
#  - designed to be used and accessed on a network


# Benefits of Data Bases:
#  - allow us to store large amounts of data
#  - very secure
#  - multiple users can access data at the same time without any issues






# Writing Data:
#  - saving a data frame as a .csv file

# Ex:
avocado2 <- select(avocado, -extra_l_hass_volume)
write_csv(avocado2, "data/avocado-without-extra-v.csv")
# or maybe...
write_tsv(avocado2, "data/avocado-without-extra-v.csv")
# or...
write_delim(avocado2, "data/avocado-without-extra-v.csv", delim = ",")




