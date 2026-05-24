# App Store Connect API key environment.
#
# Generated 2026-05-24 as part of T69 (multimaze2 iOS App Store v1.0).
# The .p8 itself lives at $APP_STORE_CONNECT_API_KEY_KEY_PATH and is NOT
# checked in anywhere — these vars only point at it. Lose the .p8 → must
# regenerate the key in https://appstoreconnect.apple.com/access/integrations/api
# and update KEY_ID / KEY_PATH here.

export APP_STORE_CONNECT_API_KEY_KEY_ID="88JLFJQ5SK"
export APP_STORE_CONNECT_API_KEY_ISSUER_ID="69a6de72-c316-47e3-e053-5b8c7c11a4d1"
export APP_STORE_CONNECT_API_KEY_KEY_PATH="$HOME/.appstoreconnect/private_keys/AuthKey_${APP_STORE_CONNECT_API_KEY_KEY_ID}.p8"

# Apple developer team ID — used by ge's ship lanes to force CODE_SIGN_STYLE=Manual
# with the match-installed "Apple Distribution: Squz Pty Ltd (<TEAM_ID>)" cert
# during archive. Without this, gym falls back to "Apple Development" which
# can't be exported as app-store-connect.
export APPLE_TEAM_ID="SWA3H3N7TW"

# MATCH_PASSWORD is the fastlane match repo encryption passphrase. NOT
# exported here — keep it in 1Password ("squz / match passphrase") and
# paste at the prompt or set ad-hoc for each shipping session:
#
#   export MATCH_PASSWORD=$(op read 'op://Squz/match passphrase/password')
#
# (or paste manually if you're not using op).
