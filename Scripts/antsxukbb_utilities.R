
AIC.list <- function(object, ..., assess.best=TRUE) {
  allAICs <-
    lapply(object, FUN=function(subobject, ...) {
      ## Return the AIC of the new model relative to the reference model
      if (identical(NA, subobject)) {
        ret <- data.frame(AIC=NA, df=NA, indentation=0)
      } else {
        ret <- stats::AIC(subobject, ...)
        if (is.numeric(ret)) {
          ret <- data.frame(AIC=ret,
                            df=attr(stats::logLik(subobject), "df"),
                            indentation=0)
        } else if (is.data.frame(ret)) {
          if ("indentation" %in% names(ret)) {
            ret$indentation <- ret$indentation + 1
          } else {
            stop("Unknown way to get a data.frame without indentation set.  This is likely a bug.") # nocov
          }
        }
      }
      ret
    })
  retnames <- names(allAICs)
  if (is.null(retnames))
    retnames <- rep("", length(allAICs))
  ret <- data.frame()
  for (i in seq_len(length(allAICs))) {
    tmpAICs <- allAICs[[i]]
    ## If the best value has already been established, drop it for
    ## assessment later.
    tmpAICs$isBest <- NULL
    ## Assign the corret rownames to tmpAICs
    if (!(retnames[i] %in% ""))
      if (nrow(tmpAICs) > 1 |
          !identical(rownames(tmpAICs), as.character(1:nrow(tmpAICs)))) {
        rownames(tmpAICs) <- paste(retnames[i], rownames(tmpAICs))
      } else {
        rownames(tmpAICs) <- retnames[i]
      }
    ## Add tmpAICs to the data frame to return
    ret <- rbind(ret, tmpAICs)
  }
  if (assess.best) {
    ret$isBest <- ""
    ## The next row prevents warnings about no data when na.rm=TRUE
    if (any(!is.na(ret$AIC)))
      ret$isBest[ret$AIC %in% min(ret$AIC, na.rm=TRUE)] <- "Best Model"
  }
  ret
}

get.best.model <- function(object, ...) {
  object[stats::AIC(object, ...)$isBest %in% "Best Model"][[1]]
}

get.first.model <- function(object) {
  ret <- NA
  if (inherits(object, "list")) {
    idx <- 0
    while (identical(NA, ret) & idx < length(object)) {
      idx <- idx + 1
      if (identical(NA, object[[idx]])) {
        ## Do nothing
      } else if (inherits(object[[idx]], "list")) {
        ret <- get.first.model(object[[idx]])
      } else {
        ## It is neither NA or a list, it's our first usable object;
        ## return it.
        ret <- object[[idx]]
      }
    }
  } else {
    ret <- object
  }
  ret
}


##########################################################################################

antsxukbbRegression <- function( data = NULL, modelFormula = NULL, pipelineNames = NULL,
  fontSize = 'normal', label = 'table::', title = "", aicCaption = "" )
{
if( length( data ) != length( pipelineNames ) )
  {
  stop( "Length data is not equal to length of modelNames." )
  }

linearModels <- list()
for( i in seq.int( length( data ) ) )
  {
  linearModels[[i]] <- lm( modelFormula, data[[i]] )
  }

stargazer::stargazer( linearModels,
    type = "latex", header = FALSE, font.size = fontSize,
    column.labels = pipelineNames,
    single.row = TRUE,
    label = label,
    # omit.stat = c( "Observations" ),
    model.numbers = FALSE,
    title = title )

antsxukbbAic <- AIC.list( linearModels )
rownames( antsxukbbAic ) <- pipelineNames
print( knitr::kable( antsxukbbAic, caption = aicCaption ) )
}

##########################################################################################

