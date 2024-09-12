FROM python:3.9

# Set the working directory inside the container
WORKDIR /code

# Copy the requirements.txt file and install dependencies
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Create a new user called 'user'
RUN useradd -m -s /bin/bash user

# Switch to the non-root user 'user'
USER user

# Set environment variables
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Create the working directory for the user and set permissions
WORKDIR $HOME/app

# Copy the contents to the working directory and set ownership
COPY --chown=user:user . $HOME/app

# Command to run the app using uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
