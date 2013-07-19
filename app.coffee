MailListener = require "mail-listener"
rules = require "./rules"

username = process.env.EMAIL_USERNAME ? ""
password = process.env.EMAIL_PASSWORD ? ""
host     = process.env.EMAIL_HOST ? ""

mailListener = new MailListener
  username: username
  password: password
  host: host
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
  mailListener.stop()

# mail arrived and was parsed by parser 
mailListener.on "mail:parsed", (mail) ->
  rule mail for rule in rules

process.on 'SIGINT', () =>
  mailListener.stop()

mailListener.on "server:disconnected", () =>
  console.log "imap disconnected"