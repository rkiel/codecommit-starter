
ANSWERS=answers.bash
echo
echo "Reading ${ANSWERS}"
echo
touch ${ANSWERS} && chmod 600 ${ANSWERS} && source ${ANSWERS}

echo
echo "Retrieving public key id"
echo
AWSSSHID=$(aws iam list-ssh-public-keys --user-name ${AWSUSER}|grep SSHPublicKeyId|awk '{print $2}'|sed 's/",//'|sed 's/"//')

SSHCONFIG=~/.ssh/config

echo
echo "Current config contains:"
echo
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

echo
echo "Adding Host to config"
echo
echo "Host git-codecommit.${AWSREGION}.amazonaws.com" >> ${SSHCONFIG}
echo "  User ${AWSSSHID}" >> ${SSHCONFIG}
echo "  IdentityFile ${SSHFILE}" >> ${SSHCONFIG}
chmod 600 ${SSHCONFIG}

echo
echo "DONE"
echo
