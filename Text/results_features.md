

## Package-wise Group IDP Comparison

To compare the groups of IDPs, we used the three IDP sets (FSL, FreeSurfer,
ANTsX) and their combination ("All") to train predictive models using the
preselected target sociodemographic variables from Table \ref{table:targets}. We
first revisit a previous evaluative framework of ANTsX cortical thickness values
by comparing their ability to predict _Age_ and _Genetic Sex_ with corresponding
FreeSurfer cortical thickness values [@Tustison:2021aa].

Following this initial comparative analysis, ten-fold cross validation, using
random training/evaluation sampling sets (90\% training/10% evaluation), per IDP
set per target variable per machine learning technique (i.e., linear regression,
Lasso, XGBoost, DenseNet, and TabNet) was used to train and evaluate the models
described by Equation (\ref{eq:compare_predict}).

### Revisiting ANTs and FreeSurfer cortical thickness comparison

\begin{figure}[!htb]
  \colorbox{lightgray}{
  \begin{minipage}[c]{0.47\linewidth}
    \centering
      \vspace{1mm}
      \hspace{-3mm}
      \includegraphics[width=0.46\textwidth]{./Figures/cortical_thickness_lm_Age.pdf} \hspace{0.5mm}
      \includegraphics[width=0.46\textwidth]{./Figures/cortical_thickness_lm_GeneticSex.pdf} \\
      {\bf Linear model}
      \vspace{1mm}
  \end{minipage}}\hfill
  \colorbox{lightgray}{
  \begin{minipage}[c]{0.47\linewidth}
    \centering
      \vspace{1mm}
      \hspace{-3mm}
      \includegraphics[width=0.46\textwidth]{./Figures/cortical_thickness_xgb_Age.pdf} \hspace{0.5mm}
      \includegraphics[width=0.46\textwidth]{./Figures/cortical_thickness_xgb_GeneticSex.pdf} \\
      {\bf XGBoost}
      \vspace{1mm}
  \end{minipage}}\hfill
   \caption{(Left) Linear and (right) XGBoost model results for predicting {\em Age} and
             {\em Genetic Sex} using both ANTsX and FreeSurfer cortical thickness data averaged
             over the 62 cortical regions of the DKT parcellation.  RMSE and AUC were used to
             quantify the predictive accuracy of {\em Age} and {\em Genetic Sex}, respectively.}
 \label{fig:ct_evaluation}
\end{figure}

In [@Tustison:2014ab;@Tustison:2021aa], IDPs under consideration were limited to
ANTsX-based and FreeSurfer cortical thickness measurements averaged over the 62
regions of the DKT parcellation.  These IDP sets were specifically compared in
terms of the predictive capability vis-à-vis _Age_ and _Genetic Sex_.  With
respect to UKBB-derived cortical thickness IDPs, similar analysis using both
linear and XGBoost models demonstrates consistency with prior results (see
Figure \ref{fig:ct_evaluation}).


### Package IDP comparison via continuous target variables

\begin{table}
  \caption{Summary statistics for the selected continuous UKBB sociodemographic target variables.}
  \label{table:target_stats}
  \center
  \begin{tabular*}{0.9\textwidth}{c @{\extracolsep{\fill}} cc}
  {\bf Target} & {\bf Mean $\pm$ SD} &  {\bf Range}\\
  \hline
  Age & $63.97 \pm 7.67$ & $[45, 82]$\\
  Fluid intelligence score & $6.63 \pm 2.03$ & $[0, 13]$ \\
  Neuroticism score & $3.81 \pm 3.17$ & $[0, 12]$ \\
  Numeric memory & $7.02 \pm 1.44$ & $[2, 11]$ \\
  Body mass index & $26.47 \pm 4.36$ & $[13.4, 58.0]$ \\
  Townsend deprivation index & $-1.89 \pm 2.73$ & $[-6.26, 10.10]$ \\
  \hline
  \end{tabular*}
\end{table}

\begin{figure}[!htb]
  \centering
  \includegraphics[width=0.99\textwidth]{Figures/compare_predictions_rmse.pdf}
  \caption{Comparison of machine learning frameworks for training and prediction
           of selected continuous UKBB sociodemographic continuous variables
           (cf. Table \ref{table:targets}) with the different IDP sets and their
           combination (FSL, FreeSurfer, ANTsX, and All). }
  \label{fig:features_optimization_rmse}
