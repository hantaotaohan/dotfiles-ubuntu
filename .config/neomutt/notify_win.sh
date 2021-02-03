#!/bin/bash
#
# Script to notify user for new mails.

#run OfflineIMAP once, with quiet interface
#offlineimap -o -q -u quiet

#count new mail for every maildir
# maildirnew="$HOME/Maildir/*/*/new/"
maildirnew="$HOME/mail/bteb/INBOX/new/"
maildirnew1="$HOME/mail/live/Inbox/new/"
new="$(find $maildirnew -type f | wc -l)"
new1="$(find $maildirnew1 -type f | wc -l)"

#count old mail for every maildir
# maildirold="$HOME/Maildir/*/*/cur/"
# old="$(find $maildirold -type f | wc -l)"

if [ $new -gt 0 ] || [ $new1 -gt 0 ]
then
    powershell.exe -Command New-BurntToastNotification -Text "NewMail", "BTEB：$new",  "HOTMAIL：$new1"
fi
