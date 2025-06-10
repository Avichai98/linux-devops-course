import logging
from flask import Flask, request

app = Flask(__name__)

# Setup logging
logging.basicConfig(level=logging.INFO)

@app.before_request
def log_request_info():
    app.logger.info(f"{request.method} {request.path} from {request.remote_addr}")
    
@app.route("/")
def hello():
    return "Hello from Docker"

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
