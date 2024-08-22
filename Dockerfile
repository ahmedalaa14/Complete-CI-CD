# Build stage
FROM python:3.9-alpine AS build

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache gcc musl-dev libffi-dev openssl-dev

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Production stage
FROM python:3.9-alpine AS prod

WORKDIR /app

# Copy only necessary files from the build stage
COPY --from=build /app /app


# Run as non-root user for security
RUN adduser -D ahmed
USER ahmed

EXPOSE 5000

CMD ["python3", "app.py", "runserver", "0.0.0.0:5000"]