\end{figure}

\begin{figure}[!htb]
  \centering
  \includegraphics[width=0.9\textwidth]{Figures/none_lm_RegressionRegions.pdf}
  \caption{Regression regions defined by the linear models represented in Figure
           \ref{fig:features_optimization_rmse} showing the relationship between
           the predicted and actual target values. We also plot the median line
           for each model-based grouping as defined by the slope and list the average
           $R^2$ values for each IDP set. }
  \label{fig:none_lm_regression}
\end{figure}

Predictive models for cohort _Age_, _Fluid Intelligence Score_, _Neuroticism
Score_, _Numeric Memory_, _Body Mass Index_, and _Townsend Deprivation Index_
were generated and evaluated as described previously.  Summary statistics for
these variables are provided in Table \ref{table:target_stats}.  The resulting
accuracies, in terms of RMSE, are provided in Figure
\ref{fig:features_optimization_rmse}.

Linear and Lasso models provide the most consistently accurate results across
the set of continuous target variables with the combined set of IDPs performing
well for the majority of cases.   All linear models demonstrate significant
correlations across IDP sets (cf. Figure \ref{fig:none_lm_regression}). Despite
the large number of regressors, sparsity-based constraints did not significantly
improve prediction performance.  The deep learning models (both DenseNet and
TabNet) performed similarly although were only competitive for selected subsets
(e.g., _Neuroticism Score_ and _Townsend Deprivation Index_). Although XGBoost
performed well for the commonly studied _Age_ target variable, performance
measures were relatively much less accurate for the remaining categories.  This
could be the results of suboptimal hyperparameter choice with respect to these
other categories but, as with the other techniques, this was not investigated
further.

### Package IDP comparison via categorical target variables

\begin{figure}[!htb]
  \centering
  \includegraphics[width=0.99\textwidth]{Figures/compare_predictions_auc.pdf}
  \caption{Comparison of machine learning frameworks for training and prediction
           of selected binary and multilabel categorical UKBB sociodemographic
           variables (cf. Table \ref{table:targets}) with the different IDP sets
           and their combination (FSL, FreeSurfer, ANTsX, and All).  {\em Smoking}
           and {\em Alcohol} target variables have more than two labels.}
  \label{fig:features_optimization_auc}
\end{figure}

Predictive models for cohort categories associated with _Genetic Sex_, _Hearing
Difficulty_, _Risk Taking_, _Same Sex Intercourse_, _Smoking Frequency_, and
_Alcohol Frequency_ were generated and evaluated as described previously.  The
resulting accuracies, in terms of binary or multi-class AUC, are provided in
Figure \ref{fig:features_optimization_auc}.

Similar to the continuous variables, the Linear and Lasso models perform well
for most of the target variables.  Superior performance is seen for these models
predicting _Genetic Sex_ along with XGBoost.  DenseNet performs similarly well
as the Linear and Lasso models for _Hearing_, _Risk Taking_, _Same Sex Intercourse_,
and _Alcohol_.  DenseNet models are also superior performers for predicting _Smoking_
categories.

## Individual IDP comparison

<!-- \rowcolor{gray!20} -->


\begin{table}
\caption{Top 10 features for {\em Age}, {\em Fluid Intelligence Score}, and {\em Neuroticism
         Score} target variables specified based on the specific, top-performing
         machine learning techniques for the combined (i.e., All) IDP set.
         }
\label{table:compare-predictions}
\footnotesize
\centering
\begin{tabular}[!htb]{ccc}
\toprule
{\bf Package} & {\bf IDP Subset} & {\bf Individual IDP}\\
\toprule
\multicolumn{3}{c}{\cellcolor{gray!50}{\em Age}}\\
\midrule
\rowcolor{ANTsX!30}
ANTsX & Atropos & Volume of cerebellum\\
\rowcolor{FreeSurfer!30}
FreeSurfer & ASEG & Volume of WM hypointensities (whole brain)\\
\rowcolor{ANTsX!30}
ANTsX & Cereb & Left III volume\\
\rowcolor{FreeSurfer!30}
FreeSurfer & ASEG & Volume of cerebral WM (left)\\
\rowcolor{FreeSurfer!30}
FreeSurfer & ASEG & Volume of cerebral WM (right)\\
\rowcolor{FreeSurfer!30}
FreeSurfer & ASEG & Volume of CC (central)\\
\rowcolor{FreeSurfer!30}
FreeSurfer & ASEG & Volume of supra tentorial\\
\rowcolor{FSL!30}
FSL & Other & Continuous volume of GM\\
\rowcolor{FreeSurfer!30}
FreeSurfer & ASEG & Volume of total GM\\
\rowcolor{FreeSurfer!30}
FreeSurfer & ASEG & Volume of cortex\\

