FROM python:alpine

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app

RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

EXPOSE 5000

CMD ["python3", "app.py", "runserver", "0.0.0.0:5000"]
