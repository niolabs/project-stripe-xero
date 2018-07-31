# Stripe-Xero Integration

A nio project that allows you to connect your Stripe payment processing account with your Xero accounting software.

# Quick Reference

 * Stripe Webhook Default Port: `8170`
 * Required Environment Variables:
    * STRIPE_WEBHOOK_SECRET = your [webhook signing secret from Stripe](https://stripe.com/docs/webhooks#signatures)
	* XERO_CONSUMER_KEY = your [Xero developer app consumer key](https://developer.xero.com/myapps/details?appId=c870ac1f-c0b5-4dc8-ad92-9525a0e6d30f)

# Setting it Up

You will need two important pieces of information to get this project started. Your Stripe Webhook Secret and your Xero Consumer Key

## Stripe Configuration

Set up your Stripe Webhook from your [Stripe Dashboard](https://dashboard.stripe.com/test/webhooks/we_1CVTmyFEcIZuTCgg2Bn3t2n7). Your key is the "signing secret" that is revealed once you create your webhook.

Your webhook address should be where this nio instance will run. If you want to run locally and have a webhook call back to your local machine check out [ngrok](https://ngrok.com/).

The webhook will be exposed on port `8170` of your instance by default.

## Xero Application

You can set up your Xero application at the [Xero development portal](https://developer.xero.com/myapps/details?appId=c870ac1f-c0b5-4dc8-ad92-9525a0e6d30f). 

One of the first steps you will need to do is to set up an SSL key pair. Follow the instructions on [the Xero site](https://developer.xero.com/documentation/api-guides/create-publicprivate-key) for a quick reference. Put those keys in the `keys/` folder if running with Docker, or in the `project/blocks/xero/keys/` folder if running locally. The folder should have a `privatekey.pem` file and a `publickey.cer` file in it when you're done.

Upload your `publickey.cer` file to your Xero application. Once that's done, you'll want to grab the "consumer key" of your Xero app for use here.

## Running Locally

If you want to run the project locally, copy the `secrets.conf.template` file to `secrets.conf` and populate the values with the tokens you created in the last step. Then fire up nio using both the `nio.conf` and `secrets.conf` files.

```bash
niod -s nio.conf -s secrets.conf
```

You should be able to issue a Stripe webhook and see the data appear in Xero.

## Running with Docker

Build the docker image from the `Dockerfile`. You can specify your tokens in a `docker-compose.yml` if you want to run there, in the `nio.conf` file, or manually when you run the resulting docker image.

```bash
docker build . -t my-stripe-xero:latest
docker run -e STRIPE_WEBHOOK_SECRET=my_secret_from_stripe -e XERO_CONSUMER_KEY=my_secret_from_xero -p 8181:8181 -p 8170:8170 -it my-stripe-xero:latest
```
