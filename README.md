# mail_to_telegram
resend smtp messages to telegram including images. 

It opens an SMTP listener on port 1025 and 0.0.0.0 address. It will resend all emails to telegram via the configured bot to the desired chat_id, group or channel.

The smtp listener port can be changed either by using the docker ports functionality to map a custom port to the default port 1025 or change the value in the config.py file itself and use network_mode: host in the docker compose file.

Example compose.yml file:

```
services:
  mail_to_telegram:
    build: .
    image: beastarman/mail_to_telegram:latest
    container_name: mail_to_telegram
    restart: unless-stopped
    # To place the container on hosts network instead of being isolated use network_mode: host and comment out ports.
    # This will require any desired port number change to be done using theisten_port value in the config.yaml file.
#    network_mode: "host"
    ports:
     # change the left hand port to change the port emails will need to be sent to
     - 8888:1025
    volumes:
     # mount the config.py file into the container to pass the Telegram IDs to the application.
     - ./config.py:/opt/mail_to_telegram/config.py
    environment:
     - PUID=1000
     - PGID=1000
     # Set to the correct local timezone
     - TZ=Europe/London
    stdin_open: true # docker run -i
    tty: true # docker run -t

```

!IMPORTANT!
Either take a copy of of `EXAMPLE.config.py` and rename it to `config.py`, update with the required `chat_id` and `bot_token` variables.

Or create a new file within your docker project folder and copy the below variables into it. Then set the `bot_token` and `chat_id` variables.

You can change the `listen_port` value in `config.py` too if you are placing the Docker Container on the host network. Or you can use the docker ports method (recommended) to send to a different port but leave the `listen_port` as is.

```
bot_token = '123123123123:SdfSDFsdfSDfWdeyfM-123SDFSDFsdf-O6df'
chat_id = '12321343454'
listen_addr = "0.0.0.0"
listen_port = "1025"
```

## Sending to multiple Telegram contacts

Multiple chat_id's usage is not natively supported with this application. 

The way to achieve this with this application is to setup a Telegram channel to receive the emails and add everyone you wish to receive them to the channel, instead of each contact receiving them directly to their own chat. Add the bot to the channel too to enable it to be able to post messages to the channel.

https://telegram.org/tour/channels/es?ln=a#:~:text=To%20create%20your%20own%20channel,are%20indexed%20by%20search%20engines
