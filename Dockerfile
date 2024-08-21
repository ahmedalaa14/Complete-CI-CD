FROM python:alpine

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app

RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

EXPOSE 5000

CMD ["python3", "app.py", "runserver", "0.0.0.0:5000"]


# Build stage
# FROM python:alpine AS build

# WORKDIR /usr/src/app

# COPY requirements.txt /usr/src/app

# RUN pip install --no-cache-dir -r requirements.txt

# COPY . /usr/src/app

# Production stage
# FROM python:alpine AS prod

#WORKDIR /usr/src/app

#COPY --from=build /usr/src/app /usr/src/app

#EXPOSE 5000

# CMD ["python3", "app.py", "runserver", "0.0.0.0:5000"]
