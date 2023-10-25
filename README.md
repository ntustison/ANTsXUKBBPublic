# [ANTsX neuroimaging-derived structural phenotypes of UK Biobank](https://www.medrxiv.org/content/10.1101/2023.01.17.23284693v3)

___________________

## Feature ranking across FSL, FreeSurfer, and ANTsX IDPs for predicting UKBB sociodemographic targets


| __Target__ | __Data ID__ | __Brief Description__ | __ML Technique__ |  
|   :----:  |   :----:  |   :----:  |   :----:  |
| [Age](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#age-linear-regression) | 21003-2.0 | Age (years) at imaging visit | linear regression | 
| [Fluid intelligence score](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#fluidintelligencescore-linear-regression) | 20191-0.0 | Number of correct answers (of 13) | linear regression | 
| [Neuroticism score](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#neuroticismscore-lasso) | 20127-0.0 | Summary of 12 behaviour domains |sparse regression | 
| [Numeric memory](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#numericmemory-lasso) | 20240-0.0 | Maximum digits remembered correctly | sparse regression | 
| [Body mass index](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#bmi-linear-regression) | 21001-2.0 | Impedance-based body composition | linear regression |
| [Townsend deprivation index](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#townsenddeprivationindex-linear-regression) | 189-0.0 | Material deprivation measure | linear regression |
| [Genetic sex](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#geneticsex-linear-regression) | 22001-0.0 | Sex from genotyping |linear regression | 
| [Hearing difficulty](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#hearing-linear-regression) | 2247-2.0 | Any difficulty?  Yes/No |linear regression | 
| [Risk taking](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#risktaking-linear-regression) | 2040-2.0 | Do you take risks?  Yes/No |linear regression | 
| [Same sex intercourse](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#samesexintercourse-densenet) | 2159-2.0 | Ever had?  Yes/No | DenseNet |
| [Smoking](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#smoking-densenet) | 1249-2.0 | Daily, occasionally, or $\leq 2$ times? | DenseNet |
| [Alcohol](https://github.com/ntustison/ANTsXUKBB/blob/main/README.md#alcohol-densenet) | 1558-2.0 | Six frequency categories $^\dagger$ | DenseNet | 

$\dagger$:  Daily, 3-4 times/week, 1-2 times/week, 1-3 times/month, special occasions only, and never.

Couple notes:
* For each sociodemographic variable, only the top performing ML technique for grouped set of all IDPs is used for the rankings below.  For the majority of the variables listed above, this was linear regression.
* Rankings are based on "variable importance" as determined by the ML technique (e.g., ``vi`` from the ``vip`` R package for linear regression).
* Only the top 25 are listed.  This can be easily modified to include more.

## Age (linear regression)

<table>
<caption>
Age
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Atropos
</td>
<td style="text-align:left;">
Cerebellum
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of WM-hypointensities (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
L\_III volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of CerebralWhiteMatter (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of CerebralWhiteMatter (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of CC-Central (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of SupraTentorial (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volume of grey matter
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of TotalGray (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Cortex (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of VentricleChoroid (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Cortex (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
CerebellarCSF volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of VentralDC (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right cerebellum exterior
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of VentralDC (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
CerebellarWhiteMatter volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of SubCortGray (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Cerebellar vermal lobules VI VII
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Left caudate
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Amygdala (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right lateral ventricle
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Atropos
</td>
<td style="text-align:left;">
BrainStem
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Cerebellum-Cortex (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Caudate (left hemisphere)
</td>
</tr>
</tbody>
</table>

## FluidIntelligenceScore (linear regression)


<table>
<caption>
FluidIntelligenceScore
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of CC-Mid-Anterior (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left paracentral
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Intracalcarine Cortex (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volume of peripheral cortical grey matter
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left superior frontal
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left inferior temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Middle Temporal Gyrus - posterior division
(left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Left hippocampus
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of superiorparietal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of isthmuscingulate (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Inf-Lat-Vent (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Superior Temporal Gyrus - posterior division
(right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Cortex (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in X Cerebellum (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of fusiform (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Cortex (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Left rostral middle frontal volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of subiculum-body (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of HATA (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of CA4-body (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of Hippocampal-tail (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of parasubiculum (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left caudal middle frontal
</td>
</tr>
</tbody>
</table>

## NeuroticismScore (sparse regression)

<table>
<caption>
NeuroticismScore
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of superiortemporal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of posteriorcingulate (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volume of peripheral cortical grey matter
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left supramarginal
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of posteriorcingulate (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of isthmuscingulate (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right posterior cingulate
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left lateral orbitofrontal
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of AV (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lateralorbitofrontal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of superiorparietal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right supramarginal
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of superiortemporal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of inferiortemporal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left precentral
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of transversetemporal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lingual (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of isthmuscingulate (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left posterior cingulate
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of rostralanteriorcingulate (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lateralorbitofrontal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of AV (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left isthmus cingulate
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right precentral
</td>
</tr>
</tbody>
</table>

## NumericMemory (sparse regression)


<table>
<caption>
NumericMemory
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of AV (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of isthmuscingulate (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volume of peripheral cortical grey matter
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of postcentral (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of inferiorparietal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of AV (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of precuneus (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right lateral orbitofrontal
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right medial orbitofrontal
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lingual (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of supramarginal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of isthmuscingulate (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right transverse temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of insula (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left fusiform
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of rostralmiddlefrontal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right superior temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left lateral orbitofrontal
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of medialorbitofrontal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of parsorbitalis (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left transverse temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of insula (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Left caudal middle frontal volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lateralorbitofrontal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left medial orbitofrontal
</td>
</tr>
</tbody>
</table>

## BMI (linear regression)

<table>
<caption>
BMI
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left paracentral
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Cerebellum-White-Matter (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
CerebellarGrayMatter volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Cerebellum-White-Matter (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left lingual
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of EstimatedTotalIntraCranial (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Atropos
</td>
<td style="text-align:left;">
BrainStem
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volume of peripheral cortical grey matter (normalised for
head size)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Occipital Fusiform Gyrus (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Lateral Occipital Cortex - superior division
(right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Lingual Gyrus (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of VentralDC (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of SupraTentorialNotVent (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Caudate (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of superiorfrontal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Cuneal Cortex (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in VIIIa Cerebellum (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Left thalamus proper
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Pallidum (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in IX Cerebellum (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of transversetemporal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FIRST
</td>
<td style="text-align:left;">
Volume of caudate (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of isthmuscingulate (right hemisphere)
</td>
</tr>
</tbody>
</table>

## TownsendDeprivationIndex (linear regression)

<table>
<caption>
TownsendDeprivationIndex
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volume of peripheral cortical grey matter
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Heschl’s Gyrus (includes H1 and H2) (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volume of ventricular cerebrospinal fluid
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volume of ventricular cerebrospinal fluid (normalised for
head size)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of SupraTentorial (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of VentralDC (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Heschl’s Gyrus (includes H1 and H2) (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
SYSU WMH
</td>
<td style="text-align:left;">
Left cerebellum
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of TotalGray (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Superior Parietal Lobule (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of superiorfrontal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
CerebellarGrayMatter volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
L\_III volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right caudal anterior cingulate
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Left insula volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of SupraTentorialNotVent (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Thalamus (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left superior parietal
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Inferior Temporal Gyrus - temporooccipital part
(left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Frontal Pole (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Planum Temporale (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
R\_X volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of superiortemporal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Occipital Fusiform Gyrus (left)
</td>
</tr>
</tbody>
</table>

## GeneticSex (linear regression)

<table>
<caption>
GeneticSex
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Atropos
</td>
<td style="text-align:left;">
DeepGrayMatter
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of AV (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of VentralDC (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of CerebralWhiteMatter (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Left thalamus proper
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of CerebralWhiteMatter (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Cortex (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Cortex (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of CC-Central (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FIRST
</td>
<td style="text-align:left;">
Volume of accumbens (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Lateral Occipital Cortex - superior division
(left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Right lateral occipital volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Frontal Medial Cortex (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right caudate
</td>
</tr>
<tr>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of paracentral (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of transversetemporal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
R\_IX thickness
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Left parahippocampal volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
R\_VIIB thickness
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of AV (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Right superior parietal volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
CerebellarWhiteMatter volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right inferior parietal
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Intracalcarine Cortex (right)
</td>
</tr>
</tbody>
</table>

## Hearing (linear regression)

<table>
<caption>
Hearing
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right lingual
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
L\_IX volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DeepFLASH
</td>
<td style="text-align:left;">
Left aLEC
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left transverse temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of caudalanteriorcingulate (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in X Cerebellum (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of medialorbitofrontal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Temporal Fusiform Cortex - posterior division
(left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of posteriorcingulate (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volume of grey matter
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of paracentral (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right thalamus proper
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
L\_Crus\_I volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
L\_I\_II volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of inferiorparietal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of inferiorparietal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
R\_VI volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right caudate
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in VI Cerebellum (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Parahippocampal Gyrus - posterior division
(left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Middle Temporal Gyrus - temporooccipital part
(right)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right middle temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
L\_Crus\_II volume
</td>
</tr>
</tbody>
</table>


## RiskTaking (linear regression)

<table>
<caption>
RiskTaking
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of BrainSeg (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Frontal Orbital Cortex (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of parsorbitalis (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of CL (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of Hippocampal-tail (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left caudal anterior cingulate
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of parasubiculum (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of presubiculum-body (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of CA3-body (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of CA4-body (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of subiculum-body (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of HATA (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Temporal Fusiform Cortex - anterior division
(left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Intracalcarine Cortex (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lateralorbitofrontal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DeepFLASH
</td>
<td style="text-align:left;">
Right perirhinal
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Right pericalcarine volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DeepFLASH
</td>
<td style="text-align:left;">
Right MTL
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right pericalcarine
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of AV (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Amygdala (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of TotalGray (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of entorhinal (left hemisphere)
</td>
</tr>
</tbody>
</table>

## SameSexIntercourse (DenseNet)

<table>
<caption>
SameSexIntercourse
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
GeneticSex
</td>
</tr>
<tr>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
Age
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of pericalcarine (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of 4th-Ventricle (whole brain)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left transverse temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
R\_Crus\_II volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of medialorbitofrontal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
SYSU WMH
</td>
<td style="text-align:left;">
Right temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
CerebellarCSF volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Lingual Gyrus (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Left pars triangularis
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Right pars orbitalis volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in IX Cerebellum (vermis)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
Other
</td>
<td style="text-align:left;">
Continuous Volumetric scaling from T1 head image to standard space
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DeepFLASH
</td>
<td style="text-align:left;">
Left perirhinal
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right pars orbitalis
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
SYSU WMH
</td>
<td style="text-align:left;">
Right brain stem
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in VIIb Cerebellum (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right pericalcarine
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Parahippocampal Gyrus - anterior division
(left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Right lateral occipital volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right postcentral
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Crus I Cerebellum (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right pericalcarine
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lingual (right hemisphere)
</td>
</tr>
</tbody>
</table>

## Smoking (DenseNet)

<table>
<caption>
Smoking
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of choroid-plexus (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
Age
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
SYSU WMH
</td>
<td style="text-align:left;">
Left parietal
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left pericalcarine
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of transversetemporal (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Amygdala (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of fusiform (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
SYSU WMH
</td>
<td style="text-align:left;">
Left occipital
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
R\_VIIIA thickness
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Left insula volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of GC-ML-DG-body (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in IX Cerebellum (vermis)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cereb
</td>
<td style="text-align:left;">
L\_V thickness
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right precentral
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lingual (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FIRST
</td>
<td style="text-align:left;">
Volume of amygdala (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of postcentral (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Superior Parietal Lobule (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
GeneticSex
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Atropos
</td>
<td style="text-align:left;">
DeepGrayMatter
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in VIIIa Cerebellum (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of precuneus (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Left thalamus proper
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of supramarginal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
HippAmyg
</td>
<td style="text-align:left;">
Volume of parasubiculum (left hemisphere)
</td>
</tr>
</tbody>
</table>

## Alcohol (DenseNet)


<table>
<caption>
Alcohol
</caption>
<thead>
<tr>
<th style="text-align:left;">
Package
</th>
<th style="text-align:left;">
Pipeline
</th>
<th style="text-align:left;">
Feature
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of parsopercularis (left hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Right entorhinal volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of superiortemporal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lateraloccipital (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Middle Temporal Gyrus - anterior division
(right)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right pericalcarine
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Right inferior temporal volume
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Subcallosal Cortex (left)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Mean thickness of lingual (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Left posterior cingulate volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Right inferior temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Subcallosal Cortex (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
–
</td>
<td style="text-align:left;">
Age
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Left cuneus
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in VIIIb Cerebellum (right)
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
ASEG
</td>
<td style="text-align:left;">
Volume of Inf-Lat-Vent (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Right rostral middle frontal
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Thickness
</td>
<td style="text-align:left;">
Left lateral occipital
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of rostralmiddlefrontal (right hemisphere)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
Cortical
</td>
<td style="text-align:left;">
Right fusiform volume
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Left inferior temporal
</td>
</tr>
<tr>
<td style="text-align:left;">
FSL
</td>
<td style="text-align:left;">
FAST
</td>
<td style="text-align:left;">
Volume of grey matter in Inferior Frontal Gyrus - pars triangularis
(right)
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DKT Volume
</td>
<td style="text-align:left;">
Left pars opercularis
</td>
</tr>
<tr>
<td style="text-align:left;">
ANTsX
</td>
<td style="text-align:left;">
DeepFLASH
</td>
<td style="text-align:left;">
Left extra hippocampal
</td>
</tr>
<tr>
<td style="text-align:left;">
FreeSurfer
</td>
<td style="text-align:left;">
Volume
</td>
<td style="text-align:left;">
Volume of cuneus (left hemisphere)
</td>
</tr>
</tbody>
</table>

