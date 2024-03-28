
## Predictive modeling for IDP characterization

Insight into the relationships between neurostructural and phenotypic measures
is often possible through predictive modeling of sociodemographic targets and
neuroimaging biomarkers.  Many strategies for data exploration leverage
standardized quantities derived from existing pipelines, which constitutes a
form of dimensionality reduction or feature extraction based on clinically
established relevance.  Such tabulated data has several advantages over direct
image use including being relatively easier to access, store, and manage.
Analyses with off-the-shelf statistical packages is also greatly simplified.
Additionally, using standardized features in predictive modeling, where feature
importance is a component of the analysis, significantly facilitates the
clinical interpretability of the modeling process.

Herein, baseline models are made using standard linear regression where linear
dependencies between covariates were resolved using ``findLinearCombos`` of the
``caret`` R package [@Kuhn:2008aa].  Although other modeling
approaches were explored (e.g., XGBoost [@Chen:2016aa],
TabNet [@Arik:2021aa]), the linear models
were the top performing models in terms of predictive accuracy so, in the
interest of simplicity, we only discuss those here and refer the interested
reader to the GitHub repository associated with this work for these additional
explorations.  We selected several target variables for our comparative
evaluation (cf. Table \ref{table:targets}) and generated models of the form:

\begin{align}
\label{eq:compare_predict}
Target \sim Age + Genetic\,\,Sex + \sum_{i=1}^N IDP_i
\end{align}

where _i_ indexes over the set of _N_ IDPs for a particular grouping.
In the cases where _Age_ or _Genetic Sex_ is the target variable, it is
omitted from the right side of the modeling equation.


<!--
Much more generally, this is a current topic of interest for the larger machine
learning community [@Shwartz-Ziv:2022aa;@Kadra:2021aa;@Gorishniy:2021aa].  As a
final baseline comparison, we used a basic dense neural network (DenseNet)
consisting of two hidden layers with 512 units in the first layer and 256 units
in the second layer using leaky ReLU activation where the output layer employed
linear activation for regression and sigmoid/softmax for binary/multi
classification.
-->

\begin{table}
  \caption{Set of UKBB sociodemographic targets for evaluation.}
  \label{table:targets}
  \center
  \begin{tabular*}{0.95\textwidth}{c @{\extracolsep{\fill}} cc}
  {\bf Target} & {\bf Data ID} & {\bf Brief Description} \\
  \hline
  Age & 21003-2.0 & Age (years) at imaging visit \\
  Fluid intelligence score & 20191-0.0 & Number of correct answers (of 13) \\
  Neuroticism score & 20127-0.0 & Summary of 12 behaviour domains \\
  Numeric memory & 20240-0.0 & Maximum digits remembered correctly \\
  Body mass index & 21001-2.0 & Impedance-based body composition \\
  Townsend deprivation index & 189-0.0 & Material deprivation measure \\
  Genetic sex & 22001-0.0 & Sex from genotyping \\
  Hearing difficulty & 2247-2.0 & Any difficulty?  Yes/No \\
  Risk taking & 2040-2.0 & Do you take risks?  Yes/No \\
  Same sex intercourse & 2159-2.0 & Ever had?  Yes/No \\
  Smoking & 1249-2.0 & Daily, occasionally, or $\leq 2$ times? \\
  Alcohol & 1558-2.0 & Six frequency categories$^\dagger$ \\
  \hline
  \multicolumn{3}{l}
  {\footnotesize
  $\dagger$:  Daily, 3-4 times/week, 1-2 times/week, 1-3 times/month, special occasions only, and never.}
  \end{tabular*}
\end{table}


Assessment of the models based on the three individual sets of IDPs and
their combination employs standard quality measures: area under the
curve (AUC) for classification targets and root-mean-square error (RMSE) for
regression targets.  We also explored individual IDP importance through the use
of model-specific parameter assessment metrics (i.e.., the absolute value of the
t-statistic).




<!--
Herein, we compare predictive modeling frameworks using tabular data. Baseline
comparisons include standard linear regression where linear dependencies between
covariates were resolved using ``findLinearCombos`` of the ``caret`` R package
[@Kuhn:2008aa].  Although the number of observations relative to the number
of covariates for the specified models is sufficiently large, given the constraints
of traditionally-sized data sets, we also compared results based on sparse
linear regression, specifically, the Lasso method as found in the ``glmnet`` R
package [@Friedman:2010aa], using recommended parameters.

We also evaluated two popular packages for use with tabular data, viz.
XGBoost [@Chen:2016aa] and TabNet [@Arik:2021aa].  The former is a popular
implementation of gradient boosted decision trees known for superb performance
and computational efficiency.  Similar to random forests [@Breiman:2001aa],
gradient boosted decision trees leverage ensembles of weak classifiers (i.e.,
individual decision trees) to enhance model accuracy.  However, in contrast to
random forests, which generate weak classifiers using random initialization,
gradient boosted decision trees are constructed in stages based on the gradient
of a specified cost function [@Friedman:2001aa].  The following common
hyperparameters were used: maximum tree depth = 6, number of rounds = 1000
(with early stopping after 10 rounds of no improvement), squared error as the
loss function for regression targets, and logistic and softmax losses for binary
and multi-label classification problems, respectively.

