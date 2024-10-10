# mail_to_telegram
resend smtp messages to telegram including images. 

It opens an SMTP listener on 1025 port and 0.0.0.0 address and will resend all emails to telegram via the configured bot.

The smtp listener port can be changed either by using the docker ports functionality to map a custom port to the default port 1025 or change the value in the config.py file itself and use network_mode: host in the docker compose file.

Example compose.yml file:

```
mail_to_telegram:
    build: .
    image: mail_to_telegram:091024
    container_name: mail_to_telegram_infra
    restart: unless-stopped
#    network_mode: host
    ports:
     # Set left hand port to desired port
     - 1026:1025
    volumes:
     - ./config.py:/opt/mail_to_telegram/config.py
    environment:
     - PUID=1000
     - PGID=1000
     - TZ=Europe/London
    stdin_open: true # docker run -i
    tty: true # docker run -t

```

!IMPORTANT!
rename "EXAMLE.config.py" to "config.py" and write your chat_id and bot_token variables

```
bot_token = '123123123123:SdfSDFsdfSDfWdeyfM-123SDFSDFsdf-O6df'
chat_id = '12321343454'
listen_addr = "0.0.0.0"
listen_port = "1025"
```

# Sending to multiple Telegram contacts

Multiple chat_id's usage is not natively supported with this forwarder. 

The way to achieve this with this application is to setup a Telegram channel to receive the emails and add everyone you wish to receive them to the channel, instead of each contact receiving them directly to their own chat. Add the bot to the channel too to enable it to be able to post messages to the channel.

https://telegram.org/tour/channels/es?ln=a#:~:text=To%20create%20your%20own%20channel,are%20indexed%20by%20search%20engines

