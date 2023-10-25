
# Results

## Cross-sectional comparative results

Should probably discuss why dimensionality reduction prior to RFs.

https://stats.stackexchange.com/questions/258938/pca-before-random-forest-regression-provide-better-predictive-scores-for-my-data

To compare performance between package-specific structural IDPs and their
combination, we construct corresponding predictive random forest (RF) models
with IDP selection based on mRMR dimensionality reduction.  These supervised
models are constructed using the frequently studied demographic variables of
age, fluid intelligence, and neuroticism score (see [@Dadi:2021wb] for a through
evaluation of population modeling in UK Biobank using these variables). For mRMR
subset selection, we use 10,000 training data from the first image assessment
visit (of the ~40,000 total complete and shared subjects).  Ensembles of size
100 IDPs (to mimic the order of the original IDP size for each of the three
packages) from each set of package-specific IDPs, as well as their combination
were used to generate the top 100 features for each grouping, referred to as
"FSL", "FreeSurfer", "ANTSX", and "All".  I.e., the 166 FSL IDPs were trimmed to
100 mRMR-optimized FSL IDPs, the 301 FreeSurfer IDPs were trimmed to 100
mRMR-optimized FreeSurfer IDPs, the 254 ANTsX IDPs were trimmed to 100
mRMR-optimized ANTsX IDPs, and the 721 total (FSL + FreeSurfer + ANTsX) IDPs
were trimmed to 100 mRMR-optimized All IDPs. The top 25 mRMR All IDPs for each
of the three target variables (i.e., age, fluid intelligence score, and
neuroticism score) are found Tables \ref{table:mrmrFeaturesAge},
\ref{table:mrmrFeaturesFluidIntelligence}, and
\ref{table:mrmrFeaturesNeuroticism}, respectively.  Note that the other feature
tables are provided as supplementary material in the GitHub repository
associated with this work.

Following mRMR IDP selection, we used the remaining ~30,000 data to create and
test the predictive capabilities of separate RF models for each target variable
over the sets of IDP combinations. To obtain a distribution of performance
values, 100 permutations involving randomly selected batches of 5000 data were
used to generate RF models which were then used to predict from the remaining
~25000 subjects.  The root mean-square error (RMSE) was calculated for each
permutation for comparative evaluation.


* Supervised dimensionality reduction or feature subset selection via mRMR
    * Target variables [@Dadi:2021wb]
        * Age
        * Fluid intelligence score
        * Neuroticism score
    * mRMR IDP selection
        * 10,000 training data (of ~40,000 total shared and complete subjects)
        * 100 ensembles --- select top 100 by absolute value of ``importance'' score
        * Models
            * 166 FSL IDPs ---> mRMR ---> 100 IDPs$_{FSL,mRMR}$
            * 301 FreeSurfer IDPs ---> mRMR ---> 100 IDPs$_{FreeSurfer,mRMR}$
            * 254 ANTsX IDPs ---> mRMR ---> 100 IDPs$_{ANTsX,mRMR}$
            * 166 + 301 + 254 = 721 All IDps ---> mRMR ---> 100 IDPs$_{All,mRMR}$
            * Tables 1, 2, 3 for "All" in manuscript.
            * Other mRMR feature tables available in GitHub repo.
    * Random forest model construction
        * Use remaining ~30,000 data
        * 100 permutations for each model/target variable with random selection of 5000 subjects per permutation
        * Compare models
            * \{Age, Fluid intelligence score, Neuroticism score\} $\sim$ IDPs$_{FSL,mRMR}$.
            * \{Age, Fluid intelligence score, Neuroticism score\} $\sim$ IDPs$_{FreeSurfer,mRMR}$.
            * \{Age, Fluid intelligence score, Neuroticism score\} $\sim$ IDPs$_{ANTsX,mRMR}$.
            * \{Age, Fluid intelligence score, Neuroticism score\} $\sim$ IDPs$_{All,mRMR}$.
* Findings
    * "All" outperforms package-specific models for both Age and Fluid Intelligence (Neuroticism trending in the same direction)
    * ANTsX DeepFLASH features
        * left aLEC (All, Neuroticism)
        * right perirhinal (All, Neuroticism)
        * left/right subiculum (ANTsX, Fluid intelligence)
        * left/right DG/CA2/CA3/CA4 (ANTsX, Fluid intelligence)
        * left MTL (ANTsX, Fluid intelligence)


