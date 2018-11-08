
ANSWERS=answers.bash
echo
echo "Reading ${ANSWERS}"
echo
touch ${ANSWERS} && chmod 600 ${ANSWERS} && source ${ANSWERS}

DEFAULT="my-first-repository"
read -p "CodeCommit Repository Name [$DEFAULT]: " AWSREPO
AWSREPO="${AWSREPO:-$DEFAULT}"

DEFAULT="us-east-1"
read -p "Repository in AWS Region [$DEFAULT]: " AWSREGION
AWSREGION="${AWSREGION:-$DEFAULT}"

echo
echo "Saving ${ANSWERS}"
echo
echo AWSREPO=${AWSREPO} >> ${ANSWERS}
echo AWSREGION=${AWSREGION} >> ${ANSWERS}

echo
echo "Creating repository: ${AWSREPO}"
echo
aws codecommit create-repository --repository-name ${AWSREPO} --region ${AWSREGION}

echo "DONE"
echo
