
\clearpage

# Supplementary material {-}

# Deep FLASH IDPs of UKBB  {-}

\begin{figure}[!htb]
  \centering
  \includegraphics[width=0.95\textwidth]{Figures/hippo_parahippo.pdf}
  \caption{A random sample of $n=1000$ UKBB imaging subjects showing the
  cross-sectional age trends of hemispherical hippocampal (top) and
  parahippocampal (bottom) volumes from the three sets of IDPs.  Although
  hippocampal volumes appear to be relatively consistent across FSL, FreeSurfer,
  and ANTs; parahippocampal volumes, in contrast, appear to exhibit systematic
  discrepancies.}
  \label{fig:hippo_parahippo}
\end{figure}

Although earlier versions of DeepFLASH have been evaluated and used in
multiple studies (as previously cited), UKBB provides a unique platform for
evaluating the recently developed deep learning variant that is unique in terms
of available demographics, inter-package IDP definition and availability, as
well as scale.  Such data permits (and necessitates [^3]) alternative evaluation
strategies different from a conventional approaches involving segmentation overlap
measures (e.g., Dice, Hausdorff). For example, the only volumetric IDPs in
common between all three sets are the hippocampus and the parahippocampus (see
Figure \ref{fig:hippo_parahippo}) with there appearing to be much less
discrepancy between the former versus the latter. As mentioned previously, these
differences are not indicative of inaccuracy, per se, but likely more a result
of varying anatomical definitions.

[^3]: Aside from the usual constraints of available gold- or silver-standard
data of sufficient scale for common segmentation voxelwise assessment
strategies, the unavailability of FreeSurfer processed data makes such
comparisons difficult. Although we could, in theory, process the data ourselves
through the corresponding FreeSurfer pipeline (in addition to the previous joint
label fusion version of DeepFLASH), such intensive large-scale processing for
such a limited purpose, where alternative strategies are viable, would be
excessively time consuming and environmentally inconsiderate
[@Lannelongue:2021vr].



To accommodate these issues within the context of UKBB, we first explore how
DeepFLASH hippocampal and parahippocampal volumetric IDPs compare to the
corresponding FSL and FreeSurfer quantities in the context of three principal
demographic variables available in UKBB (i.e., age
[@Echavarri:2011wj;@Bussy:2021uk], fluid intelligence [@Reuben:2011uy], and
neuroticism [@Liu:2021uv]) [@Dadi:2021wb] with appropriate confound modeling
[@Alfaro-Almagro:2021wf]. We then demonstrate their significance with
respect to the unique hierarchical parcellation of DeepFLASH IDPs.

<!-- Specifically, we comparatively model the age/brain structure relationship

\begin{align}
Age \sim Hippocampal + Parahippocampal + Sex + Brain + Site
\end{align}

(e.g, [@Echavarri:2011wj;@Bussy:2021uk]).  In addition, the relationship
between fluid intelligence [@Reuben:2011uy] and neuroticism scores [@Liu:2021uv] are similarly
evaluated

\begin{align}
\{FluidIntelligence, Neuroticism\} \sim & Hippocampal + Parahippocampal + Age \nonumber \\
                                   + & Age^2 + Sex + Age * Sex + Brain + Site
\end{align}

across sets. -->

## Interset IDP evaluation {-}

\begin{table}[!htbp] \centering
  \caption{Brain structural and demographic modeling of hippocampal and parahippocampal
  volumes across IDP sets.  Coefficients (and standard errors) along with statistical
  significance designation for the regressors of interest are provided.}
  \label{table::hippo_parahippo}
\footnotesize
\begin{tabular}{@{\extracolsep{5pt}}lccc}

 & {\bf FSL} & {\bf FreeSurfer} & {\bf DeepFLASH} \\
\hline\hline
\\[-1.8ex]
\multicolumn{4}{c}{\cellcolor{gray!25} $Age \sim Hippocampal + Parahippocampal + Sex + Brain + Site$} \\
\\[-1.8ex]
\hline
\\[-1.8ex]
 Hippocampal & $-$0.002$^{***}$ (0.00005) & $-$0.004$^{***}$ (0.0001) & $-$0.002$^{***}$ (0.0001) \\
  Parahippocampal & $-$0.001$^{***}$ (0.00005) & $-$0.001$^{***}$ (0.0001) & $-$0.001$^{***}$ (0.0001) \\
  Sex & 3.748$^{***}$ (0.088) & 2.908$^{***}$ (0.086) & 3.810$^{***}$ (0.090) \\
  Brain & $-$0.00000$^{***}$ (0.00000) & 0.00001$^{***}$ (0.00000) & $-$0.00001$^{***}$ (0.00000) \\
 \hline \\[-1.8ex]