\midrule
\multicolumn{3}{c}{\cellcolor{gray!40}{\em Fluid Intelligence}}\\
\midrule
\rowcolor{FSL!30}
FSL & FAST & Volume of GM in right amygdala\\
\rowcolor{FreeSurfer!30}
FreeSurfer & ASEG & Volume of CC-mid-anterior (whole brain)\\
\rowcolor{ANTsX!30}
ANTsX & Thickness & Thickness of left paracentral\\
\rowcolor{FSL!30}
FSL & FAST & Volume of GM right intracalcarine \\
\rowcolor{FSL!30}
FSL & Other & Continuous volume of peripheral GM \\
\rowcolor{ANTsX!30}
ANTsX & Thickness & Thickness of left superior frontal\\
\rowcolor{FSL!30}
FSL & FAST & Volume of GM left amygdala \\
\rowcolor{ANTsX!30}
ANTsX & Thickness & Thickness of left inferior temporal\\
\rowcolor{FSL!30}
FSL & FAST & Volume of GM middle temporal gyrus (posterior) \\
\rowcolor{ANTsX!30}
ANTsX & DKT & Volume of left hippocampus \\

\midrule
\multicolumn{3}{c}{\cellcolor{gray!40}{\em Neuroticism}}\\
\midrule
\rowcolor{FSL!30}
FSL & FAST & Volume of GM right amygdala\\
\rowcolor{FreeSurfer!30}
FreeSurfer & Thickness & Thickness of right superiotemporal\\
\rowcolor{FreeSurfer!30}
FreeSurfer & Thickness & Thickness of left posterior cingulate\\
\rowcolor{FSL!30}
FSL & Other & Continuous volume of peripheral GM \\
\rowcolor{ANTsX!30}
ANTsX & Thickness & Thickness of left supramarginal\\
\rowcolor{FreeSurfer!30}
FreeSurfer & Thickness & Thickness of right posterior cingulate\\
\rowcolor{FreeSurfer!30}
FreeSurfer & Thickness & Thickness of right isthmus cingulate\\
\rowcolor{ANTsX!30}
ANTsX & Thickness & Thickness of right posterior cingulate\\
\rowcolor{ANTsX!30}
ANTsX & Thickness & Thickness of left lateral orbitofrontal \\
\rowcolor{FreeSurfer!30}
FreeSurfer & HippAmyg & Volume of right AV \\
\bottomrule
\end{tabular}
\end{table}

To compare individual IDPs, for each target variable, we selected the set of
results corresponding to the machine learning technique which demonstrated
superior performance, in terms of median predictive accuracy, for the combined
(All) IDP grouping.  The top ten features for the principle continuous variables
of _Age_, _Fluid Intelligence Score_, and _Neuroticism Score_ are listed in
Table \ref{table:compare-predictions} and ranked according to variable
importance score (specifically, absolute t-statistic value for linear models).
The ranked lists are also color-coded by IDP package.  For additional insight
into individual IDPs, full feature lists with feature importance rankings are
available for all target variables in the supplementary material hosted at the
corresponding GitHub repository [@antsxukbb].

<!-- We also used the ranked feature lists of the All IDP set to compare the
individual package IDP features across targets. For each target, we normalized
the set of importance feature values to $[0, 1]$.  We then summed the set of top
10, 25, and 50 normalized feature importance values for FSL, FreeSurfer, and
ANTsX IDPs thereby giving a summary assessment of the top features for each set.  -->

<!--
\begin{figure}[!htb]
  \centering
  \includegraphics[width=0.95\textwidth]{Figures/compare_predictions_xcountry.pdf}
  \caption{Comparison of the top features of FSL, FreeSurfer, and IDP sets across all
           targets using the sum of normalized importance values across sets of the top
           $\{10, 25, 50\}$ features.
           }
  \label{fig:xcountry}
\end{figure}
-->
