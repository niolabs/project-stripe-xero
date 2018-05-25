FROM gcr.io/prod-product/nio_full:20180524

EXPOSE 8181
# Stripe Webhook Port
EXPOSE 8170

COPY requirements.txt /nio/requirements.txt
RUN ["pip", "install", "-r", "/nio/requirements.txt"]

COPY project /nio/project

COPY keys /nio/project/blocks/xero/keys
