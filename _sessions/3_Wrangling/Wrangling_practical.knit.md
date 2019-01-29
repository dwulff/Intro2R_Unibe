---
title: "Wrangling"
author: "Introduction to Data Science with R<br/>
  <a href='https://therbootcamp.github.io'>
    Bern R Bootcamp
  </a> 
  <br>
  <a href='https://dwulff.github.io/Intro2R_Unibe/'>
    <i class='fas fa-clock' style='font-size:.9em;'></i>
  </a>&#8239; 
  <a href='https://therbootcamp.github.io'>
    <i class='fas fa-home' style='font-size:.9em;' ></i>
  </a>&#8239;
  <a href='mailto:therbootcamp@gmail.com'>
    <i class='fas fa-envelope' style='font-size: .9em;'></i>
  </a>&#8239;
  <a href='https://www.linkedin.com/company/basel-r-bootcamp/'>
    <i class='fab fa-linkedin' style='font-size: .9em;'></i>
  </a>"
output:
  html_document:
    css: practical.css
---



<img src="https://raw.githubusercontent.com/therbootcamp/therbootcamp.github.io/master/_sessions/_image/dplyr_functions.png" width="70%" style="display: block; margin: auto;" />

## {.tabset}

### Overview

In this practical you'll practice "data wrangling" with the `dplyr` and `tidyr` packages (part of the `tidyverse collection of packages).

By the end of this practical you will know how to:

1. Change column names, select specific columns
2. Create new columns
3. Filter rows of data based on multiple criteria
4. Combine (aka, 'join') multiple data sets through key columns
5. Convert data between wide and long formats

### Datasets



