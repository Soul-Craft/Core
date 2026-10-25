Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE'],
    :secret_key      => ENV['STRIPE_LIVE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]

# stripe_event 2 verifies each webhook's Stripe-Signature against the endpoint's signing secret (whsec_...).
StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']

StripeEvent.subscribe 'charge.succeeded' do |event|
  ChargeSucceeded.webhook(event)
end