R$^{2}$ & 0.151 & 0.199 & 0.096 \\
F Statistic & 1,047.043$^{***}$ & 1,463.211$^{***}$ & 624.199$^{***}$ \\
\hline\hline
\\[-1.8ex]
\multicolumn{4}{c}{\cellcolor{gray!25} $FluidIntelligence \sim Hippocampal + Parahippocampal + Age + Age^2 + Sex + Age * Sex + Brain + Site$} \\
\\[-1.8ex]
\hline
\\[-1.8ex]
 Hippocampal & 0.0001$^{***}$ (0.00002) & 0.0001$^{***}$ (0.00003) & 0.0001$^{***}$ (0.00003) \\
  Parahippocampal & 0.00004$^{**}$ (0.00002) & 0.00004 (0.00003) & 0.00001 (0.00002) \\
  Age & $-$0.010$^{***}$ (0.003) & $-$0.010$^{***}$ (0.003) & $-$0.011$^{***}$ (0.003) \\
  Sex & 0.273 (0.231) & 0.311 (0.231) & 0.332 (0.230) \\
  Brain & 0.00000$^{***}$ (0.00000) & 0.00000$^{***}$ (0.00000) & 0.00000$^{***}$ (0.00000) \\
  Age:Sex & $-$0.009$^{**}$ (0.004) & $-$0.009$^{**}$ (0.004) & $-$0.010$^{***}$ (0.004) \\
 \hline \\[-1.8ex]
R$^{2}$ & 0.046 & 0.045 & 0.045 \\
F Statistic & 117.017$^{***}$ & 115.656$^{***}$ & 115.108$^{***}$ \\
\hline\hline
\\[-1.8ex]
\multicolumn{4}{c}{\cellcolor{gray!25} $Neuroticism \sim Hippocampal + Parahippocampal + Age + Age^2 + Sex + Age * Sex + Brain + Site$} \\
\\[-1.8ex]
\hline
\\[-1.8ex]
 Hippocampal & 0.00002 (0.00002) & 0.0001$^{*}$ (0.00003) & 0.0001$^{***}$ (0.00003) \\
  Parahippocampal & $-$0.00005$^{**}$ (0.00002) & 0.00003 (0.00003) & 0.00001 (0.00003) \\
  Age & $-$0.047$^{***}$ (0.003) & $-$0.044$^{***}$ (0.003) & $-$0.045$^{***}$ (0.003) \\
  Sex & $-$0.499$^{*}$ (0.285) & $-$0.522$^{*}$ (0.284) & $-$0.519$^{*}$ (0.284) \\
  Brain & $-$0.00000$^{***}$ (0.00000) & $-$0.00000$^{***}$ (0.00000) & $-$0.00000$^{***}$ (0.00000) \\
  Age:Sex & $-$0.003 (0.004) & $-$0.003 (0.004) & $-$0.003 (0.004) \\
 \hline \\[-1.8ex]
R$^{2}$ & 0.034 & 0.034 & 0.034 \\
F Statistic & 136.059$^{***}$ & 136.031$^{***}$ & 136.368$^{***}$ \\
\hline
\hline \\[-1.8ex]
\multicolumn{2}{l}{\textit{Note:} Site,constant effects not listed.} & \multicolumn{2}{r}{$^{*}$p$<$0.1; $^{**}$p$<$0.05; $^{***}$p$<$0.01} \\
\end{tabular}
\end{table}

Table \ref{table::hippo_parahippo} summarizes the package-specific statistical
relationships between hippocampal and parahippocampal volumes (with the
prescribed confounds) and the well-studied demographic target variables of age,
fluid intelligence score, and neuoroticism score [@Dadi:2021wb]. Similar trends
are seen across all IDPs although age demonstrates the greatest mutual disparity
in the hippocampal and parahippocampal regions.

<!-- FSL, FreeSurfer,  ----------------------------->

## DeepFLASH Hierarchical IDP comparison {-}

\begin{table}[!htbp] \centering
\caption{Hierarchical regional regression coefficients (and their standard errors)
        are illustrated with respect to the target variables of age, neuroticism score,
        and fluid intelligence score.}
  \label{table::deep_flash_mtl}
\footnotesize
\begin{tabular}{@{\extracolsep{5pt}}lccc}
  & {\bf Age} & {\bf FluidIntelligence} & {\bf Neuroticism}\\
