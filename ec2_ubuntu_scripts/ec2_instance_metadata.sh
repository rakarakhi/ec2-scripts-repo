#1/bin/bash
#https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html
#
for i in `curl http://169.254.169.254/latest/meta-data/`
do 
	echo "${i} is `curl http://169.254.169.254/latest/meta-data/${i}`"
done;
