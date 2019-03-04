


Modeling Heart Disease
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

Quantitative Summary
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

A View at a Record
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

![plot of chunk chest pain](heart-disease-figure/chest pain-1.png)

***

![plot of chunk thalach](heart-disease-figure/thalach-1.png)


Variable Visualization
========================================================

![plot of chunk excercise angina](heart-disease-figure/excercise angina-1.png)

***

![plot of chunk old peak](heart-disease-figure/old peak-1.png)

Variable Visualization
========================================================

![plot of chunk ca](heart-disease-figure/ca-1.png)

***

![plot of chunk sex](heart-disease-figure/sex-1.png)

Model Setup
========================================================


```r
set.seed(3456)

trainIndex <- createDataPartition(heart$target, p = 0.8, list = FALSE)

heart.train <- heart[trainIndex, ]
heart.valid <- heart[-trainIndex, ]
```

Logistic Regression Model
========================================================


```
Start:  AIC=337.05
target ~ 1

          Df Deviance    AIC
+ thalach  1   283.58 287.58
+ cp       1   285.46 289.46
+ exang    1   288.68 292.68
+ oldpeak  1   289.42 293.42
+ ca       1   292.28 296.28
+ slope    1   304.51 308.51
+ thal     1   305.56 309.56
+ sex      1   317.22 321.22
<none>         335.05 337.05
+ restecg  1   333.12 337.12
+ fbs      1   334.71 338.71

Step:  AIC=287.58
target ~ thalach

          Df Deviance    AIC
+ cp       1   254.30 260.30
+ ca       1   254.98 260.98
+ oldpeak  1   260.43 266.43
+ thal     1   262.30 268.30
+ exang    1   263.16 269.16
+ sex      1   266.53 272.53
+ slope    1   271.81 277.81
<none>         283.58 287.58
+ restecg  1   282.18 288.18
+ fbs      1   283.23 289.23

Step:  AIC=260.3
target ~ thalach + cp

          Df Deviance    AIC
+ oldpeak  1   230.18 238.18
+ ca       1   230.59 238.59
+ sex      1   233.62 241.62
+ thal     1   233.95 241.95
+ slope    1   242.24 250.24
+ exang    1   244.04 252.04
<none>         254.30 260.30
+ restecg  1   252.78 260.78
+ fbs      1   252.91 260.92

Step:  AIC=238.18
target ~ thalach + cp + oldpeak

          Df Deviance    AIC
+ sex      1   209.94 219.94
+ ca       1   210.55 220.55
+ thal     1   213.31 223.31
+ exang    1   223.33 233.33
<none>         230.18 238.18
+ restecg  1   228.76 238.76
+ fbs      1   228.84 238.84
+ slope    1   229.00 239.00

Step:  AIC=219.94
target ~ thalach + cp + oldpeak + sex

          Df Deviance    AIC
+ ca       1   193.11 205.11
+ thal     1   196.85 208.85
+ exang    1   204.47 216.47
<none>         209.94 219.94
+ slope    1   208.55 220.55
+ restecg  1   208.62 220.62
+ fbs      1   209.16 221.16

Step:  AIC=205.11
target ~ thalach + cp + oldpeak + sex + ca
```


Model Summary
========================================================


```r
summary(heart.glm)
```

```

Call:
glm(formula = target ~ thalach + cp + oldpeak + sex + ca, family = "binomial", 
    data = heart.train)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.3942  -0.4881   0.2537   0.6383   2.3952  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)    
(Intercept) -3.025102   1.461133  -2.070 0.038417 *  
thalach      0.030675   0.009433   3.252 0.001147 ** 
cp           0.903920   0.181670   4.976 6.50e-07 ***
oldpeak     -0.761358   0.196113  -3.882 0.000103 ***
sex         -1.604174   0.409521  -3.917 8.96e-05 ***
ca          -0.799363   0.211464  -3.780 0.000157 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 335.05  on 242  degrees of freedom
Residual deviance: 193.11  on 237  degrees of freedom
AIC: 205.11

Number of Fisher Scoring iterations: 5
```

Performance (Test fit)
========================================================


```r
heart.predictions <- predict(heart.glm, heart.train, type = "response")
confusionMatrix(factor(as.numeric(heart.predictions > 0.5)), heart.train$target)
```

```
Confusion Matrix and Statistics

          Reference
Prediction   0   1
         0  82  16
         1  29 116
                                          
               Accuracy : 0.8148          
                 95% CI : (0.7602, 0.8616)
    No Information Rate : 0.5432          
    P-Value [Acc > NIR] : < 2e-16         
                                          
                  Kappa : 0.6233          
 Mcnemar's Test P-Value : 0.07364         
                                          
            Sensitivity : 0.7387          
            Specificity : 0.8788          
         Pos Pred Value : 0.8367          
         Neg Pred Value : 0.8000          
             Prevalence : 0.4568          
         Detection Rate : 0.3374          
   Detection Prevalence : 0.4033          
      Balanced Accuracy : 0.8088          
                                          
       'Positive' Class : 0               
                                          
```


Performance (Validation fit)
========================================================


```r
heart.predictions <- predict(heart.glm, heart.valid, type = "response")
confusionMatrix(factor(as.numeric(heart.predictions > 0.5)), heart.valid$target)
```

```
Confusion Matrix and Statistics

          Reference
Prediction  0  1
         0 24  9
         1  3 24
                                          
               Accuracy : 0.8             
                 95% CI : (0.6767, 0.8922)
    No Information Rate : 0.55            
    P-Value [Acc > NIR] : 4.67e-05        
                                          
                  Kappa : 0.604           
 Mcnemar's Test P-Value : 0.1489          
                                          
            Sensitivity : 0.8889          
            Specificity : 0.7273          
         Pos Pred Value : 0.7273          
         Neg Pred Value : 0.8889          
             Prevalence : 0.4500          
         Detection Rate : 0.4000          
   Detection Prevalence : 0.5500          
      Balanced Accuracy : 0.8081          
                                          
       'Positive' Class : 0               
                                          
```

Conclusion
========================================================

Outcomes
  - We can effectively model heart disease with 80% accuracy
  - only 5 features were required out of a provided 13
  - Only simple methods required in modeling

Suggested improvements
 - Try a non-linear model
 - Lower threshold if cost of false positive is +++
 - Boost on missclassification
 