TabNet is a deep learning framework specifically engineered for structured
tabulated data which incorporates sparsity considerations as well as providing
feature importance for interpretability.  We used an established PyTorch
implementation of TabNet [@tabnet] with the default parameters which is reported
to demonstrate good performance on a variety of predictive problem types.  While
deep learning methods have proven both highly popular and effective within
neuroimaging research, much of this work has been restricted to convolutional
neural networks for image-based analyses, as opposed to parallel research with
tabular data, hence the motivation for the development of TabNet.  Much more
generally, this is a current topic of interest for the larger machine learning
community [@Shwartz-Ziv:2022aa;@Kadra:2021aa;@Gorishniy:2021aa].  As a final baseline
comparison, we used a basic dense neural network (DenseNet) consisting of two
hidden layers with 512 units in the first layer and 256 units in the second
layer using leaky ReLU activation where the output layer employed linear
activation for regression and sigmoid/softmax for binary/multi classification.

\begin{table}
  \caption{Set of UKBB sociodemographic targets for evaluation.}
  \label{table:targets}
  \center
  \begin{tabular*}{0.95\textwidth}{c @{\extracolsep{\fill}} cc}
  {\bf Target} & {\bf Data ID} & {\bf Brief Description} \\
  \hline
  Age & 21003-2.0 & Age (years) at imaging visit \\
  Fluid intelligence score & 20191-0.0 & Number of correct answers (of 13) \\
  Neuroticism score & 20127-0.0 & Summary of 12 behaviour domains \\
  Numeric memory & 20240-0.0 & Maximum digits remembered correctly \\
  Body mass index & 21001-2.0 & Impedance-based body composition \\
  Townsend deprivation index & 189-0.0 & Material deprivation measure \\
  Genetic sex & 22001-0.0 & Sex from genotyping \\
  Hearing difficulty & 2247-2.0 & Any difficulty?  Yes/No \\
  Risk taking & 2040-2.0 & Do you take risks?  Yes/No \\
  Same sex intercourse & 2159-2.0 & Ever had?  Yes/No \\
  Smoking & 1249-2.0 & Daily, occasionally, or $\leq 2$ times? \\
  Alcohol & 1558-2.0 & Six frequency categories$^\dagger$ \\
  \hline
  \multicolumn{3}{l}
  {\footnotesize
  $\dagger$:  Daily, 3-4 times/week, 1-2 times/week, 1-3 times/month, special occasions only, and never.}
  \end{tabular*}
\end{table}

For each of these predictive modeling frameworks, we selected several target
variables for our comparative evaluation (cf. Table \ref{table:targets}) and
generated models of the form:

\begin{align}
\label{eq:compare_predict}
Target \sim Age + Genetic\,\,Sex + \sum_{i=1}^N IDP_i
\end{align}

where _i_ indexes over the set of _N_ IDPs for a particular grouping.
In the cases where _Age_ or _Genetic Sex_ is the target variable, it is
omitted from the right side of the modeling equation.

Assessment of the model groups based on the three individual sets of IDPs and
their combination employs standard quality measures: area under the
curve (AUC) for classification targets and root-mean-square error (RMSE) for
regression targets.  We also explored individual IDP importance through the use
of model-specific parameter assessment metrics such as the absolute value of the
t-statistic for linear models and SHAP values [@Lundberg:2017aa] for neural networks.
-->

<!--
### Minimal redundancy maximal relevance

Despite the differences between the sets of IDPs of the respective packages,
various methods can be used for comparative evaluation and characterization.
Using various supervised and unsupervised dimensionality reduction techniques
(e.g., principal component analysis, linear discriminant analysis
[@Martinez:2001aa]), new variables are defined in terms of linear combinations
of the original variables in a transformed, reduced dimensionality space from
the original space. Although useful for many applications, such transformations
complicate clinical and technical interpretability on the granularity of
individual measurements in the transformed space.

In contrast, feature selection techniques use various criteria for
dimensionality reduction by selecting an "optimal" feature subset.  These
techniques are generally categorized as filter, wrapper, and embedded methods
[@Tang:2014aa].  Filter methods, characterized by independence of modeling
choices, employ proxy measures, such as mutual information or correlation, to
determine an optimal subset of features.  One such popular filter technique is
the minimal redundancy maximal relevance (mRMR) algorithm proposed in
[@Peng:2005ta]. mRMR combines the intuition of selecting a set of features which
have maximal relevance to a specific target measurement, $c$, with the
simultaneous criteria of minimizing the mutual redundancy between such features.
Formally, this involves determining the optimal set of features, $S$, which
traditionally maximizes the following mutual information, $I$, difference:
\begin{equation}
  \sum_{x_i \in S} I(x_i;c) - \frac{1}{|S|} \sum_{x_i,x_j \in S} I(x_i;x_j).
\end{equation}
Given that feature selection is NP-hard [@Welch:1982aa], the mRMR criterion is
maximized using a greedy, first order approximation [@Peng:2005ta]. Following
selection of the maximally relevant feature, subsequent selection of features
occurs which simultaneously maximize relevance with the target while minimizing
the redundancy with those features already selected. For our study, we used the
mRMRe R package [@De-Jay:2013uw] which uses a mutual information approximation
based on Pearson's correlation, $\rho$:
\begin{equation}
  I(x_i, x_j) = \frac{1}{2} \ln\left(1 - \rho(x_i,x_j)^2\right)
\end{equation}
which permits tractable generation of an ensemble of optimal feature sets
(versus a single optimal set as in the classical approach).
 -->
