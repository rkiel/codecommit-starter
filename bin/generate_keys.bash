
ANSWERS=answers.bash
echo
echo "Reading ${ANSWERS}"
echo
touch ${ANSWERS} && chmod 600 ${ANSWERS} && source ${ANSWERS}

DEFAULT=$USER
read -p "AWS User Name [$DEFAULT]: " AWSUSER
AWSUSER="${AWSUSER:-$DEFAULT}"

DEFAULT="aws-codecommit-${AWSREGION}"
read -p "SSH File Name [$DEFAULT]: " SSHNAME
SSHNAME="${SSHNAME:-$DEFAULT}"

DEFAULT="rsa"
read -p "SSH Key Type [$DEFAULT]: " SSHTYPE
SSHTYPE="${SSHTYPE:-$DEFAULT}"


DEFAULT="2048"
read -p "SSH Key Bit Strength [$DEFAULT]: " SSHBITS
SSHBITS="${SSHBITS:-$DEFAULT}"

DEFAULT="DontTellAnyoneMyPassphrase"
read -p "SSH Passphrase [$DEFAULT]: " SSHPASSPHRASE
SSHPASSPHRASE="${SSHPASSPHRASE:-$DEFAULT}"

SSHFILE=~/.ssh/${SSHNAME}

echo
echo "Saving ${ANSWERS}"
echo
echo AWSUSER=${AWSUSER} >> ${ANSWERS}
echo SSHNAME=${SSHNAME} >> ${ANSWERS}
echo SSHTYPE=${SSHTYPE} >> ${ANSWERS}
echo SSHBITS=${SSHBITS} >> ${ANSWERS}
echo SSHPASSPHRASE=\"${SSHPASSPHRASE}\" >> ${ANSWERS}
echo SSHFILE=${SSHFILE} >> ${ANSWERS}

echo
echo "Creating cryptologic keys"
echo
rm -rf ${SSHFILE}*
ssh-keygen -b ${SSHBITS} -t ${SSHTYPE} -f ${SSHFILE} -C ${SSHNAME} -P "${SSHPASSPHRASE}"
chmod 600 ${SSHFILE}*

echo
echo "Uploading public key"
echo
aws iam upload-ssh-public-key --user-name ${AWSUSER} --ssh-public-key-body "$(cat ${SSHFILE}.pub)"

echo
echo "Here is your passphrase:"
echo $SSHPASSPHRASE
echo
echo "Add passphrase to SSH Agent"
echo
ssh-add ${SSHFILE}

echo
echo "DONE"
echo
