FROM python:3-alpine

WORKDIR /opt/mail_to_telegram

COPY . .
RUN pip install --no-cache-dir -r requirements.txt
# Expose the applications default port so it can be remapped using docker ports if desired.
EXPOSE 1025
CMD [ "python", "mail_to_telegram.py" ]
