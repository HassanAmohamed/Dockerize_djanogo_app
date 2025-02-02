# Stage 1: Build stage
FROM python:3.9-alpine AS builder

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Install only build dependencies
RUN apk add --no-cache \
    postgresql-dev \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --no-binary :all:

# Stage 2: Final Image
FROM python:3.9-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Install only runtime dependencies for PostgreSQL
RUN apk add --no-cache libpq

# Copy only the installed Python packages from the builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

# Copy only the necessary application files
COPY manage.py .
COPY discussion_board/ discussion_board/

# Clean up unnecessary files
RUN find . -name "*.pyc" -delete \
    && find . -name "__pycache__" -exec rm -rf {} + \
    && rm -rf .git* *.md *.yml discussion_board/tests

# Expose port 8000 for the Django app
EXPOSE 8000

# Command to run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

