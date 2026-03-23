Elevate Super Fitness
=====================

Welcome to **Elevate Super Fitness**! This is a modern mobile fitness application built with Flutter, designed to empower users on their fitness journey. Whether you're a beginner or a pro, the app provides personalized workout plans, exercise tracking, AI-powered coaching, and more. It's crafted with a focus on user experience, performance, and scalability.

If you're passionate about fitness tech or Flutter development, feel free to contribute, fork, or star the repo. Let's build something amazing together! 🚀

Project Overview
----------------

Elevate Super Fitness is a cross-platform mobile app that helps users achieve their fitness goals through guided exercises, progress tracking, and intelligent recommendations. Key highlights include:

* Onboarding for new users to get started quickly.

* A smart AI coach powered by Gemini for personalized advice.

* In-memory test data flow for local conversation simulation.

* Responsive UI that adapts to different screen sizes using Flutter ScreenUtil.

The app emphasizes clean code, test-driven development, and adherence to best practices in Flutter architecture.

Tech Stack
----------

* **Framework**: Flutter (SDK ^3.9.0)

* **State Management**: Flutter Bloc

* **Networking**: Retrofit

* **Dependency Injection**: Injectable

* **Database**: In-memory storage (test mode)

* **AI Integration**: Smart Coach local response engine (test mode)

* **Routing**: Navigator

* **Testing**: Flutter Test, Bloc Test, Mockito

* **Other Libraries**: Cached Network Image, Image Picker, Youtube Player Flutter, Animated Text Kit, and more (see pubspec.yaml for full list)

* **Build Tools**: Build Runner, Json Serializable, Retrofit Generator

* **Localization**: Flutter Intl for multi-language support

Architecture
------------

The project follows **Clean Architecture** principles to ensure separation of concerns, testability, and maintainability. It's divided into layers:

* **Presentation Layer**: Handles UI and user interactions (e.g., screens, widgets, view models using Cubit).

* **Domain Layer**: Contains business logic, entities, use cases, and repositories (abstract interfaces).

* **Data Layer**: Implements repositories with data sources (e.g., API services via Retrofit and local test stubs).

* **Core Layer**: Utilities, constants, and shared services (e.g., Gemini AI service and local chat memory service).

This structure promotes loose coupling and makes it easy to swap data sources or add features without affecting the UI.

Features
--------

* **Splash Screen**: Animated loading screen for a smooth app launch.

* **Onboarding**: Interactive tutorial with smooth page indicators and skip/next navigation.

* **User Authentication**: Secure login/signup.

* **Main Home Dashboard**: Bottom navigation bar for easy access to home, workouts, profile, and more.

* **Smart Coach**: AI-powered chat interface using Gemini for fitness advice, workout plans, and queries.

* **Exercise Selection**: Filter exercises by muscle groups and difficulty levels.

* **Media Integration**: YouTube video playback for exercise demos.

* **Offline Support**: Local conversation simulation in test mode.

* **Localization**: Multi-language support with generated ARB files.

* **Theming and Responsiveness**: Adaptive UI with custom fonts (Inter, Roboto, etc.) and screen scaling.

* **CI/CD**: GitHub Actions for automated testing and deployment.

Testing
-------

Testing is a core part of the project to ensure reliability. We use:

* **Unit Tests**: For view models and use cases (e.g., smart\_coach\_view\_model\_test.dart using Bloc Test and Mockito).

* **Widget Tests**: For UI components (e.g., on\_boarding\_screen\_test.dart, splash\_screen\_test.dart).

* **Mocking**: Mockito for simulating dependencies like API calls and databases.

Folder Structure
-----------------

Here's a high-level overview of the project structure:

```plaintext
.
├── android/                # Android-specific files
├── assets/                 # Images, icons, and fonts
│   ├── icons/
│   ├── images/
│   └── fonts/
├── ios/                    # iOS-specific files
├── lib/                    # Main Dart code
│   ├── api/                # API models and services (Retrofit-generated)
│   ├── core/               # Utilities, constants, services (e.g., Gemini, local memory)
│   ├── data/               # Data sources and repositories
│   ├── domain/             # Entities, use cases
│   ├── generated/          # Auto-generated files (e.g., l10n, JSON serializers)
│   ├── presentation/       # UI screens, widgets, view models
│   │   ├── auth/
│   │   ├── edit_profile/
│   │   ├── exercise/
│   │   ├── explore_page/
│   │   ├── food/
│   │   ├── food_details/
│   │   ├── main_home/
│   │   ├── on_boarding/
│   │   ├── profile_page/
│   │   ├── smart_coach_page/
│   │   └── splash/
│   │   └── workout_page/
│   └── main.dart           # App entry point
├── test/                   # Unit and widget tests
├── analysis_options.yaml   # Analyzer rules
├── pubspec.yaml            # Dependencies and config
└── README.md               # This file
```

Contributors
------------

* [Mohamed Hossam El-Bably](https://github.com/Bablu521)
* [Youssef Mohamed](https://github.com/youssefmdev22)
* [Moaz Osama](https://github.com/moazosama1)
* [Mohamed Naeem](https://github.com/mohamedna3eem)

Screenshots
--------------

| Splash                                                                                                                                               | Onboarding                                                                                                                                               | Login                                                                                                                                            | Register                                                                                                                                               |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src='assets/screenshots/201.png?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/onboarding.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/205.png?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/register_screen.gif?raw=true' width="150px" height="300px"/> |

| Explore Page                                                                                                                                                |Workout Page                                                                                                                                            | Food Details page                                                                                                                                                | Exercise                                                                                                                                                |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src='assets/screenshots/home_screen.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/218.jpg?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/food_details_screen.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/exercise_screen.gif?raw=true' width="150px" height="300px"/> |

| Smart Coach Page                                                                                                                                              | Profile                                                                                                                                              | Edit Profile                                                                                                                                                | Logout                                                                                                                                                |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src='assets/screenshots/smart_coach.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/profile_screen.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/223.jpg?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/225.jpg?raw=true' width="150px" height="300px"/> |

Presentation
------------

Check out our project presentation: [View Presentation](https://www.canva.com/design/DAG4DgofXQc/KE7Gfp-qVyXHacCy2VPiOA/view?utm_content=DAG4DgofXQc&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=hd138620478)