antsxukbbLinearModel <- function( data, response = "", type = "regression", pipelineNames = NULL, filename = "",
  numberOfPermutations = 100, numberOfTrainingData = 10000, plotTitle = "", modelDescriptions = NULL,
  plotFilename = NULL, plotWidth = 8, plotHeight = 5, plotColorValues = c( "#C3BA45", "#519DB8", "#D92120", "#791C81" ),
  numberOfRankedImportanceVariablesToPrint = 5, doPenalizedRegression = FALSE, glmnetAlpha = 1 )
{

overallPvalue <- function( myModel ) 
{
  f <- summary( myModel )$fstatistic
  p <- pf( f[1], f[2], f[3], lower.tail = F )
  attributes( p ) <- NULL
  return( p )
}
  
measureType <- NULL
if( type == "regression" )
  {
  measureType <- "RMSE"
  } else if( type == "binary" || type == "multi" ) {
  measureType <- "AUC"
  } else {
  stop( "unrecognized type" )
  }

measureDfPerModel <- list()

for( j in seq.int( length( data ) ) )
  {
  filenamePerModel <- sub( ".csv", paste0( "_", pipelineNames[j], ".csv" ), filename )

  if( file.exists( filenamePerModel ) )
    {
    measureDfPerModel[[j]] <- read.csv( filenamePerModel )
    } else {

    completeData <- data[[j]]

    for( n in seq.int( numberOfPermutations ) )
      {
      trainingIndices <- sample.int( nrow( completeData ), numberOfTrainingData )

      trainingData <- completeData[trainingIndices,]
      testingData <- completeData[-trainingIndices,]
      index <- which( colnames( testingData ) == response )

      lmModel <- NULL
      predictLm <- NULL
      lmFormula <- formula( paste0( response, "~ ", paste0( colnames( trainingData )[-index], collapse = "+" ) ) )

      if( doPenalizedRegression )
        {
        if( type == "regression" )
          {
          lmModel <- cv.glmnet( as.matrix( trainingData[,-index] ), trainingData[,index], family = "gaussian", alpha = glmnetAlpha )
          predictLm <- predict( lmModel, newx = as.matrix( testingData[,-index] ), s = "lambda.min" )
          # lmModel <- glmnet( trainingData[,-index], trainingData[,index] ), family = "gaussian", alpha = glmnetAlpha )
          } else if( type == "binary" ) {
          lmModel <- cv.glmnet( as.matrix( trainingData[,-index] ), trainingData[,index], family = "binomial", alpha = glmnetAlpha )
          predictLm <- predict( lmModel, newx = as.matrix( testingData[,-index] ), s = "lambda.min", type = "class" )
          } else {
          lmModel <- cv.glmnet( as.matrix( trainingData[,-index] ), trainingData[,index], family = "multinomial", alpha = glmnetAlpha )

        # x <- as.matrix( trainingData[,-index]  )
        # y <- as.matrix( trainingData[,index] )
        # newx <- as.matrix( testingData[,-index] )
        # save( x, file = "~/Desktop/x.RData" )
        # save( y, file = "~/Desktop/y.RData" )
        # save( lmModel, file = "~/Desktop/lmModel.RData" )
        # save( newx, file = "~/Desktop/newx.RData" )

          predictLm <- predict( lmModel, newx = as.matrix( testingData[,-index] ), s = "lambda.min", type = "class" )
          }
        } else {
        if( type == "regression" )
          {
          lmModel <- lm( lmFormula, trainingData )
          predictLm <- predict( lmModel, testingData[,-index] )
          } else if( type == "binary" ) {
          trainingData[,index] <- as.factor( trainingData[, index] )
          testingData[, index] <- as.factor( testingData[, index] )
          lmModel <- glm( lmFormula, trainingData, family = binomial( link = 'logit' ) )
          predictLm <- predict( lmModel, testingData )
          } else {
          numberOfClasses <- length( unique( trainingData[, index] ) )
          trainingData[,index] <- as.factor( trainingData[, index] )
          testingData[, index] <- as.factor( testingData[, index] )
          # lmModel <- mgcv::gam( list( lmFormula lmFormula, lmFormula ), family = multinom( K = numberOfClasses - 1 ), data = trainingData )
          lmModel <- nnet::multinom( lmFormula, data = trainingData, maxit = 100, MaxNWts = 5000 )
          predictLm <- predict( lmModel, testingData, type = "class" )
          }
        }

      measure <- NULL
      intercept <- NA
      slope <- NA
      rsquared <- NA
      pvalue <- NA
      if( doPenalizedRegression )
        {
        if( type == "regression" )
          {
          measure <- sqrt( mean( ( predictLm - testingData[,index] )^2, na.rm = TRUE ) )
          rmseLm <- lm( formula( "y ~ x" ), data = data.frame( y = testingData[, index], x = predictLm[,1] ) )
          intercept <- rmseLm$coefficients[1]
          slope <- rmseLm$coefficients[2]
          rsquared <- summary( rmseLm )$r.squared
          pvalue <- overallPvalue( rmseLm )
          } else if( type == "binary" ) {
          measure <- auc( testingData[, index], as.numeric( predictLm[,1] ) )
          } else {
          measureRoc <- multiclass.roc( testingData[, index], as.numeric( predictLm[,1] ) )
          measure <- auc( measureRoc )
          }
        } else {
        if( type == "regression" )
          {
          measure <- sqrt( mean( ( predictLm - testingData[,index] )^2, na.rm = TRUE ) )
          rmseLm <- lm( formula( "y ~ x" ), data = data.frame( y = testingData[, index], x = predictLm ) )
          intercept <- rmseLm$coefficients[1]
          slope <- rmseLm$coefficients[2]
          rsquared <- summary( rmseLm )$r.squared
          pvalue <- overallPvalue( rmseLm )
          } else if( type == "binary" ) {
          measure <- auc( testingData[, index], predictLm )
          } else {
          measureRoc <- multiclass.roc( testingData[, index], as.numeric( predictLm ) - 1 )
          measure <- auc( measureRoc )
          }
        }


      importance <- NULL
      if( type == "multi" && doPenalizedRegression == FALSE )
        {
        newdata <- trainingData[, -index]
        predWrapper <- function( model, newdata )
          {
          return( predict( model, newdata = newdata, type = "prob" )[[1]] )
          }
        importance <- fastshap::explain( lmModel, X = newdata, nsim = 1, pred_wrapper = predWrapper )
        importanceMeanScore <- colMeans( abs( importance ) )
        } else {
        vipImp <- vip::vi( lmModel, sort = FALSE )
        importanceMeanScore <- vipImp$Importance
        }
      shapBias <- NA

      singlePermutation <- c( pipelineNames[j],
                              measure,
                              intercept,
                              slope,
                              rsquared,
                              pvalue,
                              as.numeric( shapBias ),
                              as.numeric( as.vector( importanceMeanScore ) ) )

      if( n == 1 )
        {
        measureDfPerModel[[j]] <- singlePermutation
        } else {
        measureDfPerModel[[j]] <- rbind( measureDfPerModel[[j]], singlePermutation )
        colnames( measureDfPerModel[[j]] ) <- c( "Model", measureType, "Intercept", "Slope", "RSquared", "PValue", "ShapBias", colnames( trainingData[, -index] ) )
        rownames( measureDfPerModel[[j]] ) <- NULL
        write.csv( as.data.frame( measureDfPerModel[[j]] ), filenamePerModel, row.names = FALSE, quote = FALSE )
        }
      }
    measureDfPerModel[[j]] <- as.data.frame( measureDfPerModel[[j]] )
    numericColumns <- seq.int( 2, ncol( measureDfPerModel[[j]] ) )
    measureDfPerModel[[j]][numericColumns] <- sapply( measureDfPerModel[[j]][numericColumns], as.numeric )
    }
  }

measureDf <- data.frame( measureDfPerModel[[1]][, c( 1, 2 )] )
if( length( measureDfPerModel ) > 1 )
  {
  for( j in seq.int( from = 2, to = length( measureDfPerModel ) ) )
    {
    measureDf <- rbind( measureDf, data.frame( measureDfPerModel[[j]][, c( 1, 2 )] ) )
    }
  }
measureDf[,2] <- as.numeric( measureDf[,2] )

measureDf$Model <- factor( measureDf$Model, levels = pipelineNames )
colnames( measureDf )[2] <- "Measure"
lmPlot <- ggplot( data = measureDf ) +
             geom_jitter( aes( y = Measure, x = Model, color = Model ), alpha = 0.25 ) +
             geom_boxplot( aes( y = Measure, x = Model, fill = Model ), alpha = 0.75 ) +
             ggtitle( plotTitle ) +
             theme( legend.position = "none" ) +
             ylab( measureType ) +
             # theme( axis.text.x = element_text( angle = 45, vjust = 1, hjust=1 ) ) +
             scale_fill_manual( values = plotColorValues ) +
             scale_color_manual( values = plotColorValues ) +
             theme( axis.text.x = element_text( face = "bold" ) )
ggplot2::ggsave( paste0( plotFilename, ".pdf" ), lmPlot, width = plotWidth, height = plotHeight, units = "in" )

# AOV information and plots

measure.aov <- aov( Measure ~ Model, data = measureDf )
measure.anova <- anova( measure.aov )

print( knitr::kable( measure.anova ) )

measure.tukey <- TukeyHSD( measure.aov, "Model", ordered = FALSE )
measure.tukey.df <- as.data.frame( measure.tukey$Model )
measure.tukey.df$pair <- rownames( measure.tukey.df )

measure.tukey.plot <- ggplot( data = measure.tukey.df, aes( linetype = cut(`p adj`, c( -0.001, 0.01, 0.05, 1 ),
                              label = c( " p<0.01", "p<0.05", "nonsignificant" ) ) ) ) +
                              geom_vline( xintercept = 0, lty = "11", colour = "black" ) +
                              geom_errorbarh( aes( y = pair, xmin = lwr, xmax = upr ), colour = "black" ) +
                              geom_point( aes( diff, pair ), size = 3 ) +
                              labs( x = TeX( paste0( "$\\Delta$", measureType ) ), y = "" ) +
                              theme( legend.title = element_blank() ) +
                              theme( legend.position = "none" ) +
                              theme( axis.text.y = element_text( size = 10, face = "bold" ) )
ggplot2::ggsave( paste0( plotFilename, "AOV.pdf" ), measure.tukey.plot, width = 6, height = 3, units = "in" )

## Print importance information

for( i in seq.int( length( measureDfPerModel ) ) )
  {
  importanceAverage <- abs( colMeans( measureDfPerModel[[i]][, -c( 1, 2, 3, 4, 5, 6, 7 )] ) )
  orderedDescriptions <- modelDescriptions[[i]][order( importanceAverage, decreasing = TRUE )]
  orderedImportanceAverage <- importanceAverage[order( importanceAverage, decreasing = TRUE )]

  cat( "\n\n**Pipeline:** ", pipelineNames[i], "\n" )

  importanceDf <- data.frame( Description = orderedDescriptions[1:numberOfRankedImportanceVariablesToPrint],
                              MeanImportanceValue = orderedImportanceAverage[1:numberOfRankedImportanceVariablesToPrint]
                            )
  rownames( importanceDf ) <- NULL

  print( knitr::kable( importanceDf, digits = 3 ) )
  # for( j in seq.int( numberOfRankedImportanceVariablesToPrint ) )
  #    {
  #   cat( "* ", orderedDescriptions[j], "  (", orderedImportanceAverage[j], ")\n\n", sep = "" )
  #   }
  }

if( type == "regression" )
  {
  ## Predict vs. test values

  measureLmDf <- data.frame( measureDfPerModel[[1]][, c( 1, 3, 4 )] )
  for( j in seq( 2, length( measureDfPerModel ) ) )
    {
    measureLmDf <- rbind( measureLmDf, data.frame( measureDfPerModel[[j]][, c( 1, 3, 4 )] ) )
    }

  measureLmDf$Model <- factor( measureLmDf$Model, levels = pipelineNames )

  uniqueModels <- unique( measureLmDf$Model )
  measureLmDfMedian <- data.frame()
  for( j in seq.int( length( uniqueModels ) ) )
    {
    measureLmDfPerModel <- measureLmDf[which( measureLmDf$Model == uniqueModels[j] ),]
    if( j == 1 )
      {
      measureLmDfMedian <- measureLmDfPerModel[order( measureLmDfPerModel$Slope ),][floor( 0.5 * nrow( measureLmDfPerModel ) ),]
      } else {
      measureLmDfMedian <- rbind( measureLmDfMedian, measureLmDfPerModel[order( measureLmDfPerModel$Slope ),][floor( 0.5 * nrow( measureLmDfPerModel ) ),] )
      }
    }

  xgbPlot <- ggplot( data = measureLmDf ) +
              geom_abline( aes( slope = Slope, intercept = Intercept, color = Model, linetype = Model ), alpha = 1.0 ) +
              ggtitle( plotTitle ) +
              #  theme( legend.position = "none" ) +
              # theme( axis.text.x = element_text( angle = 45, vjust = 1, hjust=1 ) ) +
              scale_x_continuous( name = "Actual", limits = range( data[[1]][,1] ) ) +
              scale_y_continuous( name = "Predicted", limits = range( data[[1]][,1] ) ) +
              scale_fill_manual( values = plotColorValues ) +
              scale_color_manual( values = plotColorValues ) +
              theme( axis.text.x = element_text( face = "bold" ) )
  ggplot2::ggsave( paste0( plotFilename, "RegressionLines.pdf" ), xgbPlot,
      width = 1.35 * plotWidth, height = plotHeight, units = "in" )

  # Ribbon

  rmseLmDfPerModel <- list()
  rmseRibbonDfPerModel <- list()
  for( j in seq( 1, length( measureDfPerModel ) ) )
    {
    localDf <- data.frame( measureDfPerModel[[j]][, c( 1, 3, 4 )] )

    maxIndex <- which.max( localDf$Slope )
    maxM <- localDf$Slope[maxIndex]
    maxB <- localDf$Intercept[maxIndex]

    minIndex <- which.min( localDf$Slope )
    minM <- localDf$Slope[minIndex]
    minB <- localDf$Intercept[minIndex]

    xCross <- ( minB - maxB ) / ( maxM - minM )
    yCross <- maxM * xCross + maxB

    plotRange <- range( data[[j]][,1] )
    values <- seq( from = plotRange[1], to = plotRange[2], length.out = 100 )
    yMaxValues <- maxM * values + maxB
    yMinValues <- minM * values + minB

    rmseLmDfPerModel[[j]] <- data.frame( Model = rep( pipelineNames[j], 2 ),
                                        Slope = c( maxM, minM ),
                                        Intercept = c( maxB, minB )
                                      )

    rmseRibbonDfPerModel[[j]] <- data.frame( Model = rep( pipelineNames[j], length( yMaxValues ) ),
                                            IntersectionPoint.X = rep( xCross, length( yMaxValues ) ),
                                            IntersectionPoint.Y = rep( yCross, length( yMaxValues ) ),
                                            x = values,
                                            ymin = yMinValues,
                                            ymax = yMaxValues )
    }

  rmseLmDf <- rmseLmDfPerModel[[1]]
  rmseRibbonDf <- rmseRibbonDfPerModel[[1]]
  for( j in seq( 2, length( rmseRibbonDfPerModel ) ) )
    {
    rmseLmDf <- rbind( rmseLmDf, rmseLmDfPerModel[[j]] )
    rmseRibbonDf <- rbind( rmseRibbonDf, rmseRibbonDfPerModel[[j]] )
    }
  rmseLmDf$Model <- factor( rmseLmDf$Model, levels = pipelineNames )
  rmseRibbonDf$Model <- factor( rmseRibbonDf$Model, levels = pipelineNames )

  lmPlot <- ggplot( data = rmseLmDf ) +
              #  geom_abline( aes( slope = Slope, intercept = Intercept, color = Model ), alpha = 0.5 ) +
              geom_ribbon( data = subset( rmseRibbonDf, x > IntersectionPoint.X ),
                            aes( x = x, ymax = ymin, ymin = ymax, fill = Model ), alpha = 0.2 ) +
              geom_ribbon( data = subset( rmseRibbonDf, x < IntersectionPoint.X ),
                            aes( x = x, ymax = ymax, ymin = ymin, fill = Model ), alpha = 0.2 ) +
              geom_abline( data = measureLmDfMedian, aes( slope = Slope, intercept = Intercept, color = Model, linetype = Model ), alpha = 1.0 ) +
              ggtitle( plotTitle ) +
              #  theme( legend.position = "none" ) +
              # theme( axis.text.x = element_text( angle = 45, vjust = 1, hjust=1 ) ) +
              scale_fill_manual( values = plotColorValues ) +
              scale_color_manual( values = plotColorValues ) +
              scale_x_continuous( name = "Actual", limits = range( data[[1]][,1] ) ) +
              scale_y_continuous( name = "Predicted", limits = range( data[[1]][,1] ) ) +
              theme( axis.text.x = element_text( face = "bold" ) )
  ggplot2::ggsave( paste0( plotFilename, "RegressionRegion.pdf" ), lmPlot, width = 1.35 * plotWidth, height = plotHeight, units = "in" )
  }

}


