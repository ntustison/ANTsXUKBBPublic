<!-- use Paul Tol's color ggplot scheme for color blindness -->

<!--
# Reproducibility papers for measurement comparison

## General structural imaging-derived phenotypes

### _Associations between alchohol consumption and gray and white matter volumes in the UK Biobank_ (Daviet, 2022)

### _Structural brain imaging correlates of general intelligence in UK Biobank_ (Cox, 2019)

### _SARS-CoV-2 is associated with changes in brain structure in UK Biobank_ (Douaud, 2022)

## DeepFlash

### _Association between exposure to air pollution and hippocampal volume in adults in the UK Biobank_ (Hedges, 2019)

### _Hippocampal volume across age:  Nomograms derived from over 19,700 people in UK Biobank_ (Nobis, 2019)

## Other important papers

### _Population modeling with machine learning can enhance measures of mental health_ (Dadi, 2021)

### _Multimodal population brain imaging in the UK Biobank prospective epidimiological study_ (Miller, 2016)

### _Image processing and Quality Control for the first 10,000 brain imaging datasets from UK Biobank_ (Alfaro-Almagro, 2018)

### _Confound modelling in Uk Biobank brain imaging_ (Alfaro-Almagro, 2021)

### _The UK Biobank imaging enhancement of 100,000 participants: rationale, data collection, management and future directions_ (LittleJohns, 2020)

### _Neuroanatomical norms in the UK Biobank:  The impact of allometric scaling, sex, and age_ (Williams, 2020)


\clearpage

-->

# Age

![Age](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_Age.pdf)

## Feature ranking: Linear

-   FSL

    -   range: \[ NA , NA \]

    -   std: NA

    -   skewness: NA

-   FreeSurfer

    -   range: \[ 0.1526888 , 15.03373 \]

    -   std: 2.686921

    -   skewness: 2.324572

-   ANTsX

    -   range: \[ 0.1354494 , 17.57277 \]

    -   std: 2.308719

    -   skewness: 2.238218

### Package-based ranking (top 10 features)

-   FSL: rank = 363 , imp = 77.09145

-   FreeSurfer: rank = 80 , imp = 121.5785

-   ANTsX: rank = 166 , imp = 108.6568

### Package-based ranking (top 25 features)

-   FSL: rank = 1615 , imp = 155.1536

-   FreeSurfer: rank = 561 , imp = 241.8775

-   ANTsX: rank = 919 , imp = 205.7617

### Package-based ranking (top 50 features)

-   FSL: rank = 5368 , imp = 248.9677

-   FreeSurfer: rank = 3346 , imp = 355.6919

-   ANTsX: rank = 3177 , imp = 331.0176

# FluidIntelligenceScore

![FluidIntelligenceScore](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_FluidIntelligenceScore.pdf)

## Feature ranking: Linear

-   FSL

    -   range: \[ 0.1864763 , 4.409947 \]

    -   std: 0.6514862

    -   skewness: 1.818237

-   FreeSurfer

    -   range: \[ 0.1644809 , 4.097554 \]

    -   std: 0.5718555

    -   skewness: 1.554328

-   ANTsX

    -   range: \[ 0.1397266 , 3.695379 \]

    -   std: 0.5723668

    -   skewness: 1.259365

### Package-based ranking (top 10 features)

-   FSL: rank = 170 , imp = 26.70319

-   FreeSurfer: rank = 151 , imp = 24.63818

-   ANTsX: rank = 195 , imp = 24.59515

### Package-based ranking (top 25 features)

-   FSL: rank = 1437 , imp = 52.0111

-   FreeSurfer: rank = 764 , imp = 54.65516

-   ANTsX: rank = 957 , imp = 53.44664

### Package-based ranking (top 50 features)

-   FSL: rank = 5444 , imp = 84.00483

-   FreeSurfer: rank = 3010 , imp = 96.27253

-   ANTsX: rank = 3534 , imp = 92.52846

# NeuroticismScore

![NeuroticismScore](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_NeuroticismScore.pdf)

## Feature ranking: Lasso

-   FSL

    -   range: \[ 0.000000004743372 , 0.06772924 \]

    -   std: 0.006896142

    -   skewness: 8.905521

-   FreeSurfer

    -   range: \[ 0.000000003567677 , 0.06191656 \]

    -   std: 0.01080398

    -   skewness: 2.993756

