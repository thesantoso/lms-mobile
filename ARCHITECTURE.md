# Architecture Documentation

## System Overview

This LMS Mobile application implements Clean Architecture principles with a feature-first organization, utilizing Flutter for the UI layer and GetX for state management, dependency injection, and routing.

## Architecture Layers

### 1. Presentation Layer (UI)
**Location**: `lib/features/*/presentation/`

**Responsibilities**:
- Display UI components
- Handle user interactions
- React to state changes
- Route navigation

**Components**:
- **Pages**: Full screen views
- **Widgets**: Reusable UI components
- **Controllers**: GetX controllers managing state

**Pattern**: Passive UI - UI components are stateless and react to controller state changes

### 2. Domain Layer (Business Logic)
**Location**: `lib/features/*/domain/`

**Responsibilities**:
- Define business entities
- Define repository interfaces
- Implement business rules via use cases

**Components**:
- **Entities**: Pure Dart business objects
- **Repositories**: Abstract interfaces
- **UseCases**: Single-responsibility business operations

**Key Principle**: No dependencies on external frameworks or data sources

### 3. Data Layer (Data Management)
**Location**: `lib/features/*/data/`

**Responsibilities**:
- Implement repository interfaces
- Handle API communication
- Manage local storage
- Transform data models

**Components**:
- **DataSources**: Remote (API) and Local (cache) data sources
- **Models**: Data transfer objects with JSON serialization
- **Repositories**: Concrete implementations of domain repositories

### 4. Core Layer (Shared Infrastructure)
**Location**: `lib/core/`

**Responsibilities**:
- Provide shared utilities
- Define constants
- Handle errors
- Configure network clients
- Define app-wide widgets and themes

## Dependency Rule

Dependencies flow inward:
```
Presentation → Domain ← Data
      ↓
    Core
```

- Presentation depends on Domain
- Data depends on Domain
- Both depend on Core
- Domain has no external dependencies (pure business logic)

## Feature Structure

Each feature follows this structure:

```
feature/
├── domain/
│   ├── entities/
│   │   └── feature_entity.dart
│   ├── repositories/
│   │   └── feature_repository.dart (interface)
│   └── usecases/
│       └── feature_usecases.dart
├── data/
│   ├── datasources/
│   │   └── feature_datasource.dart
│   ├── models/
│   │   └── feature_model.dart
│   └── repositories/
│       └── feature_repository_impl.dart
└── presentation/
    ├── controllers/
    │   └── feature_controller.dart
    ├── pages/
    │   └── feature_page.dart
    └── widgets/
        └── feature_widget.dart
```

## Multi-Tenancy Implementation

### Tenant Isolation
- Each school is a tenant identified by `schoolId`
- `schoolId` is mandatory for all operations
- Sent in every API request via `X-School-Id` header
- Stored in SharedPreferences after login

### Enforcement Layers
1. **Network Layer**: DioClient automatically injects `schoolId` header
2. **Repository Layer**: Validates `schoolId` presence
3. **API Layer**: Backend enforces tenant isolation

## State Management with GetX

### Controllers
- Extend `GetxController`
- Manage feature-specific state
- Implement business logic via use cases
- Provide reactive state with `Rx` variables

### Reactive Programming
```dart
// Observable state
final RxBool isLoading = false.obs;

// React in UI
Obx(() => Text(controller.isLoading ? 'Loading...' : 'Done'))
```

### Dependency Injection
```dart
// Bindings provide dependencies
class FeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeatureController(...));
  }
}
```

## Navigation & Routing

### Route Definition
```dart
GetPage(
  name: '/feature',
  page: () => FeaturePage(),
  binding: FeatureBinding(),
  middlewares: [AuthMiddleware()],
)
```

### Route Guards (Middlewares)
1. **AuthMiddleware**: Checks if user is authenticated
2. **RoleMiddleware**: Validates user has required role

## Authentication Flow

```
1. User enters credentials + schoolId
2. Login API call with credentials
3. Server returns JWT + user data
4. Store JWT, schoolId, user data locally
5. Navigate to role-specific home page
6. All subsequent requests include JWT + schoolId
```

### Token Management
- JWT stored in SharedPreferences
- Automatically injected via Dio interceptor
- Refresh handled by interceptor (future enhancement)

## Error Handling

### Exception Hierarchy
```
AppException (base)
├── NetworkException
├── UnauthorizedException
├── ValidationException
├── NotFoundException
├── ServerException
├── CacheException
├── LocationException
└── PermissionException
```

### Handling Flow
1. Exception thrown at data source
2. Caught in repository (optional transformation)
3. Caught in controller
4. Displayed to user via snackbar or error widget

## Data Flow Examples

### Example: Mark Attendance

```
User Action (UI)
    ↓
Controller.markAttendance()
    ↓
MarkAttendanceUseCase
    ↓
AttendanceRepository (interface)
    ↓
AttendanceRepositoryImpl
    ↓
AttendanceRemoteDataSource
    ↓
DioClient (with interceptors)
    ↓
API Request (with JWT + schoolId)
    ↓
Response
    ↓
Model → Entity
    ↓
Controller updates state
    ↓
UI rebuilds (Obx)
```

## Security Considerations

### Authentication
- JWT-based authentication
- Tokens stored securely in SharedPreferences
- Automatic logout on 401 responses

### Authorization
- Role-based access control (RBAC)
- Route guards prevent unauthorized access
- API validates permissions server-side

### Multi-Tenancy
- Tenant isolation at all layers
- SchoolId validation on every request
- No cross-tenant data leakage

### Data Protection
- HTTPS for all API calls
- No sensitive data in logs
- Secure local storage

## Testing Strategy

### Unit Tests
- Test entities and models
- Test use cases in isolation
- Mock repositories

### Widget Tests
- Test UI components
- Test controller logic
- Mock use cases

### Integration Tests
- Test complete flows
- Test with real dependencies
- Test API integration

## Performance Optimizations

### Lazy Loading
- Dependencies loaded on-demand with `Get.lazyPut`
- Images cached with `cached_network_image`

### Efficient Rebuilds
- Minimal widget rebuilds with `Obx`
- Scoped state management

### Network
- Request/response interceptors
- Timeout configuration
- Retry logic (future enhancement)

## Future Enhancements

1. **Offline Support**
   - Local database (Hive/Drift)
   - Sync mechanism
   - Queue failed requests

2. **Real-time Updates**
   - WebSocket integration
   - Push notifications
   - Live grade updates

3. **Advanced Features**
   - Video conferencing
   - Chat system
   - Advanced analytics
   - Calendar integration

4. **Testing**
   - Increase test coverage
   - Add integration tests
   - Performance testing

5. **DevOps**
   - CI/CD pipeline
   - Automated testing
   - Code quality gates
   - Automated deployments