\begin{table}[!htb]
  \centering
  \begin{tabular*}{0.9\textwidth}{@{\extracolsep{\fill}}ccr}
    {\bf Source} & {\bf Structural IDP} & \multicolumn{1}{c}{\bf |Importance|} \\
    \hline\hline
    ANTsX & Mean thickness transverse temporal (right) & 0.65 \\
    ANTsX & Mean thickness transverse temporal (left) & 0.64 \\
    ANTsX & Mean thickness pars opercularis (left) & 0.64 \\
    ANTsX & Mean thickness pars opercularis (right) & 0.64 \\
    FSL & Continuous volume of GM$^\dagger$ & 0.62 \\
    FSL & Continuous volume of peripheral cortical GM$^\dagger$ & 0.61 \\
    ANTsX & Mean thickness of pars triangularis (left) & 0.59 \\
    FSL & Continuous volume of brain = GM + WM$^\dagger$ & 0.58 \\
    ANTsX & Mean thickness of middle temporal (left) & 0.58 \\
    ANTsX & Mean thickness of pars triangularis (right) & 0.59 \\
    ANTsX & Mean thickness of middle temporal (right) & 0.57 \\
    ANTsX & Mean thickness of superior temporal (right) & 0.56 \\
    ANTsX & Mean thickness of medial orbitofrontal (left) & 0.56 \\
    ANTsX & Mean thickness of superior temporal (left) & 0.55 \\
    ANTsX & Volume of precentral (left) &  0.54 \\
    ANTsX & Mean thickness of pars orbitalis (right) & 0.53 \\
    ANTsX & Volume of transverse temporal (right) & 0.53 \\
    ANTsX & Mean thickness of lateral orbitofrontal (left) & 0.52 \\
    ANTsX & Mean thickness of fusiform (left) & 0.50 \\
    ANTsX & Volume of precentral (right) & 0.50 \\
    ANTsX & Mean thickness of parsorbitalis (left) & 0.50 \\
    ANTsX & Mean thickness of rostral anterior cingulate (left) & 0.49 \\
    ANTsX & Mean thickness of fusiform (right) & 0.49 \\
    ANTsX & Mean thickness of medial orbitofrontal (right) & 0.49 \\
    FSL & Continuous volume of ventricular CSF$^\dagger$ & 0.48 \\
    \hline\hline
  \end{tabular*}
  \caption{{\bf Age-supervised mRMR features}.  Top 25 (of 100)
           mRMR-selected features ranked based on "relevancy"
           from the combined set of features.
           `$\dagger$' denotes ``normalised for head size.''}
  \label{table:mrmrFeaturesAge}
\end{table}

\begin{table}[!htb]
  \centering
  \begin{tabular*}{0.9\textwidth}{@{\extracolsep{\fill}}ccr}
    {\bf Source} & {\bf Structural IDP} & \multicolumn{1}{c}{\bf |Importance|} \\
    \hline\hline
    FreeSurfer & Volume of whole hippocampal body (left) & 0.14 \\
    FSL & Volume of GM in anterior temporal fusiform (left) & 0.14 \\
    FSL & Volume of GM in anterior superior temporal (left) & 0.13 \\
    FSL & Volume of GM in anterior superior temporal (right) & 0.13 \\
    FSL & Volume of GM in posterior superior temporal (left) & 0.13 \\
    FreeSurfer & Volume of LGN (left) & 0.13 \\
    ANTsX & Volume of left pars orbitalis (left) & 0.12 \\
    FSL & Volume of GM in inferior lateral cccipital (left) & 0.12 \\
    FSL & Volume of accumbens (right) & 0.11 \\
    FSL & Volume of GM in Crus II cerebellum (right) & 0.11 \\
    FreeSurfer & Volume of Pc (right) & 0.11 \\
    FreeSurfer & Volume of transverse temporal (left) & 0.11 \\
    FSL & Volume of GM in X cerebellum (right) & 0.10 \\
    FreeSurfer & Volume of CA1-body (right) & 0.10 \\
    ANTsX & Volume of pars orbitalis (left) & 0.10 \\
    FreeSurfer & Volume of central-nucleus (left) & 0.10 \\
    ANTsX & Volume of pars orbitalis (right) & 0.10 \\
    FSL & Volume of GM in angular gyrus (right) & 0.10 \\
    FSL & Volume of GM in frontal medial (right) &  0.10 \\
    ANTsX & Volume of pars triangularis (right) &  0.10 \\
    ANTsX & Volume of pars opercularis (left) &  0.10 \\
    FSL & Volume of GM in angular gyrus (left) &  0.10 \\
    FSL & Volume of GM in juxtapositional lobule (right) &  0.10 \\
    FSL & Volume of hippocampus (left) &  0.10 \\
    FreeSurfer & Volume of parahippocampal (left) & 0.10 \\
    \hline\hline
  \end{tabular*}
  \caption{{\bf Fluid intelligence-supervised mRMR features.}
           Top 25 (of 100) mRMR-selected features ranked based on "relevancy"
           from the combined set of features.}
  \label{table:mrmrFeaturesFluidIntelligence}
\end{table}


\begin{table}[!htb]
  \centering
  \begin{tabular*}{0.9\textwidth}{@{\extracolsep{\fill}}ccr}
    {\bf Source} & {\bf Structural IDP} & \multicolumn{1}{c}{\bf |Importance|} \\
    \hline\hline
    FSL & Continuous volume of GM$^\dagger$ & 0.10 \\
    ANTsX & Mean thickness of pericalcarine (left) & 0.09 \\
    FreeSurfer & Volume of Inf-Lat-Vent (right) & 0.09 \\
    FreeSurfer & Volume of L-Sg (right) & 0.08 \\
    ANTsX & Volume of lingual (right) & 0.07 \\
    FreeSurfer & Volume of hippocampal-fissure (right) & 0.07 \\
    ANTsX & Volume of cerebellar vermal lobules VI VII & 0.07 \\
    ANTsX & Volume of anterolateral enthorhinal (left) & 0.07 \\
    FSL & Volume of GM in inferior temporal (left) & 0.07 \\
    FreeSurfer & Volume of optic-chiasm & 0.07 \\
    FreeSurfer & Volume of 4th-Ventricle  & 0.06 \\
    FreeSurfer & Volume of hippocampal-fissure (left) & 0.06 \\
    FreeSurfer & Volume of CL (left) & 0.06 \\
    FSL & Volume of amygdala (left) & 0.06 \\
    ANTsX & Volume of CSF & 0.06 \\
    ANTsX & Volume of pericalcarine (right) & 0.05 \\
    FreeSurfer & Volume of SCP & 0.05 \\
    ANTsX & Volume of pars orbitalis (left) & 0.05 \\
    ANTsX & Volume of pars orbitalis (right) & 0.05 \\
    ANTsX & Volume of pericalcarine (left) & 0.05 \\
    ANTsX & Mean thickness of caudal anterior cingulate (right) & 0.05 \\
    FreeSurfer & Volume of CC-Posterior & 0.05 \\
    FSL & Volume of amygdala (right) & 0.05 \\
    FreeSurfer & Volume-ratio of BrainSegVol-to-eTIV & 0.05 \\
    ANTsX & perirhinal (right) & 0.05 \\
    \hline\hline
  \end{tabular*}
  \caption{{\bf Neuroticism-supervised mRMR features.}
           Top 25 (of 100) mRMR-selected features ranked based on "relevancy"
           from the combined set of features.`$\dagger$' denotes ``normalised for head size.''}
  \label{table:mrmrFeaturesNeuroticism}
\end{table}






\begin{figure}[!htb]
  \centering
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_rf_Age.pdf}
      \caption{Age RMSE.}
      \label{fig:none_age_rmse}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_rf_AgeAOV.pdf}
      \caption{Age Tukey HSD.}
      \label{fig:none_age_aov}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_rf_FluidIntelligenceScore.pdf}
      \caption{Fluid intelligence RMSE.}
      \label{fig:none_fluid_rmse}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_rf_FluidIntelligenceScoreAOV.pdf}
      \caption{Fluid intelligence Tukey HSD.}
      \label{fig:none_fluid_aov}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_rf_NeuroticismScore.pdf}
      \caption{Neuroticism RMSE.}
      \label{fig:none_neuro_rmse}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_rf_NeuroticismScoreAOV.pdf}
      \caption{Neuroticism Tukey HSD.}
      \label{fig:none_neuro_aov}
    \end{subfigure}
   \caption{No dimensionality reduction.  RMSE and Tukey HSD plots for all four classes
            of random forest models (FSL,
            FreeSurfer, ANTsX, and ``All'') using age, fluid intelligence score, and
            neuroticism score as the set of supervising features.  For both age and
            fluid intelligence score, the combined set of features (i.e. ``All'')
            improves the predictive abilities of the set of structural IDPs over each
            of the corresponding package-specific models.  This trend is also seen
            for the neuroticism score.
            }
 \label{fig:none_rf}