-   ANTsX

    -   range: \[ 0.00000002994948 , 0.05547663 \]

    -   std: 0.008088334

    -   skewness: 3.708592

### Package-based ranking (top 10 features)

-   FSL: rank = 1567 , imp = 0.1329233

-   FreeSurfer: rank = 97 , imp = 0.4832962

-   ANTsX: rank = 174 , imp = 0.3840031

### Package-based ranking (top 25 features)

-   FSL: rank = 5819 , imp = 0.1333615

-   FreeSurfer: rank = 544 , imp = 0.8983481

-   ANTsX: rank = 896 , imp = 0.6587533

### Package-based ranking (top 50 features)

-   FSL: rank = 14572 , imp = 0.1336889

-   FreeSurfer: rank = 2122 , imp = 1.230213

-   ANTsX: rank = 3261 , imp = 0.8462698

# NumericMemory

![NumericMemory](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_NumericMemory.pdf)

## Feature ranking: Lasso

-   FSL

    -   range: \[ 0.000000002930496 , 0.007651691 \]

    -   std: 0.0005948515

    -   skewness: 12.559

-   FreeSurfer

    -   range: \[ 0.000000004589048 , 0.0106752 \]

    -   std: 0.001189512

    -   skewness: 4.543139

-   ANTsX

    -   range: \[ 0.000000006963895 , 0.004325757 \]

    -   std: 0.0007972568

    -   skewness: 2.364202

### Package-based ranking (top 10 features)

-   FSL: rank = 1905 , imp = 0.008571247

-   FreeSurfer: rank = 72 , imp = 0.05603193

-   ANTsX: rank = 175 , imp = 0.03091613

### Package-based ranking (top 25 features)

-   FSL: rank = 6300 , imp = 0.008641978

-   FreeSurfer: rank = 625 , imp = 0.08951268

-   ANTsX: rank = 724 , imp = 0.06428639

### Package-based ranking (top 50 features)

-   FSL: rank = 14864 , imp = 0.00870102

-   FreeSurfer: rank = 2642 , imp = 0.1201725

-   ANTsX: rank = 2518 , imp = 0.09986517

# BMI

![BMI](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_BMI.pdf)

## Feature ranking: Linear

-   FSL

    -   range: \[ 0.1562628 , 12.46823 \]

    -   std: 2.429514

    -   skewness: 1.476122

-   FreeSurfer

    -   range: \[ 0.159632 , 12.3667 \]

    -   std: 2.219477

    -   skewness: 1.776937

-   ANTsX

    -   range: \[ 0.1637263 , 12.64787 \]

    -   std: 1.924288

    -   skewness: 2.005405

### Package-based ranking (top 10 features)

-   FSL: rank = 131 , imp = 94.45128

-   FreeSurfer: rank = 164 , imp = 91.74847

-   ANTsX: rank = 210 , imp = 88.12971

### Package-based ranking (top 25 features)

-   FSL: rank = 923 , imp = 187.4333

-   FreeSurfer: rank = 796 , imp = 188.4521

-   ANTsX: rank = 1220 , imp = 172.7291

### Package-based ranking (top 50 features)

-   FSL: rank = 4453 , imp = 284.1735

-   FreeSurfer: rank = 3170 , imp = 307.6056

-   ANTsX: rank = 4106 , imp = 277.511

# TownsendDeprivationIndex

![TownsendDeprivationIndex](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_TownsendDeprivationIndex.pdf)

## Feature ranking: Linear

-   FSL

    -   range: \[ 0.139757 , 12.48687 \]

    -   std: 1.248796

    -   skewness: 4.841903

-   FreeSurfer

    -   range: \[ 0.1699931 , 3.64896 \]

    -   std: 0.6524566

    -   skewness: 1.065419

-   ANTsX

    -   range: \[ 0.158075 , 3.297345 \]

    -   std: 0.6863873

    -   skewness: 1.076649

### Package-based ranking (top 10 features)

-   FSL: rank = 93 , imp = 44.74012

-   FreeSurfer: rank = 233 , imp = 29.08779

-   ANTsX: rank = 193 , imp = 29.35449

### Package-based ranking (top 25 features)

-   FSL: rank = 763 , imp = 80.4624

-   FreeSurfer: rank = 1274 , imp = 60.26641

