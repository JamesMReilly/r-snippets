


heart-disease-modeling
========================================================
author: Jim Reilly
date: 3-3-2019
autosize: true

UCI Heart Disease Dataset
========================================================
[Heart Disease dataset on UCI](https://www.kaggle.com/ronitf/heart-disease-uci/home)

[Original UCI Archive](https://archive.ics.uci.edu/ml/datasets/heart+Disease)

Dataset of 13 attributes and 1 label of heart disease in patients, a subset of the greater "Cleveland" heart disease database being used by ML researchers. 

The goal is to identify the presence of heart disease in patients based on the available predictors.

Available Predictors
========================================================

- age: int 
- sex: 0 (female) 1 (male) 
- cp: 0-4 encoding for type of chest pain
- trestbps: int resting blood pressure
- chol: int cholestoral in mg/dl
- fbs: boolean fasting blood sugar >120 mg/dl
- restecg: 0,1,2 encoding for resting ecg result
- thalach: int for max heart rate from exercise

***

- exang: boolean excercise induced angina 
- oldpeak: double ST depression during exercise
- slope: 0,1,2 encoding for slope of ST segment
- ca: 0-4 number of major vessels colored
- thal: 3-level factor for defects
- Label: 0 (no-disease) 1 (disease)

"Show me the Data"
========================================================




```r
heart <- read.csv(file="data/heart.csv",fileEncoding="UTF-8-BOM")
heart$target <- factor(heart$target)
```


```r
dim(heart)
```

```
[1] 303  14
```

```r
heart %>% group_by(target) %>% summarise(patients = length(target))
```

```
# A tibble: 2 x 2
  target patients
  <fct>     <int>
1 0           138
2 1           165
```

"Show me the Data"
========================================================


```r
head(heart[1:7], n = 3)
```

```
  age sex cp trestbps chol fbs restecg
1  63   1  3      145  233   1       0
2  37   1  2      130  250   0       1
3  41   0  1      130  204   0       0
```

```r
head(heart[8:14], n = 3)
```

```
  thalach exang oldpeak slope ca thal target
1     150     0     2.3     0  0    1      1
2     187     0     3.5     0  0    2      1
3     172     0     1.4     2  0    2      1
```

Hypothesis
========================================================

## The presence of heart disease can be predicted with these 13 variables

Variable Visualization
========================================================

![plot of chunk unnamed-chunk-1](heart-disease-figure/unnamed-chunk-1-1.png)

***

![plot of chunk sex](heart-disease-figure/sex-1.png)
