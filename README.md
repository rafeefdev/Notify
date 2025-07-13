# Tafaqquh Note
Your partner in capturing the faidah of the Islamic scholars.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your system.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone <repository-url>
    ```

2.  **Navigate to the project directory:**
    ```sh
    cd tafaqquh_note
    ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the application:**
    ```sh
    flutter run
    ```

## Project Architecture

This project follows a feature-driven architecture to promote separation of concerns and scalability.

-   `lib/core`: Contains shared code, including models, extensions, and utility functions that are used across multiple features.
-   `lib/features`: Each sub-directory within this folder represents a distinct feature of the application (e.g., `note`, `auth`). Each feature module is self-contained with its own views, viewmodels, and repositories.

### State Management

We use [Riverpod](https://riverpod.dev/) for state management, along with `riverpod_generator` for compile-safe provider generation. All new providers should be created using the annotation-based approach.

## Code Generation

This project utilizes `build_runner` to generate code for providers and other models. If you make changes to files that require code generation (e.g., adding or modifying a Riverpod provider), you must run the generator.

To watch for file changes and automatically regenerate code, use the following command:

```sh
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Contribution Guidelines

Contributions are welcome. Please adhere to the following guidelines:

1.  **Fork** the repository.
2.  Create a new branch for your feature or bug fix: `git checkout -b feature/your-feature-name`.
3.  Make your changes, adhering to the existing code style and architecture.
4.  Ensure all code generation steps are run if necessary.
5.  Commit your changes and push them to your fork.
6.  Submit a **Pull Request** with a clear description of your changes.

Please ensure your code follows the linting rules defined in `analysis_options.yaml`.