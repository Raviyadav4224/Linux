# ✅ Project 1: User and Group Manager Script
# Description:
# A shell script to create users, assign groups, set passwords, give sudo access, and delete them.
USERNAME=$2
GROUPNAME=$4
USERPASSWORD=""

echo "Checking commands exists in the system or not"

if ! command -v adduser &> /dev/null || \
   ! command -v addgroup &> /dev/null || \
   ! command -v usermod &> /dev/null || \
   ! command -v chown &> /dev/null || \
   ! command -v chmod &> /dev/null; then
    echo "❌ One or more required commands are missing"
    exit 1
fi


echo "User is $USERNAME"
echo "Group is $GROUPNAME"

echo "Creating user $USERNAME"

adduser $USERNAME

if ! getent group "$GROUPNAME" > /dev/null; then
    addgroup "$GROUPNAME"
    echo "✅ Group $GROUPNAME created"
else
    echo "✅ Group $GROUPNAME already exists"
fi

echo "User group $GROUPNAME created successfully ✅"

echo "Adding user to SUDO group"
usermod -a -G sudo "$USERNAME"
echo "$USERNAME added to SUDO group successfully ✅"

echo "Setting Ownership of home folder"
chown -R "$USERNAME:$GROUPNAME" "/home/$USERNAME"
chmod 755 "/home/$USERNAME"

echo "User creation completed ✅" 