
MailListener = require "mail-listener"

mailListener = new MailListener
  username: process.env.EMAIL_USERNAME ? ""
  password: process.env.EMAIL_PASSWORD ? ""
  host: "imap-host"
  port: 993 # imap port
  secure: true # use secure connection
  mailbox: "INBOX" # mailbox to monitor
  markSeen: false # all fetched email willbe marked as seen and not fetched next time
  fetchUnreadOnStart: true # use it only if you want to get all unread email on lib start. Default is `false`


 # start listener. You can stop it calling `stop method`
mailListener.start()

# subscribe to server connected event
mailListener.on "server:connected", ->
  console.log "imap connected"

# subscribe to error events
mailListener.on "error", (err) ->
  console.log "error happened", err

# mail arrived and was parsed by parser 
mailListener.on "mail:parsed", (mail) ->
  # do something with mail object including attachments
  console.log "parsed email with attachment", mail.attachments
  ## mail processing code goes here

## it's possible to access imap object from node-imap library for performing additional actions. E.x.
mailListener.imap.move :msguids, :mailboxes, ->