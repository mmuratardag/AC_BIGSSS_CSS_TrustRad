# BIGSSS Computational Social Science Summer School
## Trust Radius Group

Common foreign repo for the project work

Team members are

[Dr. Wahideh Achbari](https://wachbari.github.io/)
[Martin Gestefeld](https://www.jacobs-university.de/directory/gestefeld)
[Carina Hartz](https://www.bigsss-bremen.de/about/diversity-equal-opportunities/carina-carolyn-hartz)
[Philip Warncke](https://politicalscience.unc.edu/staff/philip-warncke/)

### Summary:

to be updated ...

#### Research question:

To what extent can Generalized Trust be predicted by prejudice?
Can we cross-validate the findings with data that have less information on implicit prejudice and intergroup attitudes?
Method:
Supervised Machine Learning Ensembles

#### Data:
Project Implicit | World Values Survey | European Social Survey | LISS Panel | …

Description:
Generalized (social) trust (hereafter GT) or trust in “most people” is a conspicuous indicator in social survey research on intergroup relations and social cohesion. The survey question is as follows: “would you say that most people can be trusted, or would you be careful in dealing with them?” Recent meta-analyses show that researchers often assume GT taps into an evaluation of the trustworthiness of unknown people or even ethnic out-groups. While this prior research has debated the negative link between ethnic diversity and GT as a proxy for social cohesion, with some notable exceptions, relatively few have so far focused on systematic response bias in answers to GT. These mixed findings may well be due to the operationalization of social cohesion by GT. For example, a study using think-aloud protocols have demonstrated that the majority of respondents high in GT think “most people” refers to people they know, whereas a high proportion of those who are low in GT think about strangers. Following the homophily principle – the tendency of individuals to associate and bond with similar others – we can expect that people known to the respondents are ethnic in-groups, and strangers are more likely to be ethnic out-groups, although formally we do not know this. A faceless stranger one hypothetically meets for the first time could well be an ethnic in-group in homogenous settings as much as a person known to the respondent (friend, neighbor, family member) can be an ethnic out-group in diverse settings. In this project, we, therefore, return to some of the overlooked basics in this literature: the measurement and conceptualization of GT, which is allegedly in decline by ethnic diversity. The proposed project aims a) to examine the validity of the Generalized Trust (GT) question as a measure of out-group attitudes and implicit race bias in an unprecedentedly broad manner using Supervised Machine Learning Ensembles, and b) to cross-validate the results with 3 existing large-scale social surveys (WVS, ESS, LISS).

By employing Machine Learning, we propose to quantify complexity instead of relying on ex-ante model sparsity and favoring a set of variables of interests over others. Other advantages of ML over conventional statistical analyses are its flexibility to select variables when many potential predictors are available; its ability to model nonlinear relationships; and that there are fewer limits to the number of datasets, observed cases, interactions between variables, and hence modeling strategies. Finally, the results are less tainted by researcher degrees of freedom in preferring a scale or measure over another. Our goal with prediction, however, remains in line with what social science generally attempts to do: to get good out-of-sample predictions and to avoid overfitting. Therefore, we propose to train, validate, and test the model again (holdout) with differently sized random subsamples of the data. In addition, we then cross-validate the results using social surveys that contain a limited set of measures of intergroup attitudes.