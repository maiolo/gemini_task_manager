# Gemini Task Manager API

## Overview

This is a Rails API for a simple task management application. It currently provides endpoints for user registration, login, and logout.

## API Endpoints

**Base URL:** `/api/v1`

### Users

#### Create User

**POST /api/v1/users**

Creates a new user.

**Request Body:**

```json
{
  "user": {
    "email": "user@example.com",
    "username": "johndoe",
    "password": "securepassword"
  }
}
