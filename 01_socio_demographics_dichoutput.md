Model Details:
==============

H2OBinomialModel: glm
Model ID:  metalearner_AUTO_StackedEnsemble_AllModels_2_AutoML_1_20220713_102823 
GLM Model: summary
    family  link                                regularization number_of_predictors_total
1 binomial logit Elastic Net (alpha = 0.5, lambda = 1.802E-4 )                         12
  number_of_active_predictors number_of_iterations
1                           8                    3
                                                          training_frame
1 levelone_training_StackedEnsemble_AllModels_2_AutoML_1_20220713_102823

Coefficients: glm coefficients
                                     names coefficients standardized_coefficients
1                                Intercept     0.003207                  0.013879
2       XGBoost_3_AutoML_1_20220713_102823     0.326406                  0.204844
3           GBM_5_AutoML_1_20220713_102823     0.321030                  0.188577
4           GBM_2_AutoML_1_20220713_102823     0.040381                  0.023971
5           GBM_3_AutoML_1_20220713_102823     0.000000                  0.000000
6           GBM_1_AutoML_1_20220713_102823     0.090259                  0.053362
7  DeepLearning_1_AutoML_1_20220713_102823     0.164372                  0.092163
8           GBM_4_AutoML_1_20220713_102823     0.000000                  0.000000
9           DRF_1_AutoML_1_20220713_102823     0.003278                  0.001903
10          XRT_1_AutoML_1_20220713_102823     0.052370                  0.024818
11          GLM_1_AutoML_1_20220713_102823     0.048050                  0.027580
12      XGBoost_2_AutoML_1_20220713_102823     0.000000                  0.000000
13      XGBoost_1_AutoML_1_20220713_102823     0.000000                  0.000000

H2OBinomialMetrics: glm
** Reported on training data. **

MSE:  0.2301803
RMSE:  0.4797711
LogLoss:  0.6519715
Mean Per-Class Error:  0.4552217
AUC:  0.6581717
AUCPR:  0.6584928
Gini:  0.3163433
R^2:  0.07927524
Residual Deviance:  204601.7
AIC:  204619.7

Confusion Matrix (vertical: actual; across: predicted) for F1-optimal threshold:
                           Can't Be Too Careful Most People Can Be Trusted    Error           Rate
Can't Be Too Careful                      11938                      66363 0.847537   =66363/78301
Most People Can Be Trusted                 4945                      73664 0.062906    =4945/78609
Totals                                    16883                     140027 0.454452  =71308/156910

Maximum Metrics: Maximum metrics at their respective thresholds
                        metric threshold        value idx
1                       max f1  0.331740     0.673851 336
2                       max f2  0.209514     0.833881 398
3                 max f0point5  0.500221     0.611847 207
4                 max accuracy  0.513881     0.613403 197
5                max precision  0.900344     0.894737   1
6                   max recall  0.209514     1.000000 398
7              max specificity  0.907590     0.999974   0
8             max absolute_mcc  0.549889     0.239840 173
9   max min_per_class_accuracy  0.485535     0.601203 219
10 max mean_per_class_accuracy  0.513881     0.613658 197
11                     max tns  0.907590 78299.000000   0
12                     max fns  0.907590 78605.000000   0
13                     max fps  0.184422 78301.000000 399
14                     max tps  0.209514 78609.000000 398
15                     max tnr  0.907590     0.999974   0
16                     max fnr  0.907590     0.999949   0
17                     max fpr  0.184422     1.000000 399
18                     max tpr  0.209514     1.000000 398

Gains/Lift Table: Extract with `h2o.gainsLift(<model>, <data>)` or `h2o.gainsLift(<model>, valid=<T/F>, xval=<T/F>)`

H2OBinomialMetrics: glm
** Reported on cross-validation data. **
** 5-fold cross-validation on training data (Metrics computed for combined holdout predictions) **

MSE:  0.2302169
RMSE:  0.4798092
LogLoss:  0.6520511
Mean Per-Class Error:  0.4574776
AUC:  0.6579892
AUCPR:  0.6583288
Gini:  0.3159783
R^2:  0.07912885
Residual Deviance:  204626.7
AIC:  204644.7

Confusion Matrix (vertical: actual; across: predicted) for F1-optimal threshold:
                           Can't Be Too Careful Most People Can Be Trusted    Error           Rate
Can't Be Too Careful                      11257                      67044 0.856234   =67044/78301
Most People Can Be Trusted                 4616                      73993 0.058721    =4616/78609
Totals                                    15873                     141037 0.456695  =71660/156910

Maximum Metrics: Maximum metrics at their respective thresholds
                        metric threshold        value idx
1                       max f1  0.328543     0.673748 340
2                       max f2  0.210912     0.833881 398
3                 max f0point5  0.501691     0.611612 208
4                 max accuracy  0.522047     0.613256 193
5                max precision  0.881282     0.902439   4
6                   max recall  0.210912     1.000000 398
7              max specificity  0.914212     0.999987   0
8             max absolute_mcc  0.542842     0.239461 180
9   max min_per_class_accuracy  0.484854     0.605369 222
10 max mean_per_class_accuracy  0.522047     0.613540 193
11                     max tns  0.914212 78300.000000   0
12                     max fns  0.914212 78608.000000   0
13                     max fps  0.185515 78301.000000 399
14                     max tps  0.210912 78609.000000 398
15                     max tnr  0.914212     0.999987   0
16                     max fnr  0.914212     0.999987   0
17                     max fpr  0.185515     1.000000 399
18                     max tpr  0.210912     1.000000 398

Gains/Lift Table: Extract with `h2o.gainsLift(<model>, <data>)` or `h2o.gainsLift(<model>, valid=<T/F>, xval=<T/F>)`
Cross-Validation Metrics Summary: 
                  mean         sd   cv_1_valid   cv_2_valid   cv_3_valid   cv_4_valid   cv_5_valid
accuracy      0.547694   0.003213     0.542350     0.547887     0.550698     0.547942     0.549593
auc           0.658049   0.003553     0.654416     0.658882     0.662725     0.659657     0.654564
err           0.452306   0.003213     0.457650     0.452113     0.449302     0.452058     0.450407
err_count 14194.200000 109.097206 14378.000000 14162.000000 14202.000000 14111.000000 14118.000000
f0point5      0.577732   0.001850     0.575862     0.580002     0.577753     0.579096     0.575947

---
                          mean         sd   cv_1_valid   cv_2_valid   cv_3_valid   cv_4_valid   cv_5_valid
precision             0.527439   0.001914     0.524631     0.529749     0.527632     0.528411     0.526773
r2                    0.079087   0.003382     0.075441     0.078675     0.084084     0.080474     0.076762
recall                0.934044   0.009717     0.944987     0.934652     0.931821     0.939606     0.919155
residual_deviance 40925.332000 171.010940 41093.727000 40864.688000 41051.930000 40664.184000 40952.133000
rmse                  0.479810   0.000880     0.480765     0.479903     0.478513     0.479452     0.480417
specificity           0.159689   0.019089     0.136134     0.153087     0.172768     0.151759     0.184694