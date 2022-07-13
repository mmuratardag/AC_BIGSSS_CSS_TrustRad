Model Details:
==============

H2OBinomialModel: glm
Model ID:  metalearner_AUTO_StackedEnsemble_AllModels_3_AutoML_1_20220713_141515 
GLM Model: summary
    family  link                                regularization number_of_predictors_total
1 binomial logit Elastic Net (alpha = 0.5, lambda = 3.257E-4 )                         37
  number_of_active_predictors number_of_iterations
1                          21                    3
                                                          training_frame
1 levelone_training_StackedEnsemble_AllModels_3_AutoML_1_20220713_141515

Coefficients: glm coefficients
                                            names coefficients standardized_coefficients
1                                       Intercept     0.009748                  0.013543
2                  GBM_5_AutoML_1_20220713_141515     0.000000                  0.000000
3                  GBM_2_AutoML_1_20220713_141515     0.050133                  0.036898
4 XGBoost_grid_1_AutoML_1_20220713_141515_model_4     0.058730                  0.043685
5     GBM_grid_1_AutoML_1_20220713_141515_model_2     0.000000                  0.000000

---
                                             names coefficients standardized_coefficients
33              XGBoost_2_AutoML_1_20220713_141515     0.000000                  0.000000
34     GBM_grid_1_AutoML_1_20220713_141515_model_9     0.000000                  0.000000
35 XGBoost_grid_1_AutoML_1_20220713_141515_model_8     0.000000                  0.000000
36    GBM_grid_1_AutoML_1_20220713_141515_model_11     0.000000                  0.000000
37              XGBoost_1_AutoML_1_20220713_141515     0.000000                  0.000000
38 XGBoost_grid_1_AutoML_1_20220713_141515_model_7     0.000000                  0.000000

H2OBinomialMetrics: glm
** Reported on training data. **

MSE:  0.2215006
RMSE:  0.4706385
LogLoss:  0.6328923
Mean Per-Class Error:  0.4151518
AUC:  0.6921216
AUCPR:  0.6906878
Gini:  0.3842432
R^2:  0.113994
Residual Deviance:  198614.3
AIC:  198658.3

Confusion Matrix (vertical: actual; across: predicted) for F1-optimal threshold:
                           Can't Be Too Careful Most People Can Be Trusted    Error           Rate
Can't Be Too Careful                      21014                      57287 0.731625   =57287/78301
Most People Can Be Trusted                 7757                      70852 0.098678    =7757/78609
Totals                                    28771                     128139 0.414531  =65044/156910

Maximum Metrics: Maximum metrics at their respective thresholds
                        metric threshold        value idx
1                       max f1  0.346971     0.685395 301
2                       max f2  0.162346     0.834240 382
3                 max f0point5  0.516706     0.638982 194
4                 max accuracy  0.495523     0.637168 208
5                max precision  0.911401     0.925311   4
6                   max recall  0.094239     1.000000 399
7              max specificity  0.939844     0.999974   0
8             max absolute_mcc  0.547321     0.277215 176
9   max min_per_class_accuracy  0.490223     0.636301 212
10 max mean_per_class_accuracy  0.495523     0.637200 208
11                     max tns  0.939844 78299.000000   0
12                     max fns  0.939844 78597.000000   0
13                     max fps  0.094239 78301.000000 399
14                     max tps  0.094239 78609.000000 399
15                     max tnr  0.939844     0.999974   0
16                     max fnr  0.939844     0.999847   0
17                     max fpr  0.094239     1.000000 399
18                     max tpr  0.094239     1.000000 399

Gains/Lift Table: Extract with `h2o.gainsLift(<model>, <data>)` or `h2o.gainsLift(<model>, valid=<T/F>, xval=<T/F>)`

H2OBinomialMetrics: glm
** Reported on cross-validation data. **
** 5-fold cross-validation on training data (Metrics computed for combined holdout predictions) **

MSE:  0.2215824
RMSE:  0.4707254
LogLoss:  0.6330796
Mean Per-Class Error:  0.4203002
AUC:  0.6918579
AUCPR:  0.6903869
Gini:  0.3837158
R^2:  0.1136669
Residual Deviance:  198673.1
AIC:  198709.1

Confusion Matrix (vertical: actual; across: predicted) for F1-optimal threshold:
                           Can't Be Too Careful Most People Can Be Trusted    Error           Rate
Can't Be Too Careful                      19384                      58917 0.752442   =58917/78301
Most People Can Be Trusted                 6930                      71679 0.088158    =6930/78609
Totals                                    26314                     130596 0.419648  =65847/156910

Maximum Metrics: Maximum metrics at their respective thresholds
                        metric threshold        value idx
1                       max f1  0.337548     0.685251 306
2                       max f2  0.164672     0.834150 382
3                 max f0point5  0.510999     0.638774 197
4                 max accuracy  0.495955     0.636932 208
5                max precision  0.920124     0.921739   3
6                   max recall  0.089946     1.000000 399
7              max specificity  0.943006     0.999987   0
8             max absolute_mcc  0.545878     0.276887 175
9   max min_per_class_accuracy  0.490278     0.636123 212
10 max mean_per_class_accuracy  0.495955     0.636968 208
11                     max tns  0.943006 78300.000000   0
12                     max fns  0.943006 78605.000000   0
13                     max fps  0.089946 78301.000000 399
14                     max tps  0.089946 78609.000000 399
15                     max tnr  0.943006     0.999987   0
16                     max fnr  0.943006     0.999949   0
17                     max fpr  0.089946     1.000000 399
18                     max tpr  0.089946     1.000000 399

Gains/Lift Table: Extract with `h2o.gainsLift(<model>, <data>)` or `h2o.gainsLift(<model>, valid=<T/F>, xval=<T/F>)`
Cross-Validation Metrics Summary: 
                  mean         sd   cv_1_valid   cv_2_valid   cv_3_valid   cv_4_valid   cv_5_valid
accuracy      0.583396   0.013077     0.589171     0.581905     0.594704     0.561475     0.589727
auc           0.691859   0.004535     0.694181     0.688003     0.697916     0.686850     0.692345
err           0.416604   0.013077     0.410829     0.418095     0.405296     0.438525     0.410273
err_count 13072.600000 361.093200 12907.000000 13096.000000 12811.000000 13689.000000 12860.000000
f0point5      0.598297   0.008186     0.600068     0.598320     0.605111     0.584469     0.603519

---
                          mean        sd   cv_1_valid   cv_2_valid   cv_3_valid   cv_4_valid   cv_5_valid
precision             0.551504  0.010309     0.553925     0.551382     0.560176     0.534107     0.557932
r2                    0.113626  0.005432     0.116163     0.109293     0.121164     0.107631     0.113879
recall                0.906621  0.018716     0.899930     0.907239     0.891000     0.938404     0.896532
residual_deviance 39734.610000 51.183140 39691.350000 39804.520000 39752.887000 39746.620000 39677.670000
rmse                  0.470729  0.001441     0.470060     0.471877     0.468730     0.472324     0.470654
specificity           0.259019  0.043201     0.280759     0.252410     0.296924     0.187193     0.277810