##########################################################################################

##########################################################################################

antsxukbbXgboost <- function( data, response = "", type = "regression", pipelineNames = NULL, filename = "",
  numberOfPermutations = 100, numberOfTrainingData = 10000, plotTitle = "", modelDescriptions = NULL,
  plotFilename = NULL, plotWidth = 8, plotHeight = 5, plotColorValues = c( "#C3BA45", "#519DB8", "#D92120", "#791C81" ),
  numberOfRankedImportanceVariablesToPrint = 5 )
{

shap.values.multiclass <- function(xgb_model, X_train)
  {
  shap_contrib_per_class <- predict(xgb_model, (X_train), predcontrib = TRUE)
  shap_contrib <- shap_contrib_per_class[[1]]
  for( i in seq.int( 2, length( shap_contrib_per_class ) ) )
    {
    shap_contrib <- shap_contrib + shap_contrib_per_class[[i]]
    }
  shap_contrib <- shap_contrib / length( shap_contrib_per_class )
  if (is.null(colnames(shap_contrib))) {
      colnames(shap_contrib) <- c(colnames(X_train), "BIAS")
  }
  shap_contrib <- data.table::as.data.table(shap_contrib)
  BIAS0 <- shap_contrib[, ncol(shap_contrib), with = FALSE][1]
  shap_contrib[, `:=`(BIAS, NULL)]
  imp <- colMeans(abs(shap_contrib))
  mean_shap_score <- imp[order(imp, decreasing = T)]
  return(list(shap_score = shap_contrib, mean_shap_score = mean_shap_score,
      BIAS0 = BIAS0))
  }

# "For future reference, here (by averaging the SHAP values of the individual models) you are
# getting the SHAP values of the ensemble model that is the average of the log odds predictions
# of the 10 individual models."
# https://github.com/slundberg/shap/issues/337#issuecomment-441710372


numberOfCores <- detectCores()

measureType <- NULL
if( type == "regression" )
  {
  measureType <- "RMSE"
  } else if( type == "binary" || type == "multi" ) {
  measureType <- "AUC"
  } else {
  stop( "unrecognized type" )
  }


measureDfPerModel <- list()

for( j in seq.int( length( data ) ) )
  {
  filenamePerModel <- sub( ".csv", paste0( "_", pipelineNames[j], ".csv" ), filename )

  if( file.exists( filenamePerModel ) )
    {
    measureDfPerModel[[j]] <- read.csv( filenamePerModel )
    } else {

    completeData <- data[[j]]

    for( n in seq.int( numberOfPermutations ) )
      {
      trainingIndices <- sample.int( nrow( completeData ), numberOfTrainingData )
      trainingData <- completeData[trainingIndices,]
      testingData <- completeData[-trainingIndices,]

      index <- which( colnames( testingData ) == response )
      xgbTrainingData <- xgb.DMatrix( data = as.matrix( trainingData[, -index] ), label = trainingData[, index] )
      xgbTestingData <- xgb.DMatrix( data = as.matrix( testingData[, -index] ), label = testingData[, index] )

      obj <- NULL
      numberOfClasses <- 0
      if( type == "regression" )
        {
        obj <- "reg:squarederror"
        } else if( type == "binary" ) {
        obj <- "binary:logistic"
        } else if( type == "multi" ) {
        obj <- "multi:softmax"
        numberOfClasses <- length( unique( testingData[, index] ) )
        }
      xgb <- NULL
      if( type == "regression" || type == "binary" )
        {
        xgb <- xgboost( data = xgbTrainingData, max.depth = 6, early_stopping_rounds = 10,
                        nrounds = 1000, nthread = numberOfCores, verbose = 0,
                        objective = obj )
        } else {
        xgb <- xgboost( data = xgbTrainingData, max.depth = 6, early_stopping_rounds = 10,
                        nrounds = 1000, nthread = numberOfCores, verbose = 0,
                        objective = obj, num_class = numberOfClasses )
        }
      predictXgb <- predict( xgb, xgbTestingData )

      measure <- NULL
      intercept <- NA
      slope <- NA
      if( type == "regression" )
        {
        measure <- sqrt( mean( ( predictXgb - testingData[, index] )^2, na.rm = TRUE ) )
        rmseLm <- lm( formula( "y ~ x" ), data = data.frame( y = testingData[, index], x = predictXgb ) )
        intercept <- rmseLm$coefficients[1]
        slope <- rmseLm$coefficients[2]
        } else if( type == "binary" ) {
        measure <- auc( testingData[, index], predictXgb )
        } else {
        measureRoc <- multiclass.roc( testingData[, index], predictXgb )
        measure <- auc( measureRoc )
        }

      shap <- NULL
      if( type == "multi" )
        {
        shap <- shap.values.multiclass( xgb, X_train = as.matrix( trainingData[, -index] ) )
        } else {
        shap <- shap.values( xgb, X_train = as.matrix( trainingData[, -index] ) )
        }
      shapMeanScore <- shap$mean_shap_score[order(
          factor( names( shap$mean_shap_score ), levels = colnames( trainingData[, -index] ) ) )]
      shapBias <- shap$BIAS0

      singlePermutation <- c( pipelineNames[j],
                              measure,
                              intercept,
                              slope,
                              as.numeric( shapBias ),
                              as.numeric( as.vector( shapMeanScore ) ) )

      if( n == 1 )
        {
        measureDfPerModel[[j]] <- singlePermutation
        } else {
        measureDfPerModel[[j]] <- rbind( measureDfPerModel[[j]], singlePermutation )
        colnames( measureDfPerModel[[j]] ) <- c( "Model", measureType, "Intercept", "Slope", "ShapBias", colnames( trainingData[, -index] ) )
        rownames( measureDfPerModel[[j]] ) <- NULL
        write.csv( as.data.frame( measureDfPerModel[[j]] ), filenamePerModel, row.names = FALSE, quote = FALSE )
        }
      }
    measureDfPerModel[[j]] <- as.data.frame( measureDfPerModel[[j]] )
    numericColumns <- seq.int( 2, ncol( measureDfPerModel[[j]] ) )
    measureDfPerModel[[j]][numericColumns] <- sapply( measureDfPerModel[[j]][numericColumns], as.numeric )
    }
  }

measureDf <- data.frame( measureDfPerModel[[1]][, c( 1, 2 )] )
for( j in seq( 2, length( measureDfPerModel ) ) )
  {
  measureDf <- rbind( measureDf, data.frame( measureDfPerModel[[j]][, c( 1, 2 )] ) )
  }
measureDf[,2] <- as.numeric( measureDf[,2] )

measureDf$Model <- factor( measureDf$Model, levels = pipelineNames )
colnames( measureDf )[2] <- "Measure"
xgbPlot <- ggplot( data = measureDf ) +
             geom_jitter( aes( y = Measure, x = Model, color = Model ), alpha = 0.25 ) +
             geom_boxplot( aes( y = Measure, x = Model, fill = Model ), alpha = 0.75 ) +
             ggtitle( plotTitle ) +
             theme( legend.position = "none" ) +
             ylab( measureType ) +
             # theme( axis.text.x = element_text( angle = 45, vjust = 1, hjust=1 ) ) +
             scale_fill_manual( values = plotColorValues ) +
             scale_color_manual( values = plotColorValues ) +
             theme( axis.text.x = element_text( face = "bold" ) )
ggplot2::ggsave( paste0( plotFilename, ".pdf" ), xgbPlot, width = plotWidth, height = plotHeight, units = "in" )

# AOV information and plots

measure.aov <- aov( Measure ~ Model, data = measureDf )
measure.anova <- anova( measure.aov )

print( knitr::kable( measure.anova ) )

measure.tukey <- TukeyHSD( measure.aov, "Model", ordered = FALSE )
measure.tukey.df <- as.data.frame( measure.tukey$Model )
measure.tukey.df$pair <- rownames( measure.tukey.df )

measure.tukey.plot <- ggplot( data = measure.tukey.df, aes( linetype = cut(`p adj`, c( -0.001, 0.01, 0.05, 1 ),
                              label = c( " p<0.01", "p<0.05", "nonsignificant" ) ) ) ) +
                              geom_vline( xintercept = 0, lty = "11", colour = "black" ) +
                              geom_errorbarh( aes( y = pair, xmin = lwr, xmax = upr ), colour = "black" ) +
                              geom_point( aes( diff, pair ), size = 3 ) +
                              labs( x = TeX( paste0( "$\\Delta$", measureType ) ), y = "" ) +
                              theme( legend.title = element_blank() ) +
                              theme( legend.position = "none" ) +
                              theme( axis.text.y = element_text( size = 10, face = "bold" ) )
ggplot2::ggsave( paste0( plotFilename, "AOV.pdf" ), measure.tukey.plot, width = 6, height = 3, units = "in" )

## Print importance information

for( i in seq.int( length( measureDfPerModel ) ) )
  {
  importanceAverage <- abs( colMeans( measureDfPerModel[[i]][, -c( 1, 2, 3, 4, 5 )] ) )
  orderedDescriptions <- modelDescriptions[[i]][order( importanceAverage, decreasing = TRUE )]
  orderedImportanceAverage <- importanceAverage[order( importanceAverage, decreasing = TRUE )]

  cat( "\n\n**Pipeline:** ", pipelineNames[i], "\n" )

  importanceDf <- data.frame( Description = orderedDescriptions[1:numberOfRankedImportanceVariablesToPrint],
                              MeanShapValue = orderedImportanceAverage[1:numberOfRankedImportanceVariablesToPrint]
                            )
  rownames( importanceDf ) <- NULL

  print( knitr::kable( importanceDf, digits = 3 ) )
  # for( j in seq.int( numberOfRankedImportanceVariablesToPrint ) )
  #    {
  #   cat( "* ", orderedDescriptions[j], "  (", orderedImportanceAverage[j], ")\n\n", sep = "" )
  #   }
  }

if( type == "regression" )
  {
  ## Predict vs. test values

  measureLmDf <- data.frame( measureDfPerModel[[1]][, c( 1, 3, 4 )] )
  for( j in seq( 2, length( measureDfPerModel ) ) )
    {
    measureLmDf <- rbind( measureLmDf, data.frame( measureDfPerModel[[j]][, c( 1, 3, 4 )] ) )
    }
  measureLmDf$Model <- factor( measureLmDf$Model, levels = pipelineNames )
  xgbPlot <- ggplot( data = measureLmDf ) +
              geom_abline( aes( slope = Slope, intercept = Intercept, color = Model ), alpha = 0.5 ) +
              ggtitle( plotTitle ) +
              #  theme( legend.position = "none" ) +
              # theme( axis.text.x = element_text( angle = 45, vjust = 1, hjust=1 ) ) +
              scale_x_continuous( name = "Actual", limits = range( data[[1]][,1] ) ) +
              scale_y_continuous( name = "Predicted", limits = range( data[[1]][,1] ) ) +
              scale_fill_manual( values = plotColorValues ) +
              scale_color_manual( values = plotColorValues ) +
              theme( axis.text.x = element_text( face = "bold" ) )
  ggplot2::ggsave( paste0( plotFilename, "RegressionLines.pdf" ), xgbPlot,
      width = 1.35 * plotWidth, height = plotHeight, units = "in" )

  # Ribbon

  rmseLmDfPerModel <- list()
  rmseRibbonDfPerModel <- list()
  for( j in seq( 1, length( measureDfPerModel ) ) )
    {
    localDf <- data.frame( measureDfPerModel[[j]][, c( 1, 3, 4 )] )

    maxIndex <- which.max( localDf$Slope )
    maxM <- localDf$Slope[maxIndex]
    maxB <- localDf$Intercept[maxIndex]

    minIndex <- which.min( localDf$Slope )
    minM <- localDf$Slope[minIndex]
    minB <- localDf$Intercept[minIndex]

    xCross <- ( minB - maxB ) / ( maxM - minM )
    yCross <- maxM * xCross + maxB

    plotRange <- range( data[[j]][,1] )
    values <- seq( from = plotRange[1], to = plotRange[2], length.out = 100 )
    yMaxValues <- maxM * values + maxB
    yMinValues <- minM * values + minB

    rmseLmDfPerModel[[j]] <- data.frame( Model = rep( pipelineNames[j], 2 ),
                                        Slope = c( maxM, minM ),
                                        Intercept = c( maxB, minB )
                                      )

    rmseRibbonDfPerModel[[j]] <- data.frame( Model = rep( pipelineNames[j], length( yMaxValues ) ),
                                            IntersectionPoint.X = rep( xCross, length( yMaxValues ) ),
                                            IntersectionPoint.Y = rep( yCross, length( yMaxValues ) ),
                                            x = values,
                                            ymin = yMinValues,
                                            ymax = yMaxValues )
    }

  rmseLmDf <- rmseLmDfPerModel[[1]]
  rmseRibbonDf <- rmseRibbonDfPerModel[[1]]
  for( j in seq( 2, length( rmseRibbonDfPerModel ) ) )
    {
    rmseLmDf <- rbind( rmseLmDf, rmseLmDfPerModel[[j]] )
    rmseRibbonDf <- rbind( rmseRibbonDf, rmseRibbonDfPerModel[[j]] )
    }
  rmseLmDf$Model <- factor( rmseLmDf$Model, levels = pipelineNames )
  rmseRibbonDf$Model <- factor( rmseRibbonDf$Model, levels = pipelineNames )

  xgbPlot <- ggplot( data = rmseLmDf ) +
              #  geom_abline( aes( slope = Slope, intercept = Intercept, color = Model ), alpha = 0.5 ) +
              geom_ribbon( data = subset( rmseRibbonDf, x > IntersectionPoint.X ),
                            aes( x = x, ymax = ymin, ymin = ymax, fill = Model ), alpha = 0.5 ) +
              geom_ribbon( data = subset( rmseRibbonDf, x < IntersectionPoint.X ),
                            aes( x = x, ymax = ymax, ymin = ymin, fill = Model ), alpha = 0.5 ) +
              ggtitle( plotTitle ) +
              #  theme( legend.position = "none" ) +
              # theme( axis.text.x = element_text( angle = 45, vjust = 1, hjust=1 ) ) +
              scale_fill_manual( values = plotColorValues ) +
              scale_color_manual( values = plotColorValues ) +
              scale_x_continuous( name = "Actual", limits = range( data[[1]][,1] ) ) +
              scale_y_continuous( name = "Predicted", limits = range( data[[1]][,1] ) ) +
              theme( axis.text.x = element_text( face = "bold" ) )
  ggplot2::ggsave( paste0( plotFilename, "RegressionRegion.pdf" ), xgbPlot, width = 1.35 * plotWidth, height = plotHeight, units = "in" )
  }
}


