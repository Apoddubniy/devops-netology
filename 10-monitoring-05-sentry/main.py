import sentry_sdk

sentry_sdk.init(
    dsn="https://4714bc8f5e134435271b542a63ba3533@o4505839403532288.ingest.sentry.io/4505843874070528",
    environment="development",
    release="1.0",
    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    # traces_sample_rate=1.0
)

if __name__ == "__main__":
    divizion_zero = 1 / 0