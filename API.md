# API Documentation

This document describes the expected API contract for the LMS Mobile application.

## Base Configuration

```
Base URL: https://api.lms-school.com
API Version: /api/v1
```

## Common Headers

All authenticated requests must include:

```
Authorization: Bearer <jwt_token>
X-School-Id: <school_id>
Content-Type: application/json
```

## Authentication Endpoints

### POST /auth/login
Login to the system.

**Request Body:**
```json
{
  "schoolId": "school-123",
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (200):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user-123",
    "schoolId": "school-123",
    "name": "John Doe",
    "email": "user@example.com",
    "role": "student",
    "profileImage": "https://example.com/image.jpg",
    "metadata": {}
  }
}
```

### POST /auth/refresh
Refresh JWT token.

**Request Body:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response (200):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### POST /auth/logout
Logout user.

**Response (200):**
```json
{
  "message": "Logged out successfully"
}
```

## Attendance Endpoints

### POST /attendance/mark
Mark attendance with location and photo.

**Request (multipart/form-data):**
```
latitude: -6.2088
longitude: 106.8456
photo: <file>
```

**Response (200):**
```json
{
  "id": "att-123",
  "userId": "user-123",
  "schoolId": "school-123",
  "timestamp": "2024-01-15T08:30:00Z",
  "latitude": -6.2088,
  "longitude": 106.8456,
  "photoUrl": "https://example.com/photo.jpg",
  "status": "present",
  "remarks": null
}
```

### GET /attendance
Get attendance history.

**Query Parameters:**
- `userId` (required): User ID
- `startDate` (optional): ISO 8601 date
- `endDate` (optional): ISO 8601 date

**Response (200):**
```json
[
  {
    "id": "att-123",
    "userId": "user-123",
    "schoolId": "school-123",
    "timestamp": "2024-01-15T08:30:00Z",
    "latitude": -6.2088,
    "longitude": 106.8456,
    "photoUrl": "https://example.com/photo.jpg",
    "status": "present",
    "remarks": null
  }
]
```

## Course Endpoints

### GET /courses
Get list of courses.

**Query Parameters:**
- `teacherId` (optional): Filter by teacher
- `studentId` (optional): Filter by student

**Response (200):**
```json
[
  {
    "id": "course-123",
    "schoolId": "school-123",
    "name": "Mathematics 101",
    "description": "Introduction to Mathematics",
    "teacherId": "teacher-123",
    "teacherName": "Dr. Smith",
    "thumbnailUrl": "https://example.com/thumb.jpg",
    "startDate": "2024-01-01T00:00:00Z",
    "endDate": "2024-06-30T23:59:59Z",
    "studentIds": ["student-1", "student-2"]
  }
]
```

### GET /courses/:id
Get course details.

**Response (200):**
```json
{
  "id": "course-123",
  "schoolId": "school-123",
  "name": "Mathematics 101",
  "description": "Introduction to Mathematics",
  "teacherId": "teacher-123",
  "teacherName": "Dr. Smith",
  "thumbnailUrl": "https://example.com/thumb.jpg",
  "startDate": "2024-01-01T00:00:00Z",
  "endDate": "2024-06-30T23:59:59Z",
  "studentIds": ["student-1", "student-2"]
}
```

## Material Endpoints

### GET /materials
Get course materials.

**Query Parameters:**
- `courseId` (required): Course ID

**Response (200):**
```json
[
  {
    "id": "material-123",
    "courseId": "course-123",
    "title": "Chapter 1: Introduction",
    "description": "Introduction to the course",
    "type": "pdf",
    "fileUrl": "https://example.com/material.pdf",
    "uploadedAt": "2024-01-10T10:00:00Z"
  }
]
```

### POST /materials
Upload course material.

**Request (multipart/form-data):**
```
courseId: course-123
title: Chapter 1
description: Introduction chapter
type: pdf
file: <file>
```

**Response (201):**
```json
{
  "id": "material-123",
  "courseId": "course-123",
  "title": "Chapter 1",
  "description": "Introduction chapter",
  "type": "pdf",
  "fileUrl": "https://example.com/material.pdf",
  "uploadedAt": "2024-01-10T10:00:00Z"
}
```

## Assignment Endpoints

### GET /assignments
Get assignments list.

**Query Parameters:**
- `courseId` (optional): Filter by course
- `studentId` (optional): Filter by student

