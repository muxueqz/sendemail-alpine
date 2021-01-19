#!/bin/sh
echo "
# The user that gets all the mails (UID < 1000, usually the admin)
#root=username@gmail.com

# The mail server (where the mail is sent to), both port 465 or 587 should be acceptable
# See also https://support.google.com/mail/answer/78799
mailhub=$SMTP_SERVER

# The address where the mail appears to come from for user authentication.
#rewriteDomain=gmail.com

# The full hostname.  Must be correctly formed, fully qualified domain name or GMail will reject connection.

# Use SSL/TLS before starting negotiation
TLS_CA_FILE=/etc/ssl/certs/ca-certificates.crt
UseTLS=Yes
UseSTARTTLS=Yes

# Username/Password
AuthUser=$SMTP_USER
AuthPass=$SMTP_PASSWORD
AuthMethod=LOGIN

# Email 'From header's can override the default domain?
FromLineOverride=yes
" > /etc/ssmtp/ssmtp.conf

echo ${ATTACHMENTS} > /dev/shm/atts.txt
echo -e "To:$TO_ADDRESS\nFrom:$FROM_ADDRESS\nSubject: $SUBJECT\n\n $BODY"| (cat - && uuencode /dev/shm/atts.txt $ATTACHMENTS_FILENAME) | \
  ssmtp -v $TO_ADDRESS