-   ANTsX: rank = 891 , imp = 64.35683

### Package-based ranking (top 50 features)

-   FSL: rank = 4128 , imp = 121.9611

-   FreeSurfer: rank = 4139 , imp = 104.0827

-   ANTsX: rank = 3281 , imp = 111.1481

# GeneticSex

![GeneticSex](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_GeneticSex.pdf)

## Feature ranking: Linear

-   FSL

    -   range: \[ NA , NA \]

    -   std: NA

    -   skewness: NA

-   FreeSurfer

    -   range: \[ 0.1737775 , 10.24362 \]

    -   std: 1.567378

    -   skewness: 2.222905

-   ANTsX

    -   range: \[ 0.1889526 , 10.59129 \]

    -   std: 1.589695

    -   skewness: 1.313573

### Package-based ranking (top 10 features)

-   FSL: rank = 305 , imp = 56.68502

-   FreeSurfer: rank = 93 , imp = 74.87624

-   ANTsX: rank = 158 , imp = 66.55404

### Package-based ranking (top 25 features)

-   FSL: rank = 1498 , imp = 117.6986

-   FreeSurfer: rank = 868 , imp = 146.3458

-   ANTsX: rank = 781 , imp = 142.2774

### Package-based ranking (top 50 features)

-   FSL: rank = 5321 , imp = 194.8791

-   FreeSurfer: rank = 4226 , imp = 228.9607

-   ANTsX: rank = 2835 , imp = 243.0013

# Hearing

![Hearing](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_Hearing.pdf)

## Feature ranking: Linear

-   FSL

    -   range: \[ 0.1400707 , 15.84752 \]

    -   std: 1.370073

    -   skewness: 7.933981

-   FreeSurfer

    -   range: \[ 0.1609316 , 3.033436 \]

    -   std: 0.6188603

    -   skewness: 1.169872

-   ANTsX

    -   range: \[ 0.09976114 , 3.424184 \]

    -   std: 0.6634497

    -   skewness: 1.186676

### Package-based ranking (top 10 features)

-   FSL: rank = 157 , imp = 41.91777

-   FreeSurfer: rank = 195 , imp = 26.48697

-   ANTsX: rank = 126 , imp = 28.82698

### Package-based ranking (top 25 features)

-   FSL: rank = 1280 , imp = 70.92944

-   FreeSurfer: rank = 933 , imp = 59.54118

-   ANTsX: rank = 820 , imp = 62.38052

### Package-based ranking (top 50 features)

-   FSL: rank = 5838 , imp = 103.0179

-   FreeSurfer: rank = 3514 , imp = 101.4115

-   ANTsX: rank = 3120 , imp = 106.2714

# RiskTaking

![RiskTaking](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_RiskTaking.pdf)

## Feature ranking: Linear

-   FSL

    -   range: \[ 0.1795269 , 10.14113 \]

    -   std: 0.9923587

    -   skewness: 5.553114

-   FreeSurfer

    -   range: \[ 0.1836498 , 3.657539 \]

    -   std: 0.6951129

    -   skewness: 0.6690752

-   ANTsX

    -   range: \[ 0.1370474 , 2.901573 \]

    -   std: 0.6013431

    -   skewness: 0.9711023

### Package-based ranking (top 10 features)

-   FSL: rank = 261 , imp = 34.88583

-   FreeSurfer: rank = 90 , imp = 30.03523

-   ANTsX: rank = 250 , imp = 25.28125

### Package-based ranking (top 25 features)

-   FSL: rank = 2255 , imp = 59.555

-   FreeSurfer: rank = 552 , imp = 65.86192

-   ANTsX: rank = 1073 , imp = 55.84686

### Package-based ranking (top 50 features)

-   FSL: rank = 8514 , imp = 90.72164

-   FreeSurfer: rank = 2525 , imp = 111.9594

-   ANTsX: rank = 3945 , imp = 97.4797

# SameSexIntercourse

![SameSexIntercourse](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_SameSexIntercourse.pdf)

## Feature ranking: DenseNet

-   FSL

    -   range: \[ 0.000000000003268539 , 0.00000001664616 \]

    -   std: 0.000000004021121

    -   skewness: 1.41056

-   FreeSurfer

    -   range: \[ 0.000000000002240486 , 0.00000002967567 \]

    -   std: 0.000000003728902

    -   skewness: 2.520695

