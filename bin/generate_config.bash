
ANSWERS=answers.bash
source ${ANSWERS}

AWSSSHID=$(aws iam list-ssh-public-keys --user-name ${AWSUSER}|grep SSHPublicKeyId|awk '{print $2}'|sed 's/",//'|sed 's/"//')

SSHCONFIG=~/.ssh/config

echo "Config looks like:"
touch ${SSHCONFIG} && cat ${SSHCONFIG}
echo

DEFAULT="no"
read -p "Remove config [$DEFAULT]: " REMOVECONFIG
REMOVECONFIG="${REMOVECONFIG:-$DEFAULT}"

if [ "$REMOVECONFIG" == "yes" ]
then
  echo "Removing config"
  rm -rf ${SSHCONFIG}
fi

echo "Adding Host to config"
echo "Host git-codecommit.${AWSREGION}.amazonaws.com" >> ${SSHCONFIG}
echo "  User ${AWSSSHID}" >> ${SSHCONFIG}
echo "  IdentityFile ${SSHFILE}" >> ${SSHCONFIG}
chmod 600 ${SSHCONFIG}

echo "DONE"
echo
