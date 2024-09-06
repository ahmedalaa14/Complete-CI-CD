# Stage 1: Build
FROM python:alpine AS builder

# Set the working directory to /app
WORKDIR /app

# Copy the requirements.txt file into the Docker image
COPY requirements.txt .

# Install minimal build dependencies and required Python packages
RUN apk add --no-cache --virtual .build-deps gcc musl-dev \
    && pip install --no-cache-dir --prefix=/install -r requirements.txt \
    && apk del .build-deps    

# Stage 2: Runtime
FROM python:alpine

# Set the working directory to /app
WORKDIR /app

# Install runtime dependencies
RUN apk add --no-cache tini

# Copy the installed Python packages from the builder stage
COPY --from=builder /install /usr/local

# Copy the rest of the application code
COPY . .

# Ensure data directory and library.json file exist, then fix permissions
RUN mkdir -p /app/data && touch /app/data/library.json
RUN chmod 777 /app/data/library.json

# expose the port
EXPOSE 5000

#run the application
CMD ["python3", "app.py", "runserver", "0.0.0.0:5000"]