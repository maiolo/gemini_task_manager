# Gemini Task Manager API

## Introduction

This is a Rails API for a task management application. It uses Devise for user authentication and JWT for token-based authorization.

## Getting Started

### Prerequisites

* Ruby 3.2.0
* Rails 7.1.2
* PostgreSQL

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/gemini_task_manager.git
```
2. Navigate to the project directory:

```bash
cd gemini_task_manager
```

3. Install the dependencies:

```bash
bundle install
```

4. Create and migrate the database:

```bash
rails db:create
rails db:migrate
```

5. Start the server:

```bash
rails s
```
The API will be available at http://localhost:3001.

## API Documentation

### Authentication

#### Signup

* Endpoint: `POST /signup`
* Request Body:
```json
{
  "user": {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "password": "password"
  }
}
```
* Response:
```json
{
  "status": {
    "code": 201,
    "message": "Signed up successfully."
  },
  "data": {
    "id": 1,
    "email": "john.doe@example.com",
    "name": "John Doe"
  }
}
```
#### Login

* Endpoint: `POST /login`
* Request Body:
```json
{
  "user": {
    "email": "john.doe@example.com",
    "password": "password"
  }
}
```

* Response:
```json
{
  "status": {
    "code": 200,
    "message": "Logged in successfully."
  },
  "data": {
    "user": {
      "id": 1,
      "email": "john.doe@example.com",
      "name": "John Doe",
      "jwt": "your-jwt-token"
    }
  }
}
```

#### Logout
* Endpoint: `DELETE /logout`
* Headers:
  * `Authorization: Bearer <JWT token>`
* Response:
```json
{
  "status": 200,
  "message": "Logged out successfully."
}
```
### Tasks

#### List all tasks
* Endpoint: `GET /tasks`
* Headers:
  * `Authorization: Bearer <JWT token>`
* Response:
```json
{
  "status": {
    "code": 200,
    "message": "Tasks fetched successfully."
  },
  "data": [
    {
      "id": 1,
      "title": "Task 1",
      "description": "Task 1 description",
      "completed": false,
      "user_id": 1
    },
    {
      "id": 2,
      "title": "Task 2",
      "description": "Task 2 description",
      "completed": true,
      "user_id": 1
    }
  ]
}
```

#### Get a specific task
* Endpoint: `GET /tasks/:id`
* Headers:
  * `Authorization: Bearer <JWT token>`
* Response:
```json
{
  "status": {
    "code": 200,
    "message": "Task fetched successfully."
  },
  "data": {
    "id": 1,
    "title": "Task 1",
    "description": "Task 1 description",
    "completed": false,
    "user_id": 1
  }
}
```

#### Create a new task
* Endpoint: POST /tasks
* Headers:
 * `Authorization: Bearer <JWT token>`
* Request Body:
```json
{
  "task": {
    "title": "New Task",
    "description": "New task description",
    "completed": false
  }
}
```
* Response:
```json
{
  "status": {
    "code": 201,
    "message": "Task created successfully."
  },
  "data": {
    "id": 3,
    "title": "New Task",
    "description": "New task description",
    "completed": false,
    "user_id": 1
  }
}
```
#### Update a task
* Endpoint: `PUT /tasks/:id`
* Headers:
  * `Authorization: Bearer <JWT token>`
* Request Body:
```json
{
  "task": {
    "title": "Updated Task",
    "completed": true
  }
}
```
* Response:
```json
{
  "status": {
    "code": 200,
    "message": "Task updated successfully."
  },
  "data": {
    "id": 1,
    "title": "Updated Task",
    "description": "Task 1 description",
    "completed": true,
    "user_id": 1
  }
}
```

#### Delete a task
* Endpoint: `DELETE /tasks/:id`
* Headers:
  * `Authorization: Bearer <JWT token>`
* Response:
```json
{
  "status": {
    "code": 204,
    "message": "Task deleted successfully."
  }
}
```

## Authenticating with Another Application

This API uses JWT for authorization. To authenticate with another application, follow these steps:

1. Obtain a JWT token: Make a `POST` request to the `/login` endpoint with valid user credentials. The response will contain a `jwt` token in the `data.user` object.
2. Include the JWT token in subsequent requests: Include the JWT token in the `Authorization` header of all subsequent requests to protected endpoints. The header should be in the format: `Authorization: Bearer <JWT token>.`

Example using `curl`:

```curl
# Login to obtain JWT token
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{ "user": { "email": "john.doe@example.com", "password": "password" } }' \
  http://localhost:3001/login


# Extract JWT token from response
JWT_TOKEN=<your-extracted-jwt-token>

# Make a request to a protected endpoint
curl -X GET \
  -H "Authorization: Bearer $JWT_TOKEN" \
  http://localhost:3001/tasks
```
### Contributing
Contributions are welcome! Please open an issue or submit a pull request.

### License
This project is licensed under the MIT License.
