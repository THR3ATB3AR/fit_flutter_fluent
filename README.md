# FitFlutterFluent 🏋️‍♀️🦋✨

| [![Crowdin](https://badges.crowdin.net/fit-flutter-fluent/localized.svg)](https://crowdin.com/project/fit-flutter-fluent) | [![GitHub release (latest by date)](https://img.shields.io/github/v/release/THR3ATB3AR/fit_flutter_fluent)](https://github.com/THR3ATB3AR/fit_flutter_fluent/releases/latest) | [![GitHub downloads](https://img.shields.io/github/downloads/THR3ATB3AR/fit_flutter_fluent/latest/total)](https://github.com/THR3ATB3AR/fit_flutter_fluent/releases/latest) | [![GitHub forks](https://img.shields.io/github/forks/THR3ATB3AR/fit_flutter_fluent)](https://github.com/THR3ATB3AR/fit_flutter_fluent/forks) | [![GitHub stars](https://img.shields.io/github/stars/THR3ATB3AR/fit_flutter_fluent)](https://github.com/THR3ATB3AR/fit_flutter_fluent/stargazers) |
| :------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------- |

**FitFlutterFluent** is an unofficial, cross-platform client for browsing and downloading from FitGirl Repacks and GOG Games, rebuilt from the ground up with the Microsoft Fluent Design System. As a complete rewrite of the original [FitFlutter](https://github.com/THR3ATB3AR/fit_flutter), this application offers a modern, intuitive, and visually stunning interface to access an extensive library of games.

This project was created for educational purposes to enhance my skills in Flutter and UI/UX design.

> **⚠️ Disclaimer**
>
> This application is not affiliated with, sponsored, or endorsed by the official FitGirl Repacks or GOG Games websites. The use of this software to download copyrighted material may be illegal in your country. You are solely responsible for your actions and for complying with all applicable laws. The developers of this application assume no liability for how it is used. Please use it at your own risk.

## ✨ Features

* **Modern Fluent UI:** Experience a beautifully redesigned interface based on the Microsoft Fluent Design System, complete with acrylic/mica materials and fluid animations.
* **Cross-Platform:** Enjoy a consistent experience on Windows, Linux, and Android, with a responsive design that adapts to each platform.
* **Expanded Library:** Browse and download from both FitGirl Repacks and GOG Games.
* **Comprehensive Search:** Quickly find any game with the powerful built-in search function.
* **Detailed Information:** Access all essential details for each repack, including original and repack sizes, compression info, and more.
* **Multiple Download Options:** Download directly using "FuckingFast" links or utilize the torrent file with your preferred torrent client.
* **New & Popular Sections:** Discover the latest and most popular repacks right from the home screen.
* **Automated Features:**
  * **Auto-Updates:** The app keeps itself up-to-date with the latest features and fixes.
  * **Auto-Install:** Automatically install downloaded repacks to a directory of your choice (requires 7-Zip).
* **Efficient Caching:** Game data is saved to disk for significantly faster load times on subsequent launches.

## 📸 Screenshots

![Home Page](assets/readme/1.png?raw=true)![Repack Details](assets/readme/2.png?raw=true)![Repack Library](assets/readme/3.png?raw=true)![GOG Library](assets/readme/4.png?raw=true)![Download Manager](assets/readme/5.png?raw=true)

## 🚀 Roadmap

FitFlutterFluent is in active development. While the core Fluent rewrite is complete, future enhancements are always being planned.

**Upcoming Features:**

* [ ] **Game Management:** A new feature to manage your library of installed games.

Contributions and feature suggestions are welcome!

## 🐛 Known Issues

* **Android Limitation:** Downloading from GOG Games is not supported on the Android platform.
* **Limited Testing:** As a project in active development, there may be undiscovered bugs. Community testing and feedback are greatly appreciated.

## 📦 Installation

### Windows

1. Navigate to the [**Releases**](https://github.com/THR3ATB3AR/fit_flutter_fluent/releases/latest) page.
2. Download the latest `.exe` installer.
3. Run the installer and follow the on-screen instructions.

### Linux

1. Go to the [**Releases**](https://github.com/THR3ATB3AR/fit_flutter_fluent/releases/latest) page.
2. Download the latest `fit_flutter_fluent.tar.gz` file.
3. Extract the archive to your desired installation directory:

    ```bash
    tar -xzf fit_flutter_fluent.tar.gz -C /path/to/install/directory
    ```

4. Run the application:

    ```bash
    cd /path/to/install/directory/fit_flutter_fluent
    ./fit_flutter_fluent
    ```

## 🛠️ Build from Source

### Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version recommended)
* An IDE like VS Code or Android Studio

### Instructions

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/THR3ATB3AR/fit_flutter_fluent.git
    cd fit_flutter_fluent
    ```

2. **Install Dependencies:**

    ```bash
    flutter pub get
    ```

3. **Run or Build the App:**

    * To run in debug mode:

        ```bash
        flutter run
        ```

    * To build a release version (replace `[platform]` with `windows`, `linux`, or `android`):

        ```bash
        flutter build [platform]
        ```

    For more details, see the official [Flutter build documentation](https://docs.flutter.dev/deployment/build-guides).

## 🙏 Acknowledgements

* **FitGirl Repacks** & **GOG Games** for their content (though this project remains unofficial).
* The **Flutter** team and community for the amazing framework.
* **Microsoft** for defining the Fluent Design System.
* **Google Gemini** for assistance with rewriting this README.

## 📞 Contact

For questions, suggestions, or bug reports, please [**open an issue**](https://github.com/THR3ATB3AR/fit_flutter_fluent/issues) on GitHub.
