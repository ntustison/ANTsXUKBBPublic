
baseDir=/Users/ntustison/Data/HCP/

for i in `aws s3 ls s3://hcp-openaccess/HCP_1200/ | awk '{print $2}'`; 
  do 
    subject=${i/\//}; 
    
    echo $subject; 

    mkdir -p ${baseDir}/HCP_1200/${subject}/unprocessed/3T/T1w_MPR1
    mkdir -p ${baseDir}/HCP_1200/${subject}/unprocessed/3T/T2w_SPC1

    aws s3 cp \
            s3://hcp-openaccess/HCP_1200/$subject/unprocessed/3T/T1w_MPR1/ \
            ${baseDir}/HCP_1200/${subject}/unprocessed/3T/T1w_MPR1/ \
            --recursive \
            --region us-east-1  

    aws s3 cp \
            s3://hcp-openaccess/HCP_1200/$subject/unprocessed/3T/T2w_SPC1/ \
            ${baseDir}/HCP_1200/${subject}/unprocessed/3T/T2w_SPC1/ \
            --recursive \
            --region us-east-1  

  done