**Response (200):**
```json
[
  {
    "id": "assignment-123",
    "courseId": "course-123",
    "courseName": "Mathematics 101",
    "title": "Assignment 1",
    "description": "Solve problems 1-10",
    "dueDate": "2024-01-20T23:59:59Z",
    "maxScore": 100,
    "attachmentUrl": "https://example.com/assignment.pdf"
  }
]
```

### POST /assignments
Create new assignment (teachers only).

**Request Body:**
```json
{
  "courseId": "course-123",
  "title": "Assignment 1",
  "description": "Solve problems 1-10",
  "dueDate": "2024-01-20T23:59:59Z",
  "maxScore": 100
}
```

**Response (201):**
```json
{
  "id": "assignment-123",
  "courseId": "course-123",
  "courseName": "Mathematics 101",
  "title": "Assignment 1",
  "description": "Solve problems 1-10",
  "dueDate": "2024-01-20T23:59:59Z",
  "maxScore": 100,
  "attachmentUrl": null
}
```

## Submission Endpoints

### POST /submissions
Submit assignment.

**Request (multipart/form-data):**
```
assignmentId: assignment-123
file: <file>
comment: "Completed on time"
```

**Response (201):**
```json
{
  "id": "submission-123",
  "assignmentId": "assignment-123",
  "studentId": "student-123",
  "studentName": "John Doe",
  "submittedAt": "2024-01-19T10:00:00Z",
  "fileUrl": "https://example.com/submission.pdf",
  "comment": "Completed on time",
  "status": "submitted",
  "score": null,
  "feedback": null
}
```

### GET /submissions
Get submissions for an assignment.

**Query Parameters:**
- `assignmentId` (required): Assignment ID

**Response (200):**
```json
[
  {
    "id": "submission-123",
    "assignmentId": "assignment-123",
    "studentId": "student-123",
    "studentName": "John Doe",
    "submittedAt": "2024-01-19T10:00:00Z",
    "fileUrl": "https://example.com/submission.pdf",
    "comment": "Completed on time",
    "status": "graded",
    "score": 95,
    "feedback": "Excellent work!"
  }
]
```

## Grading Endpoints

### POST /grades
Grade a submission (teachers only).

**Request Body:**
```json
{
  "submissionId": "submission-123",
  "score": 95,
  "feedback": "Excellent work!"
}
```

**Response (200):**
```json
{
  "id": "submission-123",
  "assignmentId": "assignment-123",
  "studentId": "student-123",
  "studentName": "John Doe",
  "submittedAt": "2024-01-19T10:00:00Z",
  "fileUrl": "https://example.com/submission.pdf",
  "comment": "Completed on time",
  "status": "graded",
  "score": 95,
  "feedback": "Excellent work!"
}
```

## Payment Endpoints

### GET /payments
Get payment history.

**Query Parameters:**
- `studentId` (required): Student ID

**Response (200):**
```json
[
  {
    "id": "payment-123",
    "studentId": "student-123",
    "schoolId": "school-123",
    "description": "Tuition Fee - January 2024",
    "amount": 5000000.00,
    "status": "paid",
    "dueDate": "2024-01-10T00:00:00Z",
    "paidDate": "2024-01-08T10:30:00Z"
  }
]
```

### GET /payments/:id
Get payment details.

**Response (200):**
```json
{
  "id": "payment-123",
  "studentId": "student-123",
  "schoolId": "school-123",
  "description": "Tuition Fee - January 2024",
  "amount": 5000000.00,
  "status": "paid",
  "dueDate": "2024-01-10T00:00:00Z",
  "paidDate": "2024-01-08T10:30:00Z"
}
```

## Error Responses

All error responses follow this format:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable error message",
    "details": {}
  }
}
```

### Common Error Codes

- `400`: Bad Request - Invalid input
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions
- `404`: Not Found - Resource not found
- `422`: Unprocessable Entity - Validation failed
- `500`: Internal Server Error - Server error

### Example Error Response

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": {
      "email": "Invalid email format",
      "password": "Password must be at least 8 characters"
    }
  }
}
```

## Rate Limiting

API endpoints are rate-limited:
- 1000 requests per hour per user
- 429 status code when limit exceeded
- `X-RateLimit-Remaining` header indicates remaining requests

## Pagination

List endpoints support pagination:

**Query Parameters:**
- `page`: Page number (default: 1)
- `limit`: Items per page (default: 20, max: 100)

**Response Headers:**
```
X-Total-Count: 150
X-Page: 1
X-Per-Page: 20
```