-   ANTsX

    -   range: \[ 0.000000000005047014 , 0.00000001821027 \]

    -   std: 0.000000003795055

    -   skewness: 1.806069

### Package-based ranking (top 10 features)

-   FSL: rank = 214 , imp = 0.0000001407956

-   FreeSurfer: rank = 245 , imp = 0.0000001539418

-   ANTsX: rank = 118 , imp = 0.0000001631049

### Package-based ranking (top 25 features)

-   FSL: rank = 1092 , imp = 0.0000002926681

-   FreeSurfer: rank = 1110 , imp = 0.0000003048706

-   ANTsX: rank = 840 , imp = 0.0000003275384

### Package-based ranking (top 50 features)

-   FSL: rank = 4920 , imp = 0.000000438526

-   FreeSurfer: rank = 3773 , imp = 0.0000004926684

-   ANTsX: rank = 3373 , imp = 0.0000005208619

# Smoking

![Smoking](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_Smoking.pdf)

## Feature ranking: DenseNet

-   FSL

    -   range: \[ 0.0000000000003270309 , 0.0000000005886711 \]

    -   std: 0.0000000001163567

    -   skewness: 1.513629

-   FreeSurfer

    -   range: \[ 0.0000000000003655943 , 0.000000001000974 \]

    -   std: 0.0000000001167341

    -   skewness: 2.716113

-   ANTsX

    -   range: \[ 0.0000000000001786802 , 0.000000000638014 \]

    -   std: 0.000000000120871

    -   skewness: 1.511429

### Package-based ranking (top 10 features)

-   FSL: rank = 280 , imp = 0.000000004373141

-   FreeSurfer: rank = 159 , imp = 0.000000005361177

-   ANTsX: rank = 130 , imp = 0.000000005191133

### Package-based ranking (top 25 features)

-   FSL: rank = 1346 , imp = 0.000000008911815

-   FreeSurfer: rank = 1105 , imp = 0.00000001018895

-   ANTsX: rank = 728 , imp = 0.00000001080129

### Package-based ranking (top 50 features)

-   FSL: rank = 5736 , imp = 0.00000001346166

-   FreeSurfer: rank = 4092 , imp = 0.00000001577306

-   ANTsX: rank = 2811 , imp = 0.00000001777281

# Alcohol

![Alcohol](/Users/ntustison/Documents/Academic/InProgress/ANTsXUKBB/Text/Figures/compare_predictions_Alcohol.pdf)

## Feature ranking: DenseNet

-   FSL

    -   range: \[ 0.000000000001317874 , 0.000000001049847 \]

    -   std: 0.000000000177729

    -   skewness: 1.846177

-   FreeSurfer

    -   range: \[ 0.000000000005249085 , 0.000000001679132 \]

    -   std: 0.0000000001983307

    -   skewness: 3.149707

-   ANTsX

    -   range: \[ 0.0000000000005087941 , 0.000000001512374 \]

    -   std: 0.0000000002030513

    -   skewness: 2.066722

### Package-based ranking (top 10 features)

-   FSL: rank = 308 , imp = 0.000000006732736

-   FreeSurfer: rank = 166 , imp = 0.00000000911108

-   ANTsX: rank = 126 , imp = 0.00000000857335

### Package-based ranking (top 25 features)

-   FSL: rank = 1596 , imp = 0.00000001311022

-   FreeSurfer: rank = 1020 , imp = 0.00000001669101

-   ANTsX: rank = 636 , imp = 0.00000001763453

### Package-based ranking (top 50 features)

-   FSL: rank = 6042 , imp = 0.0000000200281

-   FreeSurfer: rank = 3724 , imp = 0.00000002605897

-   ANTsX: rank = 2726 , imp = 0.00000002838635

<embed src="../Text/Figures/compare_predictions_all.pdf" style="display: block; margin: auto;" type="application/pdf" />
<embed src="../Text/Figures/compare_predictions_rmse.pdf" style="display: block; margin: auto;" type="application/pdf" />
<embed src="../Text/Figures/compare_predictions_auc.pdf" style="display: block; margin: auto;" type="application/pdf" />
<embed src="../Text/Figures/compare_predictions_xcountry.pdf" style="display: block; margin: auto;" type="application/pdf" />
