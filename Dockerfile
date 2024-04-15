# Stage 1: Build stage
FROM python:3.9 AS builder

# Update the package lists and install required dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg && \
    rm -rf /var/lib/apt/lists/*

# Add the Google Chrome repository
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

# Update package lists again and install Google Chrome
RUN apt-get update && \
    apt-get install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Stage 2: Final stage
FROM python:3.9

# Copy the installed Chrome binary from the builder stage
COPY --from=builder /usr/bin/google-chrome-stable /usr/bin/google-chrome-stable

# Set the working directory inside the container
WORKDIR /app

# Copy your Python script into the container
COPY voter.py /app/

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install any dependencies
RUN pip install -r requirements.txt

# Install Chromedriver using Webdriver Manager
RUN webdriver-manager update

# Copy Chromedriver binary to appropriate directory
RUN cp /root/.wdm/drivers/chromedriver/linux64/91.0.4472.19/chromedriver /usr/bin/

# Set entrypoint to run the script
CMD ["python3", "voter.py"]
