# aula 1 - https://flowingdata.com/visualization-in-r/week-1/r-basics/

x <- 1 + 1
y <- 100
z <- x + y

first_part <- "hello"
second_part <- "world"

first_part + second_part #ERROR

paste(first_part, second_part)

typeof(first_part)   # "character"
typeof(z)            # "double"

# Logical
some_logical <- TRUE
another_logical <- FALSE

# Vector
some_vector <- c(1, 2, 3, 4, 5)

# Combine vectors
another_vector <- c(6, 7, 8, 9, 10)
combined_vector <- c(some_vector, another_vector)

# Vector has to be same data type
c("hello", 100)

# List
list("hello", 100)

# Data frame
first_column <- combined_vector
second_column <- c("h", "e", "l", "l", "o", "w", "o", "r", "l", "d")
some_df <- data.frame(first_column, second_column, stringsAsFactors=FALSE)

some_df

# Index on vector
combined_vector[1]   # One value

combined_vector[1:4]    # Multiple values, c(1, 2, 3, 4)
combined_vector[ c(5, 6) ] # Middle of the vector

some_df[,1]    # First column vector
some_df[1,]    # First row as list
some_df[1, 1]  # Value from first column and row

some_df[1:2,]  # First two rows

# Access by name
some_df$first_column
some_df$second_column
some_df$second_column[3:8]

# Subsetting on a condition
subset(some_df, first_column > 5)

subset(some_df, second_column == "w")

subset(some_df, second_column == "w" | first_column > 8)

table(first_column)

table(c(1,1,1,1,1,2,2,2,10))

plot(some_vector, another_vector)

head(some_df)

summary(some_df)

str(some_df)

dim(some_df)

length(some_df[,1])

install.packages("foreign")

library("foreign")

?summary

#aula 2 - https://flowingdata.com/visualization-in-r/week-1/make-some-charts/


  # 2.1 Started with Charts in R (https://flowingdata.com/2012/12/17/getting-started-with-charts-in-r/)
# Vector
c(1,2,3,4,5)
# Assign to variable
fakedata <- c(1,2,3,4,5)
# Access a value from vector
fakedata[1]

# Matrix, values converted to characters
morefake <- c("a", "a", "a", "a", "a")
cbind(fakedata, morefake)

fake.df <- data.frame(cbind(fakedata, morefake))
fake.df$fakedata <- as.numeric(fake.df$fakedata)
colnames(fake.df)


education <- read.csv("C:/Users/tvzgo/OneDrive/Área de Trabalho/programação/Aulas/MTI/flowing data/2009education.csv", encoding="UTF-8")
education[1,]       # First row
education[1:10,]    # First ten rows
education$state     # First columnn
education[,1]       # Also first column
education[1,1]      # First cell

# Sort least to greatest
high.order <- order(education$high)         
education.high <- education[high.order,]


  # 2.2 loop
x <- c(100, 100, 100, 100, 100)

for (i in 1:length(x)) {
  # Do something.
  cat(paste(as.character(x[i]), "\n", sep=""))
}


