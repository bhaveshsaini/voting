FROM python:3.9
WORKDIR /app
COPY voter.py /app/
COPY requirements.txt /app/
RUN pip install -r requirements.txt
CMD ["python3", "voter.py"]