#########################################################################################


# antsxukbbRandomForest <- function( data = NULL, modelFormula = NULL, pipelineNames = NULL, filename = "",
#   numberOfPermutations = 100, numberOfTrainingData = 10000, plotTitle = "", modelDescriptions = NULL,
#   plotFilename = NULL, plotWidth = 8, plotHeight = 5, plotColorValues = c( "#C3BA45", "#519DB8", "#D92120", "#791C81" ),
#   numberOfRankedImportanceVariablesToPrint = 5 )
# {

# importanceFilenames <- c()
# for( j in seq.int( length( data ) ) )
#   {
#   importanceFilenames[j] <- sub( ".csv", paste0( "_importance_", pipelineNames[j], ".csv" ), filename )
#   }

# if( file.exists( filename ) )
#   {
#   rmseDf <- read.csv( filename )
#   } else {

#   numberOfCores <- detectCores()
#   cl <- makeCluster( numberOfCores )
#   registerDoParallel( cl )

#   rfImportance <- list()
#   for( j in seq.int( length( data ) ) )
#     {
#     completeData <- data[[j]]

#     for( n in seq.int( numberOfPermutations ) )
#       {
#       trainingIndices <- sample.int( nrow( completeData ), numberOfTrainingData )
#       trainingData <- completeData[trainingIndices,]

