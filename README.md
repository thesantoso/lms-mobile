# LMS Mobile - Multi-Tenant Learning Management System

A comprehensive mobile-only Learning Management System built with Flutter and GetX, implementing clean architecture, SOLID principles, and feature-first organization.

## 🎯 Overview

This is a multi-tenant LMS application where each school operates as an independent tenant identified by a unique `schoolId`. The system supports four distinct user roles with role-based access control.

## 👥 User Roles

- **Student**: Access courses, view materials, submit assignments, mark attendance, view payments
- **Teacher**: Manage courses, upload materials, create assignments, grade submissions
- **Parent**: Monitor children's progress, attendance, and payments
- **Admin**: Manage users, courses, and generate reports

## 🏗️ Architecture

### Clean Architecture Layers

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App-wide constants
│   ├── errors/             # Exception definitions
│   ├── network/            # Network client (Dio)
│   ├── routes/             # Navigation & routing
│   ├── themes/             # App theming
│   ├── utils/              # Utilities
│   └── widgets/            # Reusable widgets
├── features/               # Feature modules
│   ├── auth/
│   ├── attendance/
│   ├── courses/
│   ├── assignments/
│   └── payments/
└── main.dart
```

### Feature-First Structure

Each feature follows clean architecture:

```
feature/
├── domain/
│   ├── entities/           # Business models
│   ├── repositories/       # Repository interfaces
│   └── usecases/          # Business logic
├── data/
│   ├── datasources/       # API & local data
│   ├── models/            # Data models
│   └── repositories/      # Repository implementations
└── presentation/
    ├── controllers/       # GetX controllers
    ├── pages/            # UI screens
    └── widgets/          # Feature widgets
```

## ✨ Core Features

### 1. Authentication & Authorization
- JWT-based authentication
- Role-based access control (RBAC)
- Multi-tenant isolation with mandatory `schoolId`
- Secure token storage with SharedPreferences
- Route guards based on authentication and roles

### 2. Attendance Management
- **GPS Geofencing**: Validates user location within school premises (100m radius)
- **Selfie Capture**: Requires photo verification for attendance
- **Real-time Location**: Uses Geolocator for precise positioning
- **Attendance History**: View past attendance records

### 3. LMS Features

#### Courses
- List all courses for students/teachers
- Course details with materials
- Teacher-student enrollment management

#### Materials
- Support for multiple file types (PDF, video, documents, images)
- Upload and download materials
- Organized by course

#### Assignments
- Create assignments (teachers)
- Submit assignments with file attachments (students)
- View assignment status and deadlines

#### Grading
- Grade submissions with scores and feedback
- View grades and feedback (students)
- Grade history tracking

### 4. Payment Module
- View payment history
- Payment reminders for due/overdue items
- Payment status tracking
- **Note**: View-only feature (no actual payment processing)

## 🛠️ Technology Stack

### Core
- **Flutter**: Cross-platform mobile framework
- **GetX**: State management, dependency injection, routing
- **Dio**: HTTP client for API communication
- **Shared Preferences**: Local data persistence

### Features
- **jwt_decoder**: JWT token parsing
- **geolocator**: GPS location services
- **permission_handler**: Runtime permissions
- **image_picker**: Camera and photo library access
- **file_picker**: File selection
- **cached_network_image**: Image caching

## 📱 Key Implementation Details

### State Management
- GetX controllers for reactive state
- Passive UI pattern (UI reacts to state changes)
- Minimal rebuilds with Obx widgets

### Dependency Injection
- GetX bindings for dependency management
- Lazy loading with `Get.lazyPut`
- Scoped dependencies per feature

### Error Handling
- Centralized error handling in DioClient
- Custom exception types
- User-friendly error messages via snackbars

### Security
- JWT token authentication
- Automatic token injection via interceptors
- School ID validation on every request
- Role-based route protection

### Multi-Tenancy
- School ID required for all operations
- Tenant isolation at API level
- School-specific data filtering

## 🚀 Getting Started

### Prerequisites
```bash
flutter --version  # Flutter 3.0.0 or higher
dart --version     # Dart 3.0.0 or higher
```

### Installation

1. Clone the repository:
```bash
git clone https://github.com/thesantoso/lms-mobile.git
cd lms-mobile
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Configuration

Update API endpoint in `lib/core/constants/app_constants.dart`:
```dart
static const String baseUrl = 'https://your-api-domain.com';
```

## 📋 Project Principles

### SOLID Principles
- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Interfaces can be substituted
- **Interface Segregation**: Small, focused interfaces
- **Dependency Inversion**: Depend on abstractions, not concretions

### Clean Code Practices
- Meaningful variable and function names
- Small, focused functions
- Consistent code style
- Comprehensive error handling
- Null-safety throughout

### Best Practices
- Feature-first organization
- Repository pattern for data layer
- UseCase pattern for business logic
- Dependency injection for testability
- Reactive programming with GetX

## 🔐 Permissions

### Android
- `INTERNET`: API communication
- `ACCESS_FINE_LOCATION`: GPS for attendance
- `ACCESS_COARSE_LOCATION`: GPS for attendance
- `CAMERA`: Selfie capture
- `READ_EXTERNAL_STORAGE`: File access
- `WRITE_EXTERNAL_STORAGE`: File storage

### iOS
- `NSLocationWhenInUseUsageDescription`: Location access
- `NSCameraUsageDescription`: Camera access
- `NSPhotoLibraryUsageDescription`: Photo library access

## 📝 API Integration

The app expects a RESTful API with the following endpoints:

### Authentication
- `POST /api/v1/auth/login` - Login with schoolId, email, password
- `POST /api/v1/auth/refresh` - Refresh JWT token
- `POST /api/v1/auth/logout` - Logout

### Attendance
- `POST /api/v1/attendance/mark` - Mark attendance with location & photo
- `GET /api/v1/attendance` - Get attendance history

### Courses
- `GET /api/v1/courses` - List courses
- `GET /api/v1/courses/:id` - Get course details
- `GET /api/v1/materials` - List course materials
- `POST /api/v1/materials` - Upload material

### Assignments
- `GET /api/v1/assignments` - List assignments
- `POST /api/v1/assignments` - Create assignment
- `POST /api/v1/submissions` - Submit assignment
- `GET /api/v1/submissions` - Get submissions
- `POST /api/v1/grades` - Grade submission

### Payments
- `GET /api/v1/payments` - List payments

All API requests include:
- `Authorization: Bearer <token>` header
- `X-School-Id: <schoolId>` header

## 🧪 Testing

Run tests:
```bash
flutter test
```

## 📱 Supported Platforms
- Android (API 21+)
- iOS (iOS 12.0+)

## 👨‍💻 Development

### Code Style
- Follow Dart/Flutter style guide
- Use `flutter analyze` for linting
- Format code with `flutter format`

### Linting
```bash
flutter analyze
```

## 📄 License

This project is part of a technical assessment and is for demonstration purposes.