\hline
\hline\\[-1.8ex]
MTL & -0.00052 (0.00003)$^{***}$ & 0.00001 (0.00001) & 0.00003 (0.00001)\\
\hline\\[-1.8ex]
hippocampus & -0.00181 (0.00007)$^{***}$ & 0.0001 (0.00003)$^{***}$ & 0.00009 (0.00003)$^{*}$\\
extra.hippocampal & -0.00036 (0.00003)$^{***}$ & 0 (0.00001) & 0.00002 (0.00001)\\
\hline\\[-1.8ex]
DG.CA2.CA3.CA4 & -0.00425 (0.00022)$^{***}$ & 0.00026 (0.00008)$^{**}$ & -0.00007 (0.0001)\\
CA1 & 0.00214 (0.00012)$^{***}$ & 0.00008 (0.00004) & 0.00016 (0.00006)$^{**}$\\
subiculum & -0.00818 (0.00027)$^{***}$ & 0.00026 (0.0001)$^{*}$ & 0.00055 (0.00013)$^{***}$\\
aLEC & 0.00436 (0.00015)$^{***}$ & -0.00009 (0.00005) & 0.00016 (0.00007)\\
pMEC & 0.01244 (0.0004)$^{***}$ & 0.00023 (0.00015) & 0.0004 (0.00019)\\
perirhinal & 0.00004 (0.00004) & -0.00002 (0.00002) & 0.00002 (0.00002)\\
parahippocampal & -0.00129 (0.00006)$^{***}$ & 0.00003 (0.00002) & 0.00002 (0.00003)\\
\hline
\hline \\[-1.8ex]
\multicolumn{2}{l}{} & \multicolumn{2}{r}{$^{*}$p$<$0.1; $^{**}$p$<$0.05; $^{***}$p$<$0.01} \\
\end{tabular}
\end{table}

As mentioned previously, DeepFLASH produces three separate outputs
structured based on the specified anatomical hierarchy.  Similar to
the inter-package analysis found in the previous section, we used
regression models to compare the different DeepFLASH output regions
for the demographic target variables of age, fluid intelligence score,
and neuoroticism score [@Dadi:2021wb].  Specifically, we model

\begin{align}
Age \sim \{Region\} + Sex + Brain + Site
\end{align}

and

\begin{align}
FluidIntelligence \,\,\mathrm{or}\,\, Neuroticism \sim & \{Region\} + Age + Age^2 \nonumber \\
                                   + & Sex + Age * Sex + Brain + Site
\end{align}

where $\{Region\}$ is one of the hierarchical DeepFlash outputs listed in the
left column of Table \ref{table::deep_flash_mtl} along with the regression coefficients, standard errors, and
statistical significance associated with each region.

<!-- For Age, an ANOVA analysis demonstrated a statistical significance
in residual sum-of-squares reduction between both the whole MTL
and hippocampal/extra-hippocampal models as did the latter with the
full MTL parcellation.  Similar trends were seen for Fluid Intelligence
Score (whole MTL versus hippocampal/extra-hippocampal: $p < 0.001$,
hippocampal/extra-hippocampal versus full parcellation:  $p < 0.07$) and
Neuroticism Score (whole MTL versus hippocampal/extra-hippocampal: $p < 0.06$,
hippocampal/extra-hippocampal versus full parcellation:  $p < 0.001$). -->




<!-- Deep FLASH MTL ----------------------------->


<!--


\begin{table}[!htbp] \centering
  \caption{Comparison of anatomically hierarchical models of DeepFLASH IDPs.}
  \label{table::deep_flash_mtl}
\footnotesize
\begin{tabular}{@{\extracolsep{5pt}}lccc}

 & {\bf Whole MTL} & {\bf Hippo/Extra-} & {\bf Full parcellation} \\
\hline\hline
\\[-1.8ex]
\multicolumn{4}{c}{\cellcolor{gray!25} $Age \sim \{Regions\} + Sex + Brain + Site$} \\
\\[-1.8ex]
\hline
\\[-1.8ex]
  MTL & $-$0.001$^{***}$ (0.00003) &  &  \\
  hippocampal &  & $-$0.002$^{***}$ (0.0001) &  \\
  extra-hippocampal &  & $-$0.0003$^{***}$ (0.00003) &  \\
  DG.CA2.CA3.CA4 &  &  & $-$0.011$^{***}$ (0.0003) \\
  CA1 &  &  & 0.009$^{***}$ (0.0002) \\
  subiculum &  &  & $-$0.017$^{***}$ (0.0003) \\
  aLEC &  &  & 0.002$^{***}$ (0.0002) \\
  pMEC &  &  & 0.013$^{***}$ (0.001) \\
  perirhinal &  &  & $-$0.001$^{***}$ (0.00005) \\
  parahippocampal &  &  & $-$0.001$^{***}$ (0.0001) \\
 % Brain & $-$0.00001$^{***}$ (0.00000) & $-$0.00001$^{***}$ (0.00000) & $-$0.00001$^{***}$ (0.00000) \\
 % Sex & 4.024$^{***}$ (0.091) & 3.931$^{***}$ (0.091) & 2.164$^{***}$ (0.088) \\
 \hline \\[-1.8ex]
