
# Materials and Methods

## UK Biobank data description

The study was conducted under UKBB Resource Application ID 63965.  The total
number of subjects at the time of download was 502,413 with 49,351 subjects
having undergone the standard imaging battery.  Of these imaging subjects,
only 40,898 complete sets of downloaded IDPs were in common between those
provided by FSL and FreeSurfer processing streams [@Alfaro-Almagro:2018wi].
Intersection with the final ANTs processed set resulted in a total study
cohort size of 40,796.

## FSL structural phenotypes

All structural FSL IDPs were included for consideration [@ukbb].  These included the
following categories:

* FAST regional grey matter volumes (Category ID:  1101);
* FIRST subcortical volumes (Category ID:  1102);
* global brain tissue volumes and related quantities (Field ID:  25000--25010,
  25025); and
* total volume of WMH load (Field ID: 25781)

for a total of $139_{FAST} + 14_{FIRST} + 12_{Global} + 1_{WMH} = 166$ IDPs.

## FreeSurfer structural phenotypes

Several categories of IDPs are available for FreeSurfer comprising a total of
1242 measurements [@ukbb].  However, to make the study dataset more computationally
tractable and reduce set size differences between packages, we selected the
following popular IDP subsets:

* ASEG volumetric measurements (Category ID: 190);
* DKT volumes and mean thicknesses (Category ID: 196); and
* hippocampal subfields and amygdala nuclei (Category ID:  191)

totaling $56_{ASEG} + 124_{DKT} + 121_{hipp} = 301$ individual IDPs.

## ANTsX structural phenotypes

Both sociodemographic and bulk image data were downloaded to the high
performance cluster at the University of Virginia for processing. Grad-warped
distortion corrected [@Glasser:2013vz] T1-weighted and FLAIR image data were used
to produce the following ANTsX IDPs:

* Deep Atropos brain tissue volumes (i.e., CSF, gray matter, white matter, deep
  gray matter, brain stem, and cerebellum);
* DKT DiReCT cortical thickness and volumes;
* DKT-based regional volumes;
* DeepFLASH regional volumes;
* Cerebellum regional thickness and volumes;
* Regional WMH loads

totaling $7_{Deep Atropos} + 88_{DKT reg} + 128_{DKT DiReCT} + 20_{DeepFLASH} +
48_{Cerebellum} + 13_{WMH} = 302$ IDPs which are illustrated in Figure
\ref{fig:antsxidps}.  We have reported previously on the first three categories
of ANTsX IDPs [@Tustison:2021aa] but provide a brief description below.  We also
provide further details concerning both DeepFLASH and the ANTsXNet-ported WMH
algorithms.

\begin{figure}
  \centering
    \includegraphics{Figures/ANTsXIDPs2.pdf}
    \caption{Illustration of the IDPs generated with ANTsX ecosystem tools.
    Using the gradient-distortion corrected versions of the T1 and FLAIR images,
    several categories of IDPs were tabulated.  These include global brain and
    tissue volumes, cortical thicknesses averaged over the 62 DKT regions,
    WMH intensity load per lobe based on the SYSU algorithm, cortical and
    subcortical volumes from  the DKT labeling, MTL regional volumes
    using DeepFLASH, and morphological cerebellum quantities.
    }
    \label{fig:antsxidps}
\end{figure}

### Brain tissue volumes

The ANTsXNet deep learning libraries for Python and R (ANTsPyNet and ANTsRNet,
respectively) were recently described in [@Tustison:2021aa] where they were
evaluated in terms of multi-site cortical thickness estimation.  This extends
previous work [@Tustison:2014ab;@Tustison:2019aa] in replacing key pipeline
components with deep learning variants.  For example, a trained network, denoted
_Deep Atropos_, replaced the original Atropos algorithm [@Avants:2011uf] for
six-tissue segmentation (CSF, gray matter, white matter, deep gray matter,
cerebellum, and brain stem) similar to functionality for whole brain deep
learning-based brain extraction.

<!--
[^3]:  Note that the original diffeomorphic registration-based cortical thickness
algorithm (DiReCT) [@Das:2009uv], i.e. _KellyKapowski_, remains the same as in the
original.
-->

### DKT cortical thickness, regional volumes, and lobar parcellation

As part of the deep learning refactoring of the cortical thickness pipeline
mentioned in the previous section, a framework was developed to generate DKT
cortical and subcortical regional labels from T1-weighted MRI
[@Tustison:2021aa].  This facilitates regional averaging of cortical thickness
values over that atlas parcellation as well as being the source of other
potentially useful geometry-based IDPs.  In terms of network training and
development, using multi-site data from [@Tustison:2014ab], two separate U-net
[@Falk:2019aa] networks were trained for the "inner" (e.g., subcortical,
cerebellar) labels and the "outer" cortical labels, respectively. Similar to
Deep Atropos, preprocessing includes brain extraction and affine transformation
to the space of the MNI152 template [@Fonov:2009aa] which includes corresponding
prior probability maps.  These maps are used as separate input channels for both
training and prediction---a type of surrogate for network attention gating
[@Schlemper:2019aa]. Using FreeSurfer's DKT atlas label-to-lobe mapping
[@Desikan:2006ui], we use a fast marching approach [@Sethian:1996vr] to produce
left/right parcellations of the frontal, temporal, parietal, and occipital
lobes, as well as left/right divisions of the brain stem and cerebellum. Using
the segmentation output from Deep Atropos, the DiReCT algorithm [@Das:2009uv]
generates the subject-specific cortical thickness map which, as previously
mentioned, is summarized in terms of IDPs by DKT regional definitions.  Given
the diffeomorphic and thickness constraints dictated by the DiReCT algorithm, we
generate additional DKT regional labels (cortex only) from the non-zero cortical
thickness regions to also be used as IDPs.


