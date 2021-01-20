#!/bin/sh
if [ -z "$INPUT_ATTACHMENTS" ] ; then
  echo  "INPUT_ATTACHMENTS is NULL!!!"
  exit 1
fi
echo "
# The user that gets all the mails (UID < 1000, usually the admin)
#root=username@gmail.com

# The mail server (where the mail is sent to), both port 465 or 587 should be acceptable
# See also https://support.google.com/mail/answer/78799
mailhub=$INPUT_SMTP_SERVER

# The address where the mail appears to come from for user authentication.
#rewriteDomain=gmail.com

# The full hostname.  Must be correctly formed, fully qualified domain name or GMail will reject connection.

# Use SSL/TLS before starting negotiation
TLS_CA_FILE=/etc/ssl/certs/ca-certificates.crt
UseTLS=Yes
UseSTARTTLS=Yes

# Username/Password
AuthUser=$INPUT_SMTP_USER
AuthPass=$INPUT_SMTP_PASSWORD
AuthMethod=LOGIN

# Email 'From header's can override the default domain?
FromLineOverride=yes
" > /etc/ssmtp/ssmtp.conf

echo "$INPUT_ATTACHMENTS" > /dev/shm/atts.txt
echo -e "To:$INPUT_TO_ADDRESS\nFrom:$INPUT_FROM_ADDRESS\nSubject: $INPUT_SUBJECT\n\n $INPUT_BODY"| (cat - && uuencode /dev/shm/atts.txt $INPUT_ATTACHMENTS_FILENAME) | \
  ssmtp -v $INPUT_TO_ADDRESS