\end{figure}

\begin{figure}[!htb]
  \centering
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_rf_Age.pdf}
      \caption{Age RMSE.}
      \label{fig:mrmr_age_rmse}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_rf_AgeAOV.pdf}
      \caption{Age Tukey HSD.}
      \label{fig:mrmr_age_aov}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_rf_FluidIntelligenceScore.pdf}
      \caption{Fluid intelligence RMSE.}
      \label{fig:mrmr_fluid_rmse}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_rf_FluidIntelligenceScoreAOV.pdf}
      \caption{Fluid intelligence Tukey HSD.}
      \label{fig:mrmr_fluid_aov}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_rf_NeuroticismScore.pdf}
      \caption{Neuroticism RMSE.}
      \label{fig:mrmr_neuro_rmse}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_rf_NeuroticismScoreAOV.pdf}
      \caption{Neuroticism Tukey HSD.}
      \label{fig:mrmr_neuro_aov}
    \end{subfigure}
   \caption{mRMR-derived RMSE and Tukey HSD plots for all four classes of random forest models (FSL,
            FreeSurfer, ANTsX, and ``All'') using age, fluid intelligence score, and
            neuroticism score as the set of supervising features.  For both age and
            fluid intelligence score, the combined set of features (i.e. ``All'')
            improves the predictive abilities of the set of structural IDPs over each
            of the corresponding package-specific models.  This trend is also seen
            for the neuroticism score.
            }
 \label{fig:mrmr_rf}
