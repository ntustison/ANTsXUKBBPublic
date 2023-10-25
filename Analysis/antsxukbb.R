library( rmarkdown )
library( ggplot2 )

stitchedFile <- "antsxukbb_stitched.Rmd"





rmdFiles <- paste0( "antsxukbb_",
                    c( "format.Rmd",
                       "intro.Rmd",
                       # "whole_brain.Rmd",
                       # "deepflash.Rmd",
                       # "whole_hippocampus_parahippocampus.Rmd"
                      # "mtl.Rmd",
                      # "mtl2.Rmd",
                      # "mrmr.Rmd",
                      # "mrmr_rf_long.Rmd"
                      # "pca_rf.Rmd",
                      # "none_rf.Rmd",
                      # "none_xgb.Rmd"
                       # "none_lm.Rmd",
                       # "none_glmnet.Rmd"
                      # "pca_xgb.Rmd",
                      # "mrmr_xgb.Rmd"
                       # "rf_prediction.Rmd",
                       "compare_predictions.Rmd"
                      # "cortical_thickness.Rmd"
                      # "openneuro_lm.Rmd"
                       # "hippocampus_photoperiod.Rmd"
                     ) )

for( i in 1:length( rmdFiles ) )
  {
  cat( rmdFiles[i] )
  if( i == 1 )
    {
    cmd <- paste( "cat", rmdFiles[i], ">", stitchedFile )
    } else {
    cmd <- paste( "cat", rmdFiles[i], ">>", stitchedFile )
    }
  system( cmd )
  }

render( stitchedFile, output_format = "pdf_document" )
# render( stitchedFile, output_format = "html_document" )
# render( stitchedFile, output_format = "md_document" )
# render( stitchedFile, word_document() )

