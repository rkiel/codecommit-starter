
ANSWERS=answers.bash
source ${ANSWERS}

DEFAULT=~/projects
read -p "Directory to clone [$DEFAULT]: " CLONEDIR
CLONEDIR="${CLONEDIR:-$DEFAULT}"


cd $CLONEDIR
git clone ssh://git-codecommit.${AWSREGION}.amazonaws.com/v1/repos/${AWSREPO}

echo "DONE"
echo