\end{figure}

\begin{figure}[!htb]
  \centering
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_rf_Age.pdf}
      \caption{Age RMSE.}
      \label{fig:pca_age_rmse}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_rf_AgeAOV.pdf}
      \caption{Age Tukey HSD.}
      \label{fig:pca_age_aov}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_rf_FluidIntelligenceScore.pdf}
      \caption{Fluid intelligence RMSE.}
      \label{fig:pca_fluid_rmse}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_rf_FluidIntelligenceScoreAOV.pdf}
      \caption{Fluid intelligence Tukey HSD.}
      \label{fig:pca_fluid_aov}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_rf_NeuroticismScore.pdf}
      \caption{Neuroticism RMSE.}
      \label{fig:pca_neuro_rmse}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_rf_NeuroticismScoreAOV.pdf}
      \caption{Neuroticism Tukey HSD.}
      \label{fig:pca_neuro_aov}
    \end{subfigure}
   \caption{PCA-derived RMSE and Tukey HSD plots for all four classes of random forest models (FSL,
            FreeSurfer, ANTsX, and ``All'') using age, fluid intelligence score, and
            neuroticism score as the set of supervising features.  For both age and
            fluid intelligence score, the combined set of features (i.e. ``All'')
            improves the predictive abilities of the set of structural IDPs over each
            of the corresponding package-specific models.  This trend is also seen
            for the neuroticism score.
            }
 \label{fig:pca_rf}
\end{figure}

