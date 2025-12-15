# Contributing to LMS Mobile

Thank you for your interest in contributing to LMS Mobile! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Write clean, maintainable code
- Follow the project's coding standards
- Document your code appropriately

## Development Setup

### Prerequisites

1. Install Flutter SDK (3.0.0 or higher)
2. Install Dart SDK (3.0.0 or higher)
3. Setup Android Studio or VS Code with Flutter extensions
4. Have a physical device or emulator ready

### Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/lms-mobile.git
   cd lms-mobile
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

Please follow the established architecture:

```
lib/
├── core/               # Shared infrastructure
├── features/          # Feature modules
│   └── feature_name/
│       ├── domain/    # Business logic
│       ├── data/      # Data layer
│       └── presentation/  # UI layer
└── main.dart
```

## Coding Standards

### Dart Style Guide

Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style).

Key points:
- Use `lowerCamelCase` for variables, functions, parameters
- Use `UpperCamelCase` for classes, enums, typedefs
- Use `lowercase_with_underscores` for library names
- Prefer single quotes for strings
- Use trailing commas for better formatting

### Code Formatting

Format your code before committing:
```bash
flutter format lib/
```

### Linting

Run the analyzer:
```bash
flutter analyze
```

Fix all warnings and errors before submitting.

## Architecture Guidelines

### Clean Architecture

Follow these principles:

1. **Domain Layer** (innermost)
   - Pure Dart code
   - No framework dependencies
   - Business entities and logic

2. **Data Layer**
   - Implements domain interfaces
   - Handles external data sources
   - Converts models to entities

3. **Presentation Layer** (outermost)
   - UI components
   - State management with GetX
   - User interaction handling

### SOLID Principles

- **S**ingle Responsibility: One class, one purpose
- **O**pen/Closed: Open for extension, closed for modification
- **L**iskov Substitution: Subtypes must be substitutable
- **I**nterface Segregation: Many specific interfaces over one general
- **D**ependency Inversion: Depend on abstractions, not concretions

### Null Safety

- Use null-safety throughout
- Avoid using `!` operator unless absolutely necessary
- Prefer `?.` and `??` operators

## Feature Development

### Adding a New Feature

1. Create feature directory structure:
   ```
   lib/features/new_feature/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   ├── data/
   │   ├── datasources/
   │   ├── models/
   │   └── repositories/
   └── presentation/
       ├── controllers/
       ├── pages/
       └── widgets/
   ```

2. Start with domain layer (entities, repository interfaces)
3. Implement data layer (models, datasources, repositories)
4. Create presentation layer (controllers, pages, widgets)
5. Add dependency injection in bindings
6. Register routes if needed

### State Management with GetX

Controllers should:
- Extend `GetxController`
- Use reactive variables with `Rx` types
- Call use cases for business logic
- Handle loading and error states
- Display errors via snackbars

Example:
```dart
class FeatureController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  
  Future<void> loadData() async {
    isLoading.value = true;
    try {
      // Call use case
      final result = await useCase();
      // Update state
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
```

## Testing

### Writing Tests

We use the following test types:

1. **Unit Tests**: Test individual functions/classes
2. **Widget Tests**: Test UI components
3. **Integration Tests**: Test complete flows

### Test Structure

```dart
void main() {
  group('Feature Description', () {
    test('should do something', () {
      // Arrange
      final input = 'test';
      
      // Act
      final result = function(input);
      
      // Assert
      expect(result, expectedValue);
    });
  });
}
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit_test.dart

# Run with coverage
flutter test --coverage
```

## Git Workflow

### Branch Naming

- `feature/feature-name` - New features
- `fix/bug-description` - Bug fixes
- `refactor/description` - Code refactoring
- `docs/description` - Documentation changes

### Commit Messages

Follow conventional commits:

```
type(scope): subject

body (optional)

footer (optional)
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

Example:
```
feat(auth): implement JWT authentication

- Add login use case
- Implement token storage
- Add auth middleware

Closes #123
```

### Pull Request Process

1. Create a feature branch
2. Make your changes
3. Write/update tests
4. Run linter and tests
5. Update documentation
6. Commit with clear messages
7. Push to your fork
8. Create a pull request

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added where needed
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Tests added/updated
- [ ] All tests pass
```

## Code Review Guidelines

When reviewing code:
- Check for adherence to architecture
- Verify SOLID principles
- Look for potential bugs
- Check test coverage
- Ensure documentation is updated
- Verify null-safety
- Check for performance issues

## Documentation

### Code Documentation

Document:
- Complex logic
- Public APIs
- Business rules
- Non-obvious implementations

Use Dart doc comments:
```dart
/// Calculates the distance between two points.
///
/// Returns the distance in meters.
/// Throws [LocationException] if coordinates are invalid.
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  // Implementation
}
```

### README Updates

Update README.md when:
- Adding new features
- Changing architecture
- Modifying setup process
- Adding new dependencies

## Dependencies

### Adding Dependencies

Before adding a new dependency:
1. Check if it's really needed
2. Verify it's well-maintained
3. Check for vulnerabilities
4. Consider package size
5. Discuss with team if major dependency

Add to `pubspec.yaml`:
```yaml
dependencies:
  package_name: ^version
```

## Performance Considerations

- Avoid unnecessary rebuilds
- Use `const` constructors where possible
- Lazy load dependencies
- Cache network images
- Optimize list rendering with builders
- Profile before optimizing

## Security Considerations

- Never commit secrets or API keys
- Validate all user inputs
- Sanitize data before display
- Use secure storage for sensitive data
- Keep dependencies updated
- Follow OWASP Mobile Security guidelines

## Questions or Issues?

- Check existing issues first
- Create a new issue with clear description
- Provide steps to reproduce
- Include relevant code snippets
- Mention your environment details

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

## Thank You!

Your contributions make this project better for everyone!
