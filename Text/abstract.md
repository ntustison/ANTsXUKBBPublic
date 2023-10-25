
# Abstract {-}

UK Biobank is a large-scale epidemiological resource for investigating
prospective correlations between various lifestyle, environmental, and genetic
factors with health and disease progression. In addition to individual subject
information obtained through surveys and physical examinations, a comprehensive
neuroimaging battery consisting of multiple modalities provides imaging-derived
phenotypes (IDPs) that can serve as biomarkers in neuroscience research. In this
study, we augment the existing set of UK Biobank neuroimaging structural IDPs,
obtained from well-established software libraries such as FSL and FreeSurfer,
with related measurements acquired through the Advanced Normalization Tools
Ecosystem. This includes previously established cortical and subcortical
measurements defined, in part, based on the Desikan-Killiany-Tourville atlas.
Also included are morphological measurements from two recent developments:
medial temporal lobe parcellation of hippocampal and extra-hippocampal regions
in addition to cerebellum parcellation and thickness based on the Schmahmann
anatomical labeling. Through predictive modeling, we assess the clinical utility
of these IDP measurements, individually and in combination, using commonly
studied phenotypic correlates including age, fluid intelligence, numeric memory,
and several other sociodemographic variables.  The predictive accuracy of these
IDP-based models, in terms of root-mean-squared-error or area-under-the-curve
for continuous and categorical variables, respectively, provides comparative
insights between software libraries as well as potential clinical
interpretability.  Results demonstrate varied performance between package-based
IDP sets and their combination, emphasizing the need for careful consideration
in their selection and utilization.

<!-- __Keywords:__  Cerebellum, DeepFLASH, FreeSurfer, FSL, No Free Lunch Theorem,
open science, TabNet, XGBoost -->

\clearpage