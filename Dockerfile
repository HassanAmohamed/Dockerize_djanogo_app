# Stage 1: Build
FROM python:3.9-alpine as builder

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Install system dependencies for psycopg2 and other necessary packages
RUN apk update && \
    apk add --no-cache \
        postgresql-dev \
        gcc \
        musl-dev \
        libffi-dev \
        openssl-dev && \
    rm -rf /var/cache/apk/*

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Stage 2: Final Image
FROM python:3.9-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH=/root/.local/bin:$PATH

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /root/.local /root/.local

# Copy only the necessary application files
COPY manage.py .
COPY discussion_board/ discussion_board/

# Clean up unnecessary files (optional)
RUN rm -rf /app/tests  # Remove test files if not needed in production
RUN find /app -name "*.pyc" -delete  # Remove Python bytecode files

# Expose port 8000 for the Django app
EXPOSE 8000

# Command to run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]