\begin{figure}[!htb]
  \centering
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_xgb_Age.pdf}
      \caption{Age RMSE.}
      \label{fig:none_age_rmse_xgb}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_xgb_AgeAOV.pdf}
      \caption{Age Tukey HSD.}
      \label{fig:none_age_aov_xgb}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_xgb_FluidIntelligenceScore.pdf}
      \caption{Fluid intelligence RMSE.}
      \label{fig:none_fluid_rmse_xgb}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_xgb_FluidIntelligenceScoreAOV.pdf}
      \caption{Fluid intelligence Tukey HSD.}
      \label{fig:none_fluid_aov_xgb}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_xgb_NeuroticismScore.pdf}
      \caption{Neuroticism RMSE.}
      \label{fig:none_neuro_rmse_xgb}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/none_xgb_NeuroticismScoreAOV.pdf}
      \caption{Neuroticism Tukey HSD.}
      \label{fig:none_neuro_aov_xgb}
    \end{subfigure}
   \caption{No dimensionality reduction.  RMSE and Tukey HSD plots for all four classes
            of xgboost models (FSL,
            FreeSurfer, ANTsX, and ``All'') using age, fluid intelligence score, and
            neuroticism score as the set of supervising features.  For both age and
            fluid intelligence score, the combined set of features (i.e. ``All'')
            improves the predictive abilities of the set of structural IDPs over each
            of the corresponding package-specific models.  This trend is also seen
            for the neuroticism score.
            }
 \label{fig:none_xgb}
\end{figure}

\begin{figure}[!htb]
  \centering
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_xgb_Age.pdf}
      \caption{Age RMSE.}
      \label{fig:mrmr_age_rmse_xgb}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_xgb_AgeAOV.pdf}
      \caption{Age Tukey HSD.}
      \label{fig:mrmr_age_aov_xgb}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_xgb_FluidIntelligenceScore.pdf}
      \caption{Fluid intelligence RMSE.}
      \label{fig:mrmr_fluid_rmse_xgb}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_xgb_FluidIntelligenceScoreAOV.pdf}
      \caption{Fluid intelligence Tukey HSD.}
      \label{fig:mrmr_fluid_aov_xgb}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_xgb_NeuroticismScore.pdf}
      \caption{Neuroticism RMSE.}
      \label{fig:mrmr_neuro_rmse_xgb}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/mrmr_xgb_NeuroticismScoreAOV.pdf}
      \caption{Neuroticism Tukey HSD.}
      \label{fig:mrmr_neuro_aov_xgb}
    \end{subfigure}
   \caption{mRMR-derived RMSE and Tukey HSD plots for all four classes of xgboost models (FSL,
            FreeSurfer, ANTsX, and ``All'') using age, fluid intelligence score, and
            neuroticism score as the set of supervising features.  For both age and
            fluid intelligence score, the combined set of features (i.e. ``All'')
            improves the predictive abilities of the set of structural IDPs over each
            of the corresponding package-specific models.  This trend is also seen
            for the neuroticism score.
            }
 \label{fig:mrmr_xgb}
\end{figure}

\begin{figure}[!htb]
  \centering
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_xgb_Age.pdf}
      \caption{Age RMSE.}
      \label{fig:pca_age_rmse_xgb}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_xgb_AgeAOV.pdf}
      \caption{Age Tukey HSD.}
      \label{fig:pca_age_aov_xgb}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_xgb_FluidIntelligenceScore.pdf}
      \caption{Fluid intelligence RMSE.}
      \label{fig:pca_fluid_rmse_xgb}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_xgb_FluidIntelligenceScoreAOV.pdf}
      \caption{Fluid intelligence Tukey HSD.}
      \label{fig:pca_fluid_aov_xgb}
    \end{subfigure}
  \medskip
    \begin{subfigure}{0.33\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_xgb_NeuroticismScore.pdf}
      \caption{Neuroticism RMSE.}
      \label{fig:pca_neuro_rmse_xgb}
    \end{subfigure}
    \begin{subfigure}{0.6\textwidth}
      \includegraphics[width=\textwidth]{./Figures/pca_xgb_NeuroticismScoreAOV.pdf}
      \caption{Neuroticism Tukey HSD.}
      \label{fig:pca_neuro_aov_xgb}
    \end{subfigure}
   \caption{PCA-derived RMSE and Tukey HSD plots for all four classes of xgboost models (FSL,
            FreeSurfer, ANTsX, and ``All'') using age, fluid intelligence score, and
            neuroticism score as the set of supervising features.  For both age and
            fluid intelligence score, the combined set of features (i.e. ``All'')
            improves the predictive abilities of the set of structural IDPs over each
            of the corresponding package-specific models.  This trend is also seen
            for the neuroticism score.
            }
 \label{fig:pca_xgb}
\end{figure}



\clearpage
