Model Details:
==============

H2OBinomialModel: glm
Model ID:  metalearner_AUTO_StackedEnsemble_AllModels_3_AutoML_1_20220712_144133
GLM Model: summary
    family  link                                regularization number_of_predictors_total
1 binomial logit Elastic Net (alpha = 0.5, lambda = 2.258E-4 )                         55
  number_of_active_predictors number_of_iterations
1                          14                    4
                                                          training_frame
1 levelone_training_StackedEnsemble_AllModels_3_AutoML_1_20220712_144133

Coefficients: glm coefficients
                                             names coefficients standardized_coefficients
1                                        Intercept    -0.001389                  0.012702
2                   GBM_2_AutoML_1_20220712_144133     0.000000                  0.000000
3 XGBoost_grid_1_AutoML_1_20220712_144133_model_11     0.155605                  0.098908
4     GBM_grid_1_AutoML_1_20220712_144133_model_17     0.000000                  0.000000
5     GBM_grid_1_AutoML_1_20220712_144133_model_10     0.000000                  0.000000

---
                                                  names coefficients standardized_coefficients
51          GBM_grid_1_AutoML_1_20220712_144133_model_9     0.000000                  0.000000
52         GBM_grid_1_AutoML_1_20220712_144133_model_11     0.000000                  0.000000
53         GBM_grid_1_AutoML_1_20220712_144133_model_14     0.000000                  0.000000
54 DeepLearning_grid_1_AutoML_1_20220712_144133_model_4     0.000000                  0.000000
55     XGBoost_grid_1_AutoML_1_20220712_144133_model_18     0.000000                  0.000000
56      XGBoost_grid_1_AutoML_1_20220712_144133_model_7     0.000000                  0.000000

H2OBinomialMetrics: glm
** Reported on training data. **

MSE:  0.2284561
RMSE:  0.4779708
LogLoss:  0.6481643
Mean Per-Class Error:  0.4413433
AUC:  0.6651846
AUCPR:  0.6642103
Gini:  0.3303692
R^2:  0.08617207
Residual Deviance:  203406.9
AIC:  203436.9

Confusion Matrix (vertical: actual; across: predicted) for F1-optimal threshold:
                           Can't Be Too Careful Most People Can Be Trusted    Error           Rate
Can't Be Too Careful                      14973                      63328 0.808776   =63328/78301
Most People Can Be Trusted                 5810                      72799 0.073910    =5810/78609
Totals                                    20783                     136127 0.440622  =69138/156910

Maximum Metrics: Maximum metrics at their respective thresholds
                        metric threshold        value idx
1                       max f1  0.346273     0.678033 314
2                       max f2  0.160792     0.833878 399
3                 max f0point5  0.496904     0.616781 202
4                 max accuracy  0.499881     0.617137 200
5                max precision  0.880376     0.900990   3
6                   max recall  0.160792     1.000000 399
7              max specificity  0.895936     0.999987   0
8             max absolute_mcc  0.555991     0.245332 164
9   max min_per_class_accuracy  0.483625     0.613504 212
10 max mean_per_class_accuracy  0.499881     0.617307 200
11                     max tns  0.895936 78300.000000   0
12                     max fns  0.895936 78601.000000   0
13                     max fps  0.160792 78301.000000 399
14                     max tps  0.160792 78609.000000 399
15                     max tnr  0.895936     0.999987   0
16                     max fnr  0.895936     0.999898   0
17                     max fpr  0.160792     1.000000 399
18                     max tpr  0.160792     1.000000 399

Gains/Lift Table: Extract with `h2o.gainsLift(<model>, <data>)` or `h2o.gainsLift(<model>, valid=<T/F>, xval=<T/F>)`

H2OBinomialMetrics: glm
** Reported on cross-validation data. **
** 5-fold cross-validation on training data (Metrics computed for combined holdout predictions) **