R$^{2}$ & 0.084 & 0.091 & 0.208 \\
F Statistic & 629.940$^{***}$ & 590.893$^{***}$ & 901.801$^{***}$ \\
\hline\hline
\\[-1.8ex]
\multicolumn{4}{c}{\cellcolor{gray!25} $FluidIntelligence \sim \{Regions\} + Age + Age^2 + Sex + Age * Sex + Brain + Site$} \\
\\[-1.8ex]
\hline
\\[-1.8ex]
  MTL & 0.00001 (0.00001) &  &  \\
  hippocampal &  & 0.0001$^{***}$ (0.00003) &  \\
  extra-hippocampal &  & $-$0.00001 (0.00001) &  \\
  DG.CA2.CA3.CA4 &  &  & 0.0003$^{**}$ (0.0001) \\
  CA1 &  &  & $-$0.0001 (0.0001) \\
  subiculum &  &  & 0.0002$^{*}$ (0.0001) \\
  aLEC &  &  & $-$0.0002$^{***}$ (0.0001) \\
  pMEC &  &  & 0.001$^{**}$ (0.0002) \\
  perirhinal &  &  & $-$0.00000 (0.00002) \\
  parahippocampal &  &  & 0.00001 (0.00002) \\
 % Age & $-$0.012$^{***}$ (0.003) & $-$0.012$^{***}$ (0.003) & $-$0.011$^{***}$ (0.003) \\
 % Sex & 0.359 (0.231) & 0.339 (0.231) & 0.356 (0.230) \\
 % Brain & 0.00000$^{***}$ (0.00000) & 0.00000$^{***}$ (0.00000) & 0.00000$^{***}$ (0.00000) \\
 % Age:Sex & $-$0.010$^{***}$ (0.004) & $-$0.010$^{***}$ (0.004) & $-$0.010$^{***}$ (0.004) \\
 \hline \\[-1.8ex]
R$^{2}$ & 0.045 & 0.045 & 0.046 \\
F Statistic & 127.653$^{***}$ & 115.177$^{***}$ & 74.795$^{***}$  \\
\hline\hline
\\[-1.8ex]
\multicolumn{4}{c}{\cellcolor{gray!25} $Neuroticism \sim \{Regions\} + Age + Age^2 + Sex + Age * Sex + Brain + Site$} \\
\\[-1.8ex]
\hline
\\[-1.8ex]
  MTL & 0.00003$^{**}$ (0.00001) &  &  \\
  hippocampal &  & 0.0001$^{***}$ (0.00003) &  \\
  extra-hippocampal &  & 0.00002 (0.00001) &  \\
  DG.CA2.CA3.CA4 &  &  & $-$0.0004$^{***}$ (0.0001) \\
  CA1 &  &  & 0.0001 (0.0001) \\
  subiculum &  &  & 0.001$^{***}$ (0.0002) \\
  aLEC &  &  & 0.00004 (0.0001) \\
  pMEC &  &  & 0.0002 (0.0003) \\
  perirhinal &  &  & 0.00003 (0.00002) \\
  parahippocampal &  &  & $-$0.00003 (0.00003) \\
 % Age & $-$0.046$^{***}$ (0.003) & $-$0.045$^{***}$ (0.003) & $-$0.046$^{***}$ (0.003) \\
 % Sex & $-$0.519$^{*}$ (0.284) & $-$0.527$^{*}$ (0.284) & $-$0.483$^{*}$ (0.284) \\
 % Brain & $-$0.00000$^{***}$ (0.00000) & $-$0.00000$^{***}$ (0.00000) & $-$0.00000$^{***}$ (0.00000) \\
 % Age:Sex & $-$0.003 (0.004) & $-$0.003 (0.004) & $-$0.004 (0.004) \\
 \hline \\[-1.8ex]
R$^{2}$ & 0.034 & 0.034 & 0.035 \\
F Statistic & 153.137$^{***}$ & 136.518$^{***}$ & 89.478$^{***}$  \\
\hline
\hline \\[-1.8ex]
\multicolumn{2}{l}{\textit{Note:} Common confounds not listed.} & \multicolumn{2}{r}{$^{*}$p$<$0.1; $^{**}$p$<$0.05; $^{***}$p$<$0.01} \\
\end{tabular}
\end{table}

-->