#       rf <- foreach( ntree = rep( 20, 20 ), .combine = combine, .packages = 'randomForest' ) %dopar%
#         randomForest( modelFormula, trainingData, ntree = ntree, importance = TRUE )

#       testingData <- completeData[-trainingIndices,]
#       predictRf <- predict( rf, testingData )

#       rmse <- sqrt( mean( ( predictRf - testingData[,1] )^2, na.rm = TRUE ) )

#       if( j == 1 && n == 1 )
#         {
#         rmseDf <- data.frame( Model = pipelineNames[j], RMSE = rmse )
#         } else {
#         rmseDf <- rbind( rmseDf, data.frame( Model = pipelineNames[j], RMSE = rmse ) )
#         }

#       if( n == 1 )
#         {
#         rfImportance[[j]] <- importance( rf, type = 1 )
#         } else {
#         rfImportance[[j]] <- ( ( rfImportance[[j]] * ( n - 1 ) ) + importance( rf, type = 1 ) ) / n
#         }

#       colnames( rmseDf ) <- c( "Model", "RMSE" )
#       write.csv( rmseDf, filename, row.names = FALSE, quote = FALSE )
#       write.csv( rfImportance[[j]], importanceFilenames[j], row.names = TRUE, quote = FALSE )
#       }
#     }
#   }

