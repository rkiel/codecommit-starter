
ANSWERS=answers.bash
echo
echo "Reading ${ANSWERS}"
echo
touch ${ANSWERS} && chmod 600 ${ANSWERS} && source ${ANSWERS}

DEFAULT=~/projects
read -p "Directory to clone [$DEFAULT]: " CLONEDIR
CLONEDIR="${CLONEDIR:-$DEFAULT}"

cd $CLONEDIR
git clone ssh://git-codecommit.${AWSREGION}.amazonaws.com/v1/repos/${AWSREPO}

echo
echo "DONE"
echo
