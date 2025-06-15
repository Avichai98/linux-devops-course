import logging
import random
from flask import Flask, request

app = Flask(__name__)

# Setup logging
logging.basicConfig(level=logging.INFO)

@app.before_request
def log_request_info():
    app.logger.info(f"{request.method} {request.path} from {request.remote_addr}")

@app.route("/")
def index():
    status = random.choice([200, 500])
    if status == 200:
        app.logger.info("Request handled successfully (200 OK)")
        return "Everything is fine!", 200
    else:
        app.logger.error("Internal Server Error (500)")
        return "Something went wrong!", 500

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
