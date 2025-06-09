# 🔹 Base image: using lightweight official Python image with pip
FROM python:3.11-slim

# 🔹 Set working directory inside container
WORKDIR /app

# 🔹 Copy files to container
COPY app.py .
COPY requirements.txt .

# 🔹 Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 🔹 Optional: document the port used by the app (Flask uses 5000)
EXPOSE 5000

# 🔹 Run the app when the container starts
CMD ["python", "app.py"]
