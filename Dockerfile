# Stage 1: Build
FROM python:alpine AS builder

# Set the working directory to /app
WORKDIR /app

# Copy the requirements.txt file into the Docker image
COPY requirements.txt .

# Install minimal build dependencies and required Python packages
# We use --no-cache-dir with pip install to avoid caching pip packages which can significantly increase the size of the final Docker image.
# We use --virtual to create a virtual group of packages. These packages are then deleted with apk del, which helps to reduce the size of the final Docker image.
RUN apk add --no-cache --virtual .build-deps gcc musl-dev \
    && pip install --no-cache-dir --prefix=/install -r requirements.txt \
    && apk del .build-deps    

# Stage 2: Runtime
# We start a new stage for the runtime. This helps to reduce the size of the final Docker image, as only the final result of the builder stage is copied into this stage.
FROM python:alpine

# Set the working directory to /app
WORKDIR /app

# Install runtime dependencies
RUN apk add --no-cache tini

# Copy the installed Python packages from the builder stage
COPY --from=builder /install /usr/local

# Copy the rest of the application code
COPY . .

# Run as non-root user for security
# We create a new user 'ahmed' and switch to that user. This is a good practice to run the Docker container as a non-root user.
RUN adduser -D ahmed
USER ahmed

# expose the port
EXPOSE 5000

#run the application
CMD ["python3", "app.py", "runserver", "0.0.0.0:5000"]