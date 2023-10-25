
# Discussion

Much UKBB research is made possible through the availability of its
characteristic large-scale, subject-specific epidemiological data, including
IDPs and enhanced by the stringent data acquisition protocols to ensure
consistency across sites. In this work, we complement the existing FSL- and
FreeSurfer-based UKBB IDPs with the generation and potential distribution of
corresponding ANTsX-derived IDPs. These latter IDPs were generated from
well-vetted pipelines that have been used in previous research and are publicly
available through the ANTsX ecosystem.  By providing these IDP-producing
utilities within high-level languages, such as Python and R, in a comprehensive,
open-source package, we are able to leverage the computational efficiency of
deep learning libraries while also leveraging the numerous packages available
for the curation, analysis, and visualization of tabulated data.

In addition to the availability of these ANTsX UKBB IDPs, we explored their
utility with respect to other package-specific groupings and their combinations.
For exploration of these IDP group permutations, we used popular machine
learning algorithms to predict commonly studied sociodemographic variables of
current research interest (Table \ref{table:targets}).  In addition to research
presentation in traditional venues, at least two of these target variables,
specifically *Age* and *Fluid Intelligence*,  have been the focus of two recent
competitions.

Regarding the former, research concerning brain age estimation from neuroimaging
is extensive and growing (cf. recent reviews
[@Franke:2019aa;@Mishra:2021aa;@Baecker:2021aa]).  It was also the subject of
the recent Predictive Analytics Competition held in 2019 (PAC2019).  This
competition featured 79 teams leveraging T1-weighted MRI with a variety of
quantitative approaches from convolutional neural networks (CNNs) to common
machine learning frameworks based on morphological descriptors (i.e., structural
IDPs) derived from FreeSurfer [@Lombardi:2020vj]. The winning team
[@Gong:2021vo], using an ensemble of CNNs and pretrained on a UKBB cohort of
$N=14,503$ subjects, had a mean absolute error (MAE) of 2.90 years. Related
CNN-based deep learning approaches achieved comparable performance levels and
simultaneously outperformed more traditional machine learning approaches.  For
example, the FreeSurfer IDP approach using a dense neural network
[@Lombardi:2020vj] yielded an overall MAE accuracy of 4.6 years. Alternative
strategies based on Lasso, Random Forests, and support vector regression
techniques were attempted but did not achieve similar accuracy levels.

Given that RMSE provides a general upper bound on MAE (i.e., MAE $\leq$ RMSE),
the accuracy levels yielded by our FSL, FreeSurfer, ANTsX, and combined linear,
lasso, and XGBoost models can be seen from Figure
\ref{fig:features_optimization_rmse} to perform comparatively well.  The
FreeSurfer and ANTsX linear models performed similarly with RMSE prediction
values of approximately 4.4 years whereas FSL was a little higher at 4.96 years.
However, combining all IDPs resulted in an average RMSE value of 3.8 years. When
looking at the top 10 overall linear model features (Table
\ref{table:compare-predictions}) ranked in terms of absolute t-statistic value,
all three packages are represented and appear to reflect both global structures
(white matter and CSF volumes) and general subcortical structural volumes (ANTsX
"deep GM" and both FreeSurfer and ANTsX bi-hemispherical ventral dienchephalon
volumes).  Increases in CSF volume and ventricular spaces is well-known to be
associated with brain shrinkage and aging
[@Murphy:1992aa;@Matsumae:1996aa;@Scahill:2003aa].

Similarly, the association between brain structure and fluid intelligence has
been well-studied [@Vieira:2022aa] despite potentially problematic
philosophical and ethical issues [@Eickhoff:2019aa].  With intentions of
furthering this research, the ABCD Neurocognitive Prediction Challenge
(ABCD-NP-Challenge) was held in 2019 which concerned predicting fluid
intelligence scores (using the NIH Toolbox Cognition Battery
[@Weintraub:2013aa]) in a population of 9-10 year pediatric subjects using
T1-weighted MRI. Fluid intelligence scores were residualized from brain volume,
acquisition site, age, ethnicity, genetic sex, and parental attributes of
income, education, and marriage (additional data processing details are provided
in the Data Supplement [@Pfefferbaum:2018aa]).

Of the 29 submitting teams, the first place team of the final leaderboard
employed kernel ridge regression with voxelwise features based on the
T1-weighted-based probabilistic tissue segmentations specifically, CSF, gray
matter, and white matter--- both modulated and unmodulated versions for a total of
six features per subject. In contrast to the winning set of predictive sparse
and global features, the second place team used 332 total cortical, subcortical,
white matter, cerebellar, and CSF volumetric features.  Although exploring
several machine learning modeling techniques, the authors ultimately used an
ensemble of models for prediction which showed improvement over gradient boosted
decision trees.  From Table \ref{table:compare-predictions}, most predictive
features from our study, regardless of package, are localized measures of gray
matter.

Although the stated, primary objective of these competitions is related to
superior performance in terms of algorithmic prediction of quantitative
sociodemographics, similar to the evaluation strategy used in this work, outside
of the clinical research into brain age estimation, none of these performance
metric reach the level of individual-level prediction.
Consequently, these may be more informative as an interpretation of the systems-
level relationship between brain structure and behavior.  An obvious secondary
benefit is the insight gained into the quality and relevance of measurements and
modeling techniques used.  In this way, these considerations touch on
fundamental implications of the No Free Lunch Theorems for search and
optimization [@Wolpert:1997aa] where prior distributions (i.e., correspondence
of measurements and clinical domain for algorithmic modeling) differentiate
general performance.  Relatedly, although all packages are represented amongst
the top-performing IDPs, their relative utility is dependent, expectedly so, on
the specific target variable, and, to a lesser extent, on the chosen machine
learning technique. Such considerations should be made along with other relevant
factors (e.g., computational requirements, open-source availability) for
tailored usage.

