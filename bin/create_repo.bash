
ANSWERS=answers.bash

DEFAULT="my-first-repository"
read -p "CodeCommit Repository Name [$DEFAULT]: " AWSREPO
AWSREPO="${AWSREPO:-$DEFAULT}"

DEFAULT="us-east-1"
read -p "Repository in AWS Region [$DEFAULT]: " AWSREGION
AWSREGION="${AWSREGION:-$DEFAULT}"

aws codecommit create-repository --repository-name ${AWSREPO} --region ${AWSREGION}

echo AWSREPO=${AWSREPO} >> ${ANSWERS}
echo AWSREGION=${AWSREGION} >> ${ANSWERS}

echo "DONE"
echo
