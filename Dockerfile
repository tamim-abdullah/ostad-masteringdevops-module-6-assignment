FROM python:3.10-slim 

WORKDIR /app

# EXACT system dependencies from README plus absolutely essential additions
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    zlib1g-dev \
    libffi-dev \
    libpq-dev \
    libjpeg-dev \   
    libopenjp2-7-dev \
    libtiff-dev \       
    libfreetype6-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Exact package installation as per README
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt 

# Copy application code (same as local development)
COPY . .
EXPOSE 8000
# EXACT run command from README
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

#----- SOLUTION FOR MIGRATION PROBLEM -----
# COPY entrypoint.sh /
# RUN chmod +x /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

#------------------------------------------