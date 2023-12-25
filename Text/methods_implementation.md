
### Open-science implementation

Implementations of the previously described pipelines are available in Python
and R through our respective ANTsPy/ANTsPyNet and ANTsR/ANTsRNet libraries
hosted in the ANTsX ecosystem on GitHub (http://www.github.com/ANTsX/).
\textcolor{blue}{Assuming the T1-weighted and FLAIR images are stored in the
variables} \verb#t1# \textcolor{blue}{and} \verb#flair#\textcolor{blue}{,
respectively, the specific function invocations to produce the ANTsX UKBB IDPs
are as follows:}

* ANTsPyNet (Python)
    * `brain_extraction(t1, modality="t1")`
    * `deep_atropos(t1)`
    * `cortical_thickness(t1)`
    * `desikany_killiany_tourville_labeling(t1, do_lobar_parcellation=True)`
    * `deep_flash(t1)`
    * `cerebellum_morphology(t1, compute_thickness_image=True)`
    * `sysu_media_white_matter_segmentation(flair, t1)`

* ANTsRNet (R)
    * `brainExtraction( t1, modality = "t1" )`
    * `deepAtropos( t1 )`
    * `corticalThickness( t1 )`
    * `desikanyKillianyTourvilleLabeling( t1, doLobarParcellation = TRUE )`
    * `deepFlash( t1 )`
    * `cerebellumMorphology( t1, computeThicknessImage = TRUE )`
    * `sysuMediaWhiteMatterSegmentation( flair, t1 )`

\textcolor{blue}{Note that deviation from the default parameters is only used to
produce additional output.  In addition to the scripts that are in the publicly
available GitHub repository associated with this work
(\url{https://github.com/ntustison/ANTsXUKBBPublic}), self-contained examples
(i.e., including data and code snippets) of all listed functionality are
available as part of an online ANTsX tutorial also hosted on GitHub as a gist
(\url{http://tinyurl.com/antsxtutorial})}.

