FROM python:3-alpine

WORKDIR /opt/mail_to_telegram

COPY . .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 1025
CMD [ "python", "mail_to_telegram.py" ]
