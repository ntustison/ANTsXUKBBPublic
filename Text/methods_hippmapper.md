
## HippMapp3r

The HippMapp3r segmentation framework was originally described in
[@Goubran:2020aa]. Although the authors provide an implementation (including
docker support), we incorporated the HippMapp3r model and weights within the
ANTsXNet ecosystem prior to the work described herein.  This allows us to remove
the external dependencies (which includes ANTs) and allows us to run everything
within the same framework to minimize pipeline variation.  It is used for
comparative evaluation with the UK Biobank processed data.

HippMapp3r is used to segment the left and right whole hippocampi specifically
targeting subjects characterized by atrophy. Comparisons with other frameworks,
such as FreeSurfer [@Iglesias:2015aa] and HippoDeep [@Thyreau:2018aa],
demonstrated excellent performance.  HippMapp3r was trained on a set of
hand-labeled segmentations on 209 elderly subjects employing a concatenated
U-net configuration with residual blocks.  The initial network provides a
preliminary estimate of the location of the hippocampi as input to the second
network.  Although brain extraction is not a prequisite, the authors discuss
potential improved performance when such preprocessing occurs which agrees with
our experience.
