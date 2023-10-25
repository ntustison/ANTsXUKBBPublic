
### White matter hyperintensity segmentation

Although UKBB includes white matter hyperintensity segmentation masks
[@Alfaro-Almagro:2018wi] derived from FMRIB's BIANCA tool [@Griffanti:2016wd], a
recently developed WMH segmentation framework from the "SYSU" team [@Li:2018aa]
was imported into the ANTsXNet libraries for WMH
segmentation.  As discussed in [@Kuijf:2019aa], this was the top performing
algorithm at the International Conference on Medical Image Computing and
Computer Assisted Intervention (MICCAI) held in 2017.  Image data from five
sites were used for both training and testing of segmentation algorithms from 20
different teams.  Both the architecture and ensemble weights were made publicly
available by the SYSU team which permitted a direct porting into ANTsXNet.