# rmseDf$Model <- factor( rmseDf$Model, levels = pipelineNames )
# rfPlot <- ggplot( data = rmseDf ) +
#              geom_jitter( aes( y = RMSE, x = Model, color = Model ), alpha = 0.25 ) +
#              geom_boxplot( aes( y = RMSE, x = Model, fill = Model ), alpha = 0.75 ) +
#              ggtitle( plotTitle ) +
#              theme( legend.position = "none" ) +
#              # theme( axis.text.x = element_text( angle = 45, vjust = 1, hjust=1 ) ) +
#              scale_fill_manual( values = plotColorValues ) +
#              scale_color_manual( values = plotColorValues ) +
#              theme( axis.text.x = element_text( face = "bold" ) )
# ggplot2::ggsave( paste0( plotFilename, ".pdf" ), rfPlot, width = plotWidth, height = plotHeight, units = "in" )

# ## AOV information and plots

# rmseDf$RMSE <- rmseDf$RMSE
# rmse.aov <- aov( RMSE ~ Model, data = rmseDf )
# rmse.anova <- anova( rmse.aov )

# print( knitr::kable( rmse.anova ) )

# rmse.tukey <- TukeyHSD( rmse.aov, "Model", ordered = FALSE )
# rmse.tukey.df <- as.data.frame( rmse.tukey$Model )
# rmse.tukey.df$pair <- rownames( rmse.tukey.df )

