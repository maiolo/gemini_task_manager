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

4. Create and migrate a database:

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
**Signup**
Endpoint: POST `/signup`

Request body:
```json
{
  "user": {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "password": "password"
  }
}
```

Response:
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

**Login**
Endpoint: POST `/login`

Request body:
```json
{
  "user": {
    "email": "john.doe@example.com",
    "password": "password"
  }
}
```

Response:
```json
{
  "status": {
    "code": 200,
    "message": "Logged in successfully.",
    "data": {
      "user": {
        "id": 1,
        "email": "john.doe@example.com",
        "name": "John Doe"
      }
    }
  }
}
```

**Logout**
Endpoint: DELETE `/logout`

Headers:

`Authorization: Bearer <JWT token>`

Response:
```json
{
  "status": 200,
  "message": "Logged out successfully."
}
```

### Contributing
Contributions are welcome! Please open an issue or submit a pull request.

### License
This project is licensed under the MIT License.