|File | Rows | Columns |
|:----|:-----|:------|
|[trial_act.csv](https://raw.githubusercontent.com/therbootcamp/BaselRBootcamp_2018July/master/_sessions/_data/baselrbootcamp_data/trial_act.csv) | 2139 | 27 |
|[trial_act_demo_fake.csv](https://raw.githubusercontent.com/therbootcamp/BaselRBootcamp_2018July/master/_sessions/_data/baselrbootcamp_data/trial_act_demo_fake.csv)| 2139 | 3|

### Packages

|Package| Installation|
|:------|:------|
|`tidyverse`|`install.packages("tidyverse")`|

### Glossary

| Function| Package | Description |
|:---|:------|:---------------------------------------------|
|     `rename()`|`dplyr`|    Rename columns| 
|     `select()`|`dplyr`|    Select columns based on name or index| 
|     `filter()`|`dplyr`|    Select rows based on some logical criteria| 
|     `arrange()`|`dplyr`|    Sort rows| 
|     `mutate()`|`dplyr`|    Add new columns|
|     `case_when()`|`dplyr`|    Recode values of a column| 
|     `group_by(), summarise()`|`dplyr`|   Group data and then calculate summary statistics|
|     `left_join()`|`dplyr`|   Combine multiple data sets using a key column|
|     `spread()`|`tidyr`|    Convert long data to wide format - from rows to columns| 
|     `gather()`|`tidyr`|    Convert wide data to long format - from columns to rows|

### Cheatsheet

<figure>
<center>
<a href="https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf">
  <img src="https://image.slidesharecdn.com/data-wrangling-cheatsheet-160705210122/95/data-wrangling-with-dplyr-and-tidyr-cheat-sheet-1-638.jpg?cb=1467752577" alt="Trulli" style="width:70%">
  <figcaption>https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf</figcaption></a>
</figure>

### Examples


```r
# Wrangling with dplyr and tidyr ---------------------------

library(tidyverse)    # Load tidyverse for dplyr and tidyr

# Load baselers data
baselers <- read_csv("https://raw.githubusercontent.com/therbootcamp/baselers/master/inst/extdata/baselers.txt")

# Perform many dplyr operations in a row

baselers %>%
  
  # Change some names
  rename(age_y = age,
         swimming = rhine) %>%
  
  # Only include people over 30
  filter(age_y > 30) %>%
  
  # Calculate some new columns
  mutate(weight_lbs = weight * 2.22,
         height_m = height / 100,
         BMI = weight / height_m ^ 2,
         
         # Make binary version of sex
         sex_bin = case_when(
                      sex == "male" ~ 0,
                      sex == "female" ~ 1),

        # Show when height is greater than 150
        height_lt_150 = case_when(
                                height < 150 ~ 1,
                                height >= 150 ~ 0)) %>%
  
  # Sort in ascending order of sex, then
  #  descending order of age
  arrange(sex, desc(age_y)))
```

# Tasks

## A - Setup

1. Open your `baselrbootcamp` R project. It should already have the folders `1_Data` and `2_Code`. Make sure that the data files listed in the `Datasets` section above are in your `1_Data` folder


```r
# Done!
```

2. Open a new R script. At the top of the script, using comments, write your name and the date. Save it as a new file called `wrangling_practical.R` in the `2_Code` folder.  


```r
# Done!
```

3. Using `library()` load the set of packages for this practical listed in the packages section above.



4. For this practical, we'll use the `trial_act` data, this is the result of a randomized clinical trial comparing the effects of different medications on adults infected with the human immunodeficiency virus (You can learn more about the trial [here](https://www.nejm.org/doi/full/10.1056/NEJM199610103351501)). Using the following template, load the data into R and store it as a new object called `trial_act`.


```r
# Load trial_act.csv from the data folder in your working directory

trial_act <- read_csv(file = "XX")
```


```r
trial_act <- read_csv(file = "1_Data/trial_act.csv")
```

5. Using the same code structure, load the `trial_act_demo_fake.csv` data as a new dataframe called `trial_act_demo`




```r
trial_act_demo <- read_csv(file = "1_Data/trial_act_demo_fake.csv")
```



6. Take a look at the first few rows of the datasets by printing them to the console.


```r
# Print trial_act object
trial_act
```

```
# A tibble: 2,139 x 27
   pidnum   age  wtkg  hemo  homo drugs karnof oprior   z30 zprior preanti
    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>   <dbl>
 1  10056    48  89.8     0     0     0    100      0     0      1       0
 2  10059    61  49.4     0     0     0     90      0     1      1     895
 3  10089    45  88.5     0     1     1     90      0     1      1     707
 4  10093    47  85.3     0     1     0    100      0     1      1    1399
 5  10124    43  66.7     0     1     0    100      0     1      1    1352
 6  10140    46  88.9     0     1     1    100      0     1      1    1181
 7  10165    31  73.0     0     1     0    100      0     1      1     930
 8  10190    41  66.2     0     1     1    100      0     1      1    1329
 9  10198    40  82.6     0     1     0     90      0     1      1    1074
10  10229    35  78.0     0     1     0    100      0     1      1     964
# … with 2,129 more rows, and 16 more variables: race <dbl>, gender <dbl>,
#   str2 <dbl>, strat <dbl>, symptom <dbl>, treat <dbl>, offtrt <dbl>,
#   cd40 <dbl>, cd420 <dbl>, cd496 <dbl>, r <dbl>, cd80 <dbl>,
#   cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>
```

7. Use the the `summary()` function to print more details on the columns of the datasets.


```r
summary(trial_act)
```

```
     pidnum            age            wtkg            hemo      
 Min.   : 10056   Min.   :12.0   Min.   : 31.0   Min.   :0.000  
 1st Qu.: 81446   1st Qu.:29.0   1st Qu.: 66.7   1st Qu.:0.000  
 Median :190566   Median :34.0   Median : 74.4   Median :0.000  
 Mean   :248778   Mean   :35.2   Mean   : 75.1   Mean   :0.084  
 3rd Qu.:280277   3rd Qu.:40.0   3rd Qu.: 82.6   3rd Qu.:0.000  
 Max.   :990077   Max.   :70.0   Max.   :159.9   Max.   :1.000  
                                                                
      homo           drugs           karnof          oprior     
 Min.   :0.000   Min.   :0.000   Min.   : 70.0   Min.   :0.000  
 1st Qu.:0.000   1st Qu.:0.000   1st Qu.: 90.0   1st Qu.:0.000  
 Median :1.000   Median :0.000   Median :100.0   Median :0.000  
 Mean   :0.661   Mean   :0.131   Mean   : 95.4   Mean   :0.022  
 3rd Qu.:1.000   3rd Qu.:0.000   3rd Qu.:100.0   3rd Qu.:0.000  
 Max.   :1.000   Max.   :1.000   Max.   :100.0   Max.   :1.000  
                                                                
      z30           zprior     preanti          race           gender     
 Min.   :0.00   Min.   :1   Min.   :   0   Min.   :0.000   Min.   :0.000  
 1st Qu.:0.00   1st Qu.:1   1st Qu.:   0   1st Qu.:0.000   1st Qu.:1.000  
 Median :1.00   Median :1   Median : 142   Median :0.000   Median :1.000  
 Mean   :0.55   Mean   :1   Mean   : 379   Mean   :0.288   Mean   :0.828  
 3rd Qu.:1.00   3rd Qu.:1   3rd Qu.: 740   3rd Qu.:1.000   3rd Qu.:1.000  
 Max.   :1.00   Max.   :1   Max.   :2851   Max.   :1.000   Max.   :1.000  
                                                                          
      str2           strat         symptom          treat      
 Min.   :0.000   Min.   :1.00   Min.   :0.000   Min.   :0.000  
 1st Qu.:0.000   1st Qu.:1.00   1st Qu.:0.000   1st Qu.:1.000  
 Median :1.000   Median :2.00   Median :0.000   Median :1.000  
 Mean   :0.586   Mean   :1.98   Mean   :0.173   Mean   :0.751  
 3rd Qu.:1.000   3rd Qu.:3.00   3rd Qu.:0.000   3rd Qu.:1.000  
 Max.   :1.000   Max.   :3.00   Max.   :1.000   Max.   :1.000  
                                                               
     offtrt           cd40          cd420          cd496     
 Min.   :0.000   Min.   :   0   Min.   :  49   Min.   :   0  
 1st Qu.:0.000   1st Qu.: 264   1st Qu.: 269   1st Qu.: 209  
 Median :0.000   Median : 340   Median : 353   Median : 321  
 Mean   :0.363   Mean   : 351   Mean   : 371   Mean   : 329  
 3rd Qu.:1.000   3rd Qu.: 423   3rd Qu.: 460   3rd Qu.: 440  
 Max.   :1.000   Max.   :1199   Max.   :1119   Max.   :1190  
                                               NA's   :797   
       r              cd80          cd820           cens      
 Min.   :0.000   Min.   :  40   Min.   : 124   Min.   :0.000  
 1st Qu.:0.000   1st Qu.: 654   1st Qu.: 632   1st Qu.:0.000  
 Median :1.000   Median : 893   Median : 865   Median :0.000  
 Mean   :0.627   Mean   : 987   Mean   : 935   Mean   :0.244  
 3rd Qu.:1.000   3rd Qu.:1207   3rd Qu.:1146   3rd Qu.:0.000  
 Max.   :1.000   Max.   :5011   Max.   :6035   Max.   :1.000  
                                                              
      days           arms     
 Min.   :  14   Min.   :0.00  
 1st Qu.: 727   1st Qu.:1.00  
 Median : 997   Median :2.00  
 Mean   : 879   Mean   :1.52  
 3rd Qu.:1091   3rd Qu.:3.00  
 Max.   :1231   Max.   :3.00  
                              
```

```r
summary(trial_act_demo)
```

```
     pidnum          exercise    education        
 Min.   : 10056   Min.   :0.0   Length:2139       
 1st Qu.: 81446   1st Qu.:1.0   Class :character  
 Median :190566   Median :1.0   Mode  :character  
 Mean   :248778   Mean   :2.2                     
 3rd Qu.:280277   3rd Qu.:3.0                     
 Max.   :990077   Max.   :7.0                     
```

### Tips

In this practical you will do many operations on dataframes. Remember: when using `dplyr`, you can chain multiple functions together with the pipe `%>%`. When giving your answers to the questions in this practical, see how many operations you can chain with the pipe!


```r
baselers <- read_csv("1_Data/baselers.csv")

# Method 1: Separate operations

baselers <- baselers %>%
              rename(Age_y = age)   # Change age to Age__y

baselers <- baselers %>%
              mutate(food_p = food / income)  # calculate food_p

baselers <- baselers %>%
              filter(sex == "m")    # Only include males

# Method 2: Chain with the pipe!

baselers <- read_csv("1_Data/baselers.csv")

baselers <- baselers %>%
              rename(Age_y = age) %>%             # Change age to Age__y
              mutate(food_p = food / income) %>%  # calculate food_p
              filter(sex == "m")                  # Only include males
```

### B - Change column names with rename()

1. Print the names of the `trial_act` data with `names(XXX)`


```r
names(XXX)
```


```r
names(trial_act)
```

```
 [1] "pidnum"  "age"     "wtkg"    "hemo"    "homo"    "drugs"   "karnof" 
 [8] "oprior"  "z30"     "zprior"  "preanti" "race"    "gender"  "str2"   
[15] "strat"   "symptom" "treat"   "offtrt"  "cd40"    "cd420"   "cd496"  
[22] "r"       "cd80"    "cd820"   "cens"    "days"    "arms"   
```

2. Using `rename()`, change the column name `wtkg` in the `trial_act` dataframe to `weight_kg`. Be sure to assign the result back to `trial_act` to change it!


```r
# Change the name to weight_kg from wtkg

trial_act <- trial_act %>%
  rename(XX = XX)
```


```r
trial_act <- trial_act %>%
  rename(weight_kg = wtkg)
```

3. Look at the names of your `trial_act` dataframe again, do you now see the column `weight_kg`?


```r
names(trial_act)
```

```
 [1] "pidnum"    "age"       "weight_kg" "hemo"      "homo"     
 [6] "drugs"     "karnof"    "oprior"    "z30"       "zprior"   
[11] "preanti"   "race"      "gender"    "str2"      "strat"    
[16] "symptom"   "treat"     "offtrt"    "cd40"      "cd420"    
[21] "cd496"     "r"         "cd80"      "cd820"     "cens"     
[26] "days"      "arms"     
```

4. Change the column name `age` to `age_y` (to specify that age is in years).


```r
trial_act <- trial_act %>%
  rename(age_y = age)
```

### C - Select columns with select()

1. Using the `select()` function, select only the column `age_y` and print the result (but don't assign it to anything). Do you see only the `age_y` column now?


```r
XXX %>%
  select(XXX)
```


```r
trial_act %>% 
  select(age_y)
```

```
# A tibble: 2,139 x 1
   age_y
   <dbl>
 1    48
 2    61
 3    45
 4    47
 5    43
 6    46
 7    31
 8    41
 9    40
10    35
# … with 2,129 more rows
```

2. Using `select()` select the columns `pidnum`, `age_y`, `gender`, and `weight_kg` (but don't assign the result to anything)

3. Now it's time to create a new dataframe! Select the columns `pidnum`, `arms`, `cd40`, `cd420`, and `cd496` *and* assign the result to a new object called `CD4_wide`. The `cd40`, `cd420`, and `cd496` columns show patient's CD4 T cell counts at baseline, 20 weeks, and 96 weeks. After you create `CD4_wide`, print it to make sure it worked!


```r
XX <- trial_act %>% 
  select(XX, XX, XX, XX, ...)
```


```r
CD4_wide <- trial_act %>%
  select(`pidnum`, `arms`, `cd40`, `cd420`, `cd496`)
```

4. Did you know you can easily select all columns that start with specific characters using `starts_with()`? Try adapting the following code to get the same result you got before.


```r
CD4_wide <- trial_act %>% 
  select(pidnum, arms, starts_with("XXX"))
```


```r
CD4_wide <- trial_act %>% 
  select(pidnum, arms, starts_with("cd"))
```

5. A colleague wants an anonymised dataframe that does *not* contain the columns `pidnum` and `age`. Create this dataframe by selecting all columns *except* `pidnum` and `age` (hint: use the notation `select(-XXX, -XXX))` to select everything *except* specified columns



### D - Add new columns with mutate()

1. Using the `mutate()` function, add the column `age_m` which shows each patient's age in months instead of years (Hint: Just multiply `age_y` by 12!)


```r
trial_act <- trial_act %>%
  mutate(XX = XX * 12)
```


```r
trial_act <- trial_act %>%
  mutate(age_m = age_y * 12)
```

2. Using `mutate`, add the following new columns to `trial_act`. (Try combining these into *one* call to the `mutate()` function!)

- `weight_lb`: Weight in lbs instead of kilograms. You can do this by multiplying `weight_kg` by 2.2.
- `cd_change_20`: Change in CD4 T cell count from baseline to 20 weeks. You can do this by taking `cd420 - cd40`
- `cd_change_960`: Change in CD4 T cell count from baseline to 96 weeks. You can do this by taking `cd496 - cd40`


```r
XXX <- XXX %>% 
  mutate(weight_lb = XXX,
         cd_change_20 = XXX,
         XXX = XXX)
```


```r
trial_act <- trial_act %>% 
  mutate(weight_lb = weight_kg * 2.2,
         cd_change_20 = cd420 - cd40,
         cd_change_960 = cd496 - cd40)
```

3. If you look at the `gender` column, you will see that it is numeric (0s and 1s). Using the `mutate()` and `case_when()` functions, create a new column called `gender_char` which shows the gender as a string, where 0 = "female" and 1 = "male":
    

```r
# Create gender_char which shows gender as a stringh
trial_act <- trial_act %>%
  mutate(
  gender_char = case_when(
    gender == XX ~ "XX",
    gender == XX ~ "XX"))
```


```r
trial_act <- trial_act %>%
  mutate(
  gender_char = case_when(
    gender == 0 ~ "female",
    gender == 1 ~ "male"))
```

4. The column `arms` is also numeric and not very meaningful. Create a new column `arms_char` contains the names of the arms. Here is a table of the mapping

|arms|arms_char|
|:---|:-----|
|0|zidovudine|
|1|zidovudine and didanosine|
|2|zidovudine and zalcitabine|
|3|didanosine|


```r
trial_act <- trial_act %>%
  mutate(
  arms_char = case_when(
    arms == 0 ~ "zidovudine",
    arms == 1 ~ "zidovudine and didanosine",
    arms == 2 ~ "zidovudine and zalcitabine",
    arms == 3 ~ "didanosine"))
```

5. If you haven't already, try putting all the code for your previous questions in one call to `mutate()`. That is, in one block of code, create `age_m`, `weight_lb`, `cd_change_20`, `cd_change_960`, `gender_char` and `over50` using the `mutate()` function only once. Here's how your code should look:


```r
trial_act <- trial_act %>%
  mutate(
    age_m = XXX,
    weight_lb = XXX,
    cd_change_20 = XXX,
    XXX = XXX,
    XXX = case_when(XXX),
    XXX = case_when(XXX)
  )
```


```r
trial_act <- trial_act %>%
  mutate(
    agem = age_y * 12,
    weight_lb = weight_kg * 2.2,
    cd_change_20 = cd420 - cd40,
    cd_change_960 = cd496 - cd40,
    gender_char = case_when(
                      gender == 0 ~ "female",
                      gender == 1 ~ "male"),
   arms_char = case_when(
    arms == 0 ~ "zidovudine",
    arms == 1 ~ "zidovudine and didanosine",
    arms == 2 ~ "zidovudine and zalcitabine",
    arms == 3 ~ "didanosine")
  )
```

### E - Arrange rows with arrange()

1. Using the `arrange()` function, arrange the `trial_act` data in ascending order of `age_y` (from lowest to highest). After you do, print the data to make sure it worked!


```r
trial_act <- trial_act %>% 
 arrange(XXX)
```



```r
trial_act <- trial_act %>% 
 arrange(age_y)

trial_act
```

```
# A tibble: 2,139 x 34
   pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
 1 940533    12      41.4     1     0     0    100      0     0      1
 2 950037    12      53.1     1     0     0    100      0     1      1
 3 950056    12      31       1     0     0    100      0     1      1
 4 910034    13      32.7     1     0     0    100      0     1      1
 5 940534    13      62.9     1     0     0    100      0     0      1
 6 960014    13      48.5     1     0     0    100      0     0      1
 7 310767    14      65       1     0     0    100      0     1      1
 8 920050    14      54.2     1     0     0    100      0     1      1
 9 940544    14      41.1     1     0     0    100      0     0      1
10 950061    14      64.3     1     0     0    100      0     1      1
# … with 2,129 more rows, and 24 more variables: preanti <dbl>,
#   race <dbl>, gender <dbl>, str2 <dbl>, strat <dbl>, symptom <dbl>,
#   treat <dbl>, offtrt <dbl>, cd40 <dbl>, cd420 <dbl>, cd496 <dbl>,
#   r <dbl>, cd80 <dbl>, cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>,
#   age_m <dbl>, weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>
```

2. Now arrange the data in *descending* order of `age_y` (from highest to lowest). After, look the data to make sure it worked. To arrange data in descending order, just include `desc()` around the variable. E.g.; `data %>% arrrange(desc(height))`


```r
trial_act <- trial_act %>% 
 arrange(desc(age_y))

trial_act
```

```
# A tibble: 2,139 x 34
   pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
 1  11438    70      73.9     0     1     0    100      0     1      1
 2 211360    70      63.1     0     1     0     90      0     0      1
 3 211284    69      81.6     0     1     0    100      0     0      1
 4  50580    68      90.5     0     1     1    100      0     1      1
 5  81127    68      70.8     0     1     0     90      0     1      1
 6  10924    67      71       0     1     0    100      0     0      1
 7 241150    67      82.1     0     1     0     90      0     0      1
 8  50662    66      84.4     0     1     0    100      0     0      1
 9  11987    65      77.2     0     1     0     90      0     0      1
10 140797    65      60.5     0     1     0     90      0     0      1
# … with 2,129 more rows, and 24 more variables: preanti <dbl>,
#   race <dbl>, gender <dbl>, str2 <dbl>, strat <dbl>, symptom <dbl>,
#   treat <dbl>, offtrt <dbl>, cd40 <dbl>, cd420 <dbl>, cd496 <dbl>,
#   r <dbl>, cd80 <dbl>, cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>,
#   age_m <dbl>, weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>
```

3. You can sort the rows of dataframes with multiple columns by including many arguments to `arrange()`. Now sort the data by arms (`arms`) and then age_y (`age_y`). Print the result to make sure it looks right!


```r
trial_act <- trial_act %>% 
 arrange(XXX, XXX)
```


```r
trial_act <- trial_act %>% 
 arrange(arms, age_y)

trial_act
```

```
# A tibble: 2,139 x 34
   pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
 1 960014    13      48.5     1     0     0    100      0     0      1
 2 960031    14      48.3     1     0     0    100      0     0      1
 3 990071    14      60       1     0     0    100      0     0      1
 4 980042    16      63       1     0     0    100      0     1      1
 5 171040    17      51.3     0     0     0     90      0     0      1
 6 990026    17     103.      1     0     0    100      0     1      1
 7 310234    18      57.3     1     0     0    100      0     1      1
 8 940519    18      56.8     1     0     0    100      0     1      1
 9 211314    19      50.8     0     0     0     90      0     0      1
10 340767    19      74.8     0     1     0    100      0     0      1
# … with 2,129 more rows, and 24 more variables: preanti <dbl>,
#   race <dbl>, gender <dbl>, str2 <dbl>, strat <dbl>, symptom <dbl>,
#   treat <dbl>, offtrt <dbl>, cd40 <dbl>, cd420 <dbl>, cd496 <dbl>,
#   r <dbl>, cd80 <dbl>, cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>,
#   age_m <dbl>, weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>
```

### F - Filter specific rows with `filter()`

1. Using the `filter()` function, filter only the rows from males (Hint: `gender_char == "male"`)


```r
trial_act %>%
  filter(XXX == "XXX")
```


```r
trial_act %>%
  filter(gender_char == "male")
```

```
# A tibble: 1,771 x 34
   pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
 1 960014    13      48.5     1     0     0    100      0     0      1
 2 960031    14      48.3     1     0     0    100      0     0      1
 3 990071    14      60       1     0     0    100      0     0      1
 4 980042    16      63       1     0     0    100      0     1      1
 5 990026    17     103.      1     0     0    100      0     1      1
 6 940519    18      56.8     1     0     0    100      0     1      1
 7 340767    19      74.8     0     1     0    100      0     0      1
 8 211007    20      72.7     0     1     0     90      0     1      1
 9 261065    20      57.3     0     1     0    100      0     0      1
10 490308    20      72       0     1     0    100      0     0      1
# … with 1,761 more rows, and 24 more variables: preanti <dbl>,
#   race <dbl>, gender <dbl>, str2 <dbl>, strat <dbl>, symptom <dbl>,
#   treat <dbl>, offtrt <dbl>, cd40 <dbl>, cd420 <dbl>, cd496 <dbl>,
#   r <dbl>, cd80 <dbl>, cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>,
#   age_m <dbl>, weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>
```

2. Create a new dataframe called `trial_act_male` that only contains rows from males (hint: just assign what you did in the previous question to a new object!). After you create `trial_act_male`, print it to make sure it only contains data from males!


```r
trial_act_male <- trial_act %>%
  filter(gender_char == "male")

trial_act_male
```

```
# A tibble: 1,771 x 34
   pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
 1 960014    13      48.5     1     0     0    100      0     0      1
 2 960031    14      48.3     1     0     0    100      0     0      1
 3 990071    14      60       1     0     0    100      0     0      1
 4 980042    16      63       1     0     0    100      0     1      1
 5 990026    17     103.      1     0     0    100      0     1      1
 6 940519    18      56.8     1     0     0    100      0     1      1
 7 340767    19      74.8     0     1     0    100      0     0      1
 8 211007    20      72.7     0     1     0     90      0     1      1
 9 261065    20      57.3     0     1     0    100      0     0      1
10 490308    20      72       0     1     0    100      0     0      1
# … with 1,761 more rows, and 24 more variables: preanti <dbl>,
#   race <dbl>, gender <dbl>, str2 <dbl>, strat <dbl>, symptom <dbl>,
#   treat <dbl>, offtrt <dbl>, cd40 <dbl>, cd420 <dbl>, cd496 <dbl>,
#   r <dbl>, cd80 <dbl>, cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>,
#   age_m <dbl>, weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>
```

3. Filter only rows for patients under the age of 60.


```r
trial_act %>%
  filter(age_y < 60)
```

```
# A tibble: 2,110 x 34
   pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
 1 960014    13      48.5     1     0     0    100      0     0      1
 2 960031    14      48.3     1     0     0    100      0     0      1
 3 990071    14      60       1     0     0    100      0     0      1
 4 980042    16      63       1     0     0    100      0     1      1
 5 171040    17      51.3     0     0     0     90      0     0      1
 6 990026    17     103.      1     0     0    100      0     1      1
 7 310234    18      57.3     1     0     0    100      0     1      1
 8 940519    18      56.8     1     0     0    100      0     1      1
 9 211314    19      50.8     0     0     0     90      0     0      1
10 340767    19      74.8     0     1     0    100      0     0      1
# … with 2,100 more rows, and 24 more variables: preanti <dbl>,
#   race <dbl>, gender <dbl>, str2 <dbl>, strat <dbl>, symptom <dbl>,
#   treat <dbl>, offtrt <dbl>, cd40 <dbl>, cd420 <dbl>, cd496 <dbl>,
#   r <dbl>, cd80 <dbl>, cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>,
#   age_m <dbl>, weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>
```


4. A colleague of yours named Tracy wants a datafame only containing data from females over the age of 40. Create this dataframe with `filter()` and call it `trial_act_Tracy`. After you create the dataframe, print it to make sure it looks correct!


```r
trial_act_Tracy <- XXX %>%
  filter(XXX > XXX & XXX == XXX)
```


```r
trial_act_Tracy <- trial_act %>%
  filter(age_y > 40 & gender_char == "female")
```

### G - Combine dataframes with `left_join()`



The `trial_act_demo.csv` file contains additional (fictional) demographic data about the patients, namely the number of days of exercise they get per week, and their highest level of education. Our goal is to add the demographic information to our `trial_act` data.

1. In order to combine the two dataframes, we need to find one 'key' column that we can use to match rows. Look at both the `trial_act` and `trial_act_demo` dataframes. Which column can we use as the 'key' column?

2. Use the `left_join()` function to combine the `trial_act` and `trial_act_demo` datasets, set the `by` argument to the name of the key column that is common in both data sets. Assign the result to `trial_act`. 


```r
trial_act <- trial_act %>%
  left_join(XX, by = "XX")
```


```r
trial_act <- trial_act %>%
  left_join(trial_act_demo, by = "pidnum")
```

3. Print your new `trial_act` dataframe. Do you now see the demographic data?


```r
trial_act
```

```
# A tibble: 2,139 x 36
   pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
 1 960014    13      48.5     1     0     0    100      0     0      1
 2 960031    14      48.3     1     0     0    100      0     0      1
 3 990071    14      60       1     0     0    100      0     0      1
 4 980042    16      63       1     0     0    100      0     1      1
 5 171040    17      51.3     0     0     0     90      0     0      1
 6 990026    17     103.      1     0     0    100      0     1      1
 7 310234    18      57.3     1     0     0    100      0     1      1
 8 940519    18      56.8     1     0     0    100      0     1      1
 9 211314    19      50.8     0     0     0     90      0     0      1
10 340767    19      74.8     0     1     0    100      0     0      1
# … with 2,129 more rows, and 26 more variables: preanti <dbl>,
#   race <dbl>, gender <dbl>, str2 <dbl>, strat <dbl>, symptom <dbl>,
#   treat <dbl>, offtrt <dbl>, cd40 <dbl>, cd420 <dbl>, cd496 <dbl>,
#   r <dbl>, cd80 <dbl>, cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>,
#   age_m <dbl>, weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>, exercise <dbl>,
#   education <chr>
```

### H - Reshaping with gather() and spread()

Remember the `CD4_wide` dataframe you created before? Currently it is in the *wide* format, where each row is a patient, where key data (different CD4 T cell counts) are in different columns like this:




```r
# Data is in a 'wide' format
CD4_wide
```

```
# A tibble: 2,139 x 5
   pidnum  arms  cd40 cd420 cd496
    <dbl> <dbl> <dbl> <dbl> <dbl>
 1 960014     0   283   271    NA
 2 960031     0   481   428   519
 3 990071     0   166   169    28
 4 980042     0   299   214   124
 5 171040     0   549   415   436
 6 990026     0   373   218    NA
 7 310234     0   445   371   338
 8 940519     0   276   150    34
 9 211314     0   298   267    NA
10 340767     0   503   452    NA
# … with 2,129 more rows
```

Our goal is to convert this data to a 'long' format, where each row represents a single CD4 T cell count for a specific patient, like this:




```r
# This is the same data in 'long' format
CD4_long
```

```
# A tibble: 6,417 x 4
   pidnum  arms time  value
    <dbl> <dbl> <chr> <dbl>
 1 960014     0 cd40    283
 2 960031     0 cd40    481
 3 990071     0 cd40    166
 4 980042     0 cd40    299
 5 171040     0 cd40    549
 6 990026     0 cd40    373
 7 310234     0 cd40    445
 8 940519     0 cd40    276
 9 211314     0 cd40    298
10 340767     0 cd40    503
# … with 6,407 more rows
```

1. Using the `gather()` function, create a new dataframe called `CD4_long` that shows the `CD4_wide` data in the 'long' format. To do this, use the following template. Set the grouping column to `time` and the new data column to `value`. 


```r
CD4_long <- CD4_wide %>% 
  gather(XX,  # New grouping column
         XX,  # New data column
         -pidnum, -arms)  # Names of columns to replicate
```


```r
CD4_long <- CD4_wide %>% 
  gather(time,  # New grouping column
         value,  # New data column
         -pidnum, -arms)  # Names of columns to replicate
```

2. Print your `CD4_long` dataframe! Do you now see that each row is a specific observation for a patient?


```r
CD4_long
```

```
# A tibble: 6,417 x 4
   pidnum  arms time  value
    <dbl> <dbl> <chr> <dbl>
 1 960014     0 cd40    283
 2 960031     0 cd40    481
 3 990071     0 cd40    166
 4 980042     0 cd40    299
 5 171040     0 cd40    549
 6 990026     0 cd40    373
 7 310234     0 cd40    445
 8 940519     0 cd40    276
 9 211314     0 cd40    298
10 340767     0 cd40    503
# … with 6,407 more rows
```

3. Now use the `spread()` function to convert the long data bring the data *back* into the wide format! To do this, make the first argument `time`, and the second argument `value`


```r
CD4_long %>%
  spread(XX,   # Grouping column
         XX)   # Value columnn
```


```r
CD4_long %>%
  spread(time, value)
```

```
# A tibble: 2,139 x 5
   pidnum  arms  cd40 cd420 cd496
    <dbl> <dbl> <dbl> <dbl> <dbl>
 1  10056     2   422   477   660
 2  10059     3   162   218    NA
 3  10089     3   326   274   122
 4  10093     3   287   394    NA
 5  10124     0   504   353   660
 6  10140     1   235   339   264
 7  10165     0   244   225   106
 8  10190     0   401   366   453
 9  10198     3   214   107     8
10  10229     0   221   132    NA
# … with 2,129 more rows
```

### Practice!

1. Create a new dataframe called `trial_A` from `trial_act` with the following restrictions:

- Only patients who take intraveneous drugs (`drugs == 1`)
- Only patients younger than 60
- Only patients whose baseline CD4 T cell counts `cd40` were greater than 250 *and* less than 400.


```r
trial_A <- trial_act %>%
  filter(drugs == 1,
         age_y < 60,
         cd40 > 250 & cd40 < 400)

trial_A
```

```
# A tibble: 126 x 36
   pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
 1 630023    26      86.2     0     0     1     90      0     0      1
 2  10378    27      67.3     0     0     1     90      0     1      1
 3 320475    27      66.6     0     0     1     90      0     0      1
 4  71333    29      73.9     0     1     1    100      0     0      1
 5 140809    29      70       0     1     1    100      0     0      1
 6 630030    29      88.2     0     0     1    100      0     0      1
 7 190395    33      68       0     0     1    100      0     1      1
 8 320365    34      86.0     0     0     1    100      0     0      1
 9 540015    34      72.6     0     0     1    100      0     0      1
10 180917    35      77.7     0     0     1     90      0     1      1
# … with 116 more rows, and 26 more variables: preanti <dbl>, race <dbl>,
#   gender <dbl>, str2 <dbl>, strat <dbl>, symptom <dbl>, treat <dbl>,
#   offtrt <dbl>, cd40 <dbl>, cd420 <dbl>, cd496 <dbl>, r <dbl>,
#   cd80 <dbl>, cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>,
#   age_m <dbl>, weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>, exercise <dbl>,
#   education <chr>
```

2. Add a new column to `trial_act` called `drugs_char` which is `"User"` when drugs == 1, and `"Non User"` when drugs == 0.


```r
trial_act <- trial_act %>%
  mutate(drugs_char = case_when(
    drugs == 1 ~ "User",
    drugs == 0 ~ "Non User"
  ))

trial_act
```

```
# A tibble: 2,139 x 37
   pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
    <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
 1 960014    13      48.5     1     0     0    100      0     0      1
 2 960031    14      48.3     1     0     0    100      0     0      1
 3 990071    14      60       1     0     0    100      0     0      1
 4 980042    16      63       1     0     0    100      0     1      1
 5 171040    17      51.3     0     0     0     90      0     0      1
 6 990026    17     103.      1     0     0    100      0     1      1
 7 310234    18      57.3     1     0     0    100      0     1      1
 8 940519    18      56.8     1     0     0    100      0     1      1
 9 211314    19      50.8     0     0     0     90      0     0      1
10 340767    19      74.8     0     1     0    100      0     0      1
# … with 2,129 more rows, and 27 more variables: preanti <dbl>,
#   race <dbl>, gender <dbl>, str2 <dbl>, strat <dbl>, symptom <dbl>,
#   treat <dbl>, offtrt <dbl>, cd40 <dbl>, cd420 <dbl>, cd496 <dbl>,
#   r <dbl>, cd80 <dbl>, cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>,
#   age_m <dbl>, weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>, exercise <dbl>,
#   education <chr>, drugs_char <chr>
```

3. Create a new dataframe called `trial_B` from `trial_act` with the following restrictions:

- Only patients whose CD4 T cell counts increase *more* than 200 between baseline (`cd40`) and after 96 weeks (`cd496`)
- Only drug users


```r
trial_B <- trial_act %>%
  filter(
    cd496 - cd40 > 200,
    drugs == 1
  )

trial_B
```

```
# A tibble: 8 x 37
  pidnum age_y weight_kg  hemo  homo drugs karnof oprior   z30 zprior
   <dbl> <dbl>     <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl> <dbl>  <dbl>
1 220489    45      70.9     0     0     1    100      0     0      1
2 140744    30      81.2     0     1     1    100      0     0      1
3  10962    41      81.9     0     0     1     90      0     0      1
4  50580    68      90.5     0     1     1    100      0     1      1
5  10881    36      81.6     0     1     1    100      0     1      1
6 250197    49      86.2     0     1     1     90      0     0      1
7  50572    28      84.4     0     1     1     90      0     0      1
8  50623    35      77       0     1     1    100      0     0      1
# … with 27 more variables: preanti <dbl>, race <dbl>, gender <dbl>,
#   str2 <dbl>, strat <dbl>, symptom <dbl>, treat <dbl>, offtrt <dbl>,
#   cd40 <dbl>, cd420 <dbl>, cd496 <dbl>, r <dbl>, cd80 <dbl>,
#   cd820 <dbl>, cens <dbl>, days <dbl>, arms <dbl>, age_m <dbl>,
#   weight_lb <dbl>, cd_change_20 <dbl>, cd_change_960 <dbl>,
#   gender_char <chr>, arms_char <chr>, agem <dbl>, exercise <dbl>,
#   education <chr>, drugs_char <chr>
```


## Additional Resources

- See [https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html) for the full dplyr vignette with lots of wrangling tips and tricks.