# rmse.tukey.plot <- ggplot( data = rmse.tukey.df, aes( linetype = cut(`p adj`, c( -0.001, 0.01, 0.05, 1 ),
#                              label = c( " p<0.01", "p<0.05", "nonsignificant" ) ) ) ) +
#                            geom_vline( xintercept = 0, lty = "11", colour = "black" ) +
#                            geom_errorbarh( aes( y = pair, xmin = lwr, xmax = upr ), colour = "black" ) +
#                            geom_point( aes( diff, pair ), size = 3 ) +
#                            labs( x = TeX( "$\\Delta$ RMSE" ), y = "" ) +
#                            theme( legend.title = element_blank() ) +
#                            theme( legend.position = "none" ) +
#                            theme( axis.text.y = element_text( size = 10, face = "bold" ) )
# ggplot2::ggsave( paste0( plotFilename, "AOV.pdf" ), rmse.tukey.plot, width = 6, height = 3, units = "in" )

# ## Get importance information

# rfImportance <- list()
# for( i in seq.int( length( importanceFilenames ) ) )
#   {
#   if( file.exists( importanceFilenames[i] ) )
#     {
#     rfImportance[[i]] <- read.csv( importanceFilenames[i] )
#     colnames( rfImportance[[i]] )[1] <- "Field.ID"

#     if( ! is.null( modelDescriptions ) )
#       {
#       rfDescription <- modelDescriptions[[i]]
#       rfDescription <- rfDescription[which( rfDescription != "Subject" )]
#       rfImportance[[i]]$Description <- rfDescription[which( rfDescription != "Subject" )]
#       }

#     impSort <- sort( rfImportance[[i]][,2], decreasing = TRUE, index.return = TRUE )
#     rfImportance[[i]] <- rfImportance[[i]][impSort$ix,]

#     cat( "\n\n**Pipeline:** ", pipelineNames[i], "\n" )
#     for( j in seq.int( numberOfRankedImportanceVariablesToPrint ) )
#       {
#       field <- rfImportance[[i]]$Description[j]
#       cat( "* ", field, "\n\n" )
#       }
#     }
#   }
# }

###########################################################################################

