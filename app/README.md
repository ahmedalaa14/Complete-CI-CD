## Project Structure

- `app.py`: This is the main Python application file.
- `data/`: This directory contains data files used by the application.
- `deploy.sh`: This is a shell script for Automate Dockerization and Deployment to DockerHub.
- `Dockerfile`: This file contains instructions for building the Docker image of the application.
- `playbook.yml`: This is an Ansible playbook for automating the deployment process.
- `requirements.txt`: This file lists the Python dependencies that need to be installed.
- `static/`: This directory contains static files like CSS.
- `templates/`: This directory contains HTML templates.
- `test_app.py`: This file contains unit tests for the application.


## Prerequisites

- Docker installed
- Ansible installed

## Usage

### Running the Application Locally

- To run the application on your local machine:

1. **Start the Flask application**:

   ```bash
   python app.py
   ```

2. **Access the application**:

- Open your browser and navigate to `http://localhost:5000`.


3. **Build the Docker image**:

   ```bash
   docker build -t ahmedalaa14/flask-app-mini .
   ```

4. **Run the Docker container**:

   ```bash
   docker run -d --name python-app -p 5000:5000 ahmedalaa14/flask-app-mini
   ```
5. **Push Docker Image to DockerHub**

   ```bash
   docker push ahmedalaa14/flask-app-mini
   ```

6. **Access the application**:

   Open your browser and navigate to `http://localhost:5000`.

## Ansible (Bonus)
- created `playbook.yml` to automate the workflow of building, tagging, pushing Docker images to DockerHub, and deploying a container from the image.


## Bash Script (Bonus)
- Same as the Ansible `playbook.yml` to automate the workflow of building, tagging, pushing Docker images to DockerHub, and deploying a container from the image.