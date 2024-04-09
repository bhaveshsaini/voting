# Use an official Python runtime as a parent image
FROM python:3.8-slim

# # Set environment variables
# ENV DEBIAN_FRONTEND noninteractive

# # Install necessary packages
# RUN apt-get update && \
#     apt-get install -y wget unzip xvfb libxi6 libgconf-2-4 curl && \
#     apt-get clean

# Download and install Chrome
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get -y install google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Download and install ChromeDriver
ARG CHROME_DRIVER_VERSION=latest
RUN CHROME_DRIVER_URL="https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip" && \
    wget -O /tmp/chromedriver.zip ${CHROME_DRIVER_URL} && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm /tmp/chromedriver.zip

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app
CMD ["python3", "voter.py"]