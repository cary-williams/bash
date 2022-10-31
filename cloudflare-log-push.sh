"""Sets up cloudflare to push logs to S3 bucket"""


from json import dumps
import requests

# Variables for CloudFlare API
URL = "https://api.cloudflare.com/client/v4/"
X_AUTH_EMAIL = "" # your email address
X_AUTH_KEY = "" # your cloudflare auth key
ZONE_ID = "" # your cloudflare zone id
DEST = "s3://BUCKET_NAME/DIRECTORY_WITHIN_BUCKET?region=AWS-REGION" # ex: s3://my_cloudflare_bucket/logs?region=us-east-2
LOGPUSH_URL = URL + "/zones/%s/logpush" % ZONE_ID
HEADER = {
    'X-Auth-Email': X_AUTH_EMAIL,
    'X-Auth-Key': X_AUTH_KEY,
    'Content-Type': 'application/json'
}

# Create job
R = requests.post(LOGPUSH_URL + "/jobs", headers=HEADER, data=dumps({"destination_conf":DEST}))
print(R.status_code, R.text)
assert R.status_code == 201
assert R.json()["result"]["enabled"] == False

# Keep id of the new job
JID = R.json()["result"]["id"]

# Get job
R = requests.get(LOGPUSH_URL + "/jobs/%s" % JID, headers=HEADER)
print(R.status_code, R.text)
assert R.status_code == 200

# Get all jobs for a zone
R = requests.get(LOGPUSH_URL + "/jobs", headers=HEADER)
print(R.status_code, R.text)
assert R.status_code == 200
#assert len(R.json()["result"]) > 0
assert R.json()["result"]

# Update job
R = requests.put(LOGPUSH_URL + "/jobs/%s" % JID, headers=HEADER, data=dumps({"enabled":True}))
print(R.status_code, R.text)
assert R.status_code == 200
assert R.json()["result"]["enabled"]

# Delete job
R = requests.delete(LOGPUSH_URL + "/jobs/%s" % JID, headers=HEADER)
print(R.status_code, R.text)
assert R.status_code == 200