MSE:  0.2285006
RMSE:  0.4780173
LogLoss:  0.6482636
Mean Per-Class Error:  0.4415027
AUC:  0.6650254
AUCPR:  0.6640378
Gini:  0.3300509
R^2:  0.08599419
Residual Deviance:  203438.1
AIC:  203470.1

Confusion Matrix (vertical: actual; across: predicted) for F1-optimal threshold:
                           Can't Be Too Careful Most People Can Be Trusted    Error           Rate
Can't Be Too Careful                      14954                      63347 0.809019   =63347/78301
Most People Can Be Trusted                 5816                      72793 0.073986    =5816/78609
Totals                                    20770                     136140 0.440781  =69163/156910

Maximum Metrics: Maximum metrics at their respective thresholds
                        metric threshold        value idx
1                       max f1  0.346299     0.677936 317
2                       max f2  0.162277     0.833878 399
3                 max f0point5  0.496505     0.616784 206
4                 max accuracy  0.498288     0.617112 205
5                max precision  0.905196     1.000000   0
6                   max recall  0.162277     1.000000 399
7              max specificity  0.905196     1.000000   0
8             max absolute_mcc  0.555627     0.245487 168
9   max min_per_class_accuracy  0.482616     0.610388 219
10 max mean_per_class_accuracy  0.498288     0.617274 205
11                     max tns  0.905196 78301.000000   0
12                     max fns  0.905196 78607.000000   0
13                     max fps  0.162277 78301.000000 399
14                     max tps  0.162277 78609.000000 399
15                     max tnr  0.905196     1.000000   0
16                     max fnr  0.905196     0.999975   0
17                     max fpr  0.162277     1.000000 399
18                     max tpr  0.162277     1.000000 399

Gains/Lift Table: Extract with `h2o.gainsLift(<model>, <data>)` or `h2o.gainsLift(<model>, valid=<T/F>, xval=<T/F>)`
Cross-Validation Metrics Summary:
                  mean         sd   cv_1_valid   cv_2_valid   cv_3_valid   cv_4_valid   cv_5_valid
accuracy      0.557983   0.003676     0.557787     0.561696     0.553134     0.555837     0.561461
auc           0.665070   0.004254     0.663503     0.659735     0.670278     0.663376     0.668458
err           0.442017   0.003676     0.442213     0.438304     0.446866     0.444163     0.438539
err_count 13871.600000 158.763350 13893.000000 13729.000000 14125.000000 13865.000000 13746.000000
f0point5      0.583473   0.003054     0.581756     0.586448     0.581323     0.580718     0.587120

---
                          mean         sd   cv_1_valid   cv_2_valid   cv_3_valid   cv_4_valid   cv_5_valid
precision             0.533826   0.003533     0.532218     0.537635     0.530564     0.531068     0.537645
r2                    0.085962   0.003839     0.085249     0.080870     0.091123     0.084599     0.087970
recall                0.929224   0.007635     0.926832     0.920881     0.941681     0.927602     0.929123
residual_deviance 40687.580000 130.146130 40755.293000 40782.797000 40803.914000 40519.920000 40575.965000
rmse                  0.478019   0.001003     0.478210     0.479347     0.476674     0.478380     0.477485
specificity           0.185288   0.013408     0.191527     0.197918     0.162639     0.186682     0.187673



Variable Importances: 
                      variable relative_importance scaled_importance percentage
1                          age         8350.925781          1.000000   0.484317
2         race.AfricanAmerican         2619.973145          0.313734   0.151947
3           education.UniBelow         1643.640869          0.196821   0.095324
4                   race.White         1615.746094          0.193481   0.093706
5 ethnicity.Hispanic or Latino          951.525879          0.113943   0.055184

---
                    variable relative_importance scaled_importance percentage
25                race.Asian           18.079102          0.002165   0.001049
26   religion.Other_Religion           17.809072          0.002133   0.001033
27         ethnicity.Unknown           15.712411          0.001882   0.000911
28        gender.missing(NA)            8.871752          0.001062   0.000515
29 religion.Protestant_Other            6.090040          0.000729   0.000353
30              gender.Other            4.174754          0.000500   0.000242
