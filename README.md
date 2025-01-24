# Dockerize Django App

This project demonstrates how to Dockerize a simple Django application with a discussion board feature, using PostgreSQL as the database.

## Project Structure

```
Dockerize_django_app/
├── Dockerfile
├── docker-compose.yml
├── discussion_board/
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   ├── wsgi.py
│   ├── asgi.py
│   ├── boards/
│   │   ├── __init__.py
│   │   ├── admin.py
│   │   ├── apps.py
│   │   ├── forms.py
│   │   ├── models.py
│   │   ├── tests.py
│   │   ├── urls.py
│   │   └── views.py
│   └── accounts/
│       ├── __init__.py
│       ├── admin.py
│       ├── apps.py
│       ├── forms.py
│       ├── models.py
│       ├── tests.py
│       ├── urls.py
│       └── views.py
├── static/
│   ├── css/
│   │   └── style.css
│   ├── img/
│   └── js/
├── templates/
│   ├── includes/
│   │   ├── form.html
│   ├── base.html
│   ├── change_password_cone.html
│   ├── change_password.html
│   ├── edit_post.html
│   ├── home.html
│   ├── login.html
│   ├── my_account.html
│   ├── new_topic.html
│   ├── reply_topic.html
│   ├── signup.html
│   ├── topic_posts.html
│   └── topics.html
├── requirements.txt
├── .env
└── venv/
```

## Project Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/HassanAmohamed/Dockerize_django_app.git
   cd Dockerize_django_app
   ```

2. **Create a .env file:**
   Create a `.env` file in the project root with the following environment variables:
   ```plaintext
   SECRET_KEY=your_secret_key
   DEBUG=True 
   DATABASE_URL=postgres://postgres:postgres@postgres:5432/discussion_board 
   ```

3. **Build and run the Docker containers:**
   ```bash
   docker-compose up -d
   docker-compose logs db
   docker-compose run web python manage.py migrate # to migrate db container 
   ```

4. **Access the application:**
   Open your web browser and navigate to [http://localhost:8000/](http://localhost:8000/).

## Project Description

### Django Application
- A basic Django application with a discussion board model (Thread, Post).
- Basic CRUD operations for threads and posts.
- Simple HTML templates for displaying threads and posts.

### Dockerization
- Uses a Dockerfile to build a custom Docker image for the Django application.
- Utilizes `docker-compose.yml` to orchestrate the application and PostgreSQL database containers.

### PostgreSQL
- Utilizes a separate PostgreSQL container for the database.
- `init.sql` file for initial database setup (optional).

## Commands

- **Build and run:** 
  ```bash
  docker-compose up -d
  ```
- **Stop and remove containers:** 
  ```bash
  docker-compose down
  ```
- **Shell into the Django container:** 
  ```bash
  docker-compose exec web bash
  ```
- **Run Django migrations:** 
  ```bash
  python manage.py migrate
  ```
- **Collect static files:** 
  ```bash
  python manage.py collectstatic
  ```

## Further Improvements
- Add authentication and authorization.
- Implement more advanced features like user profiles, voting, and search.
- Improve the UI/UX design.
- Optimize the Dockerfile and `docker-compose.yml` for production environments.
- Add unit and integration tests.
- Implement CI/CD pipelines.
```
