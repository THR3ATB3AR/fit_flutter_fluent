# FitFlutterFluent 🏋️‍♀️🦋✨

<!-- | [![Crowdin](https://badges.crowdin.net/fit-flutter/localized.svg)](https://crowdin.com/project/fit-flutter)  | [![GitHub release (latest by date)](https://img.shields.io/github/v/release/THR3ATB3AR/fit_flutter)](https://github.com/THR3ATB3AR/fit_flutter/releases/latest)  | [![GitHub downloads](https://img.shields.io/github/downloads/THR3ATB3AR/fit_flutter/latest/total)](https://github.com/THR3ATB3AR/fit_flutter/releases/latest)  | [![GitHub forks](https://img.shields.io/github/forks/THR3ATB3AR/fit_flutter)](https://github.com/THR3ATB3AR/fit_flutter/forks)  | [![GitHub stars](https://img.shields.io/github/stars/THR3ATB3AR/fit_flutter)](https://github.com/THR3ATB3AR/fit_flutter/stargazers) |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -->

**FitFlutterFluent** is a Flutter-based application designed to browse and download FitGirl Repacks. This project is a rewrite of the original [FitFlutter](https://github.com/THR3ATB3AR/fit_flutter), with a core focus on implementing the **Microsoft Fluent Design System** for a modern, intuitive, and visually appealing user experience. It provides a convenient, cross-platform way to access FitGirl's extensive library of compressed game installers. Think of it as a *very* unofficial FitGirl client. This project is intended for educational purposes and to further improve my Flutter and UI/UX design skills.

**Disclaimer:** This application is not affiliated with or endorsed by FitGirl. Using this application to download copyrighted material without permission is illegal in many jurisdictions. You are solely responsible for complying with all applicable laws and regulations. Use this application at your own risk. I am not responsible for how you use it.

## ✨ Features

* **Microsoft Fluent Design:** A complete UI overhaul incorporating Fluent Design principles for a beautiful and cohesive experience.
* **Search Repacks:** Quickly find the repack you're looking for using a built-in search function.
* **Repack Details:** View detailed information about each repack, including game title, original size, repack size, compression details, and more.
* **Screenshots:** Browse screenshots of the game before downloading.
* **"FuckingFast" Downloads:** Download repacks directly using the "FuckingFast" (direct download) links (if available).
* **New And Popular Repacks:** See a list of the latest repacks added to the site and the most popular repacks.
* **Auto Updates:** The application can automatically check for and download updates to ensure you always have the latest features and fixes.
* **Torrent Support:** Download repacks using torrent files (requires a torrent client).
* **Cross-Platform Support:** FitFlutterFluent aims to work seamlessly on Windows, Linux and Android, with a Fluent-inspired design adapted for each platform where appropriate.
* **Caching Repacks:** Save scraped repacks to disk for faster loading.
* **Auto Install Repacks:** Automatically install downloaded repacks to a specified directory, streamlining the setup process (requires 7-Zip to be installed).

## 📝 To-Do List for Fluent Rewrite

This section outlines the tasks for the ongoing rewrite to implement Microsoft Fluent Design:

* [X] **Core UI Framework:**
  * [X] Integrate Fluent Design UI libraries/packages (e.g., `fluent_ui` for Windows, or custom Fluent-inspired widgets).
  * [X] Establish base Fluent theme (colors, typography, acrylic/mica materials where applicable).
* [X] **Component Redesign & Implementation:**
  * [X] Redesign and implement main navigation (NavigationView, TabView, etc.) using Fluent controls.
  * [X] Rewrite list views (repack library, downloads) with Fluent styling (e.g., ListView, GridView with Fluent item templates).
  * [X] Rewrite scraping methods.
  * [X] Update buttons, input fields, dialogs, and other interactive elements to Fluent Design.
  * [X] Implement Fluent iconography throughout the application.
  * [X] Refactor settings screen with Fluent controls (ToggleSwitch, ComboBox, etc.).
* [X] **Feature Parity with Fluent UI:**
  * [X] Ensure all existing features from FitFlutter are functional within the new Fluent UI.
  * [X] Port "Search Repacks" UI to Fluent.
  * [X] Port "Repack Details" view to Fluent.
  * [X] Port "Screenshots" viewer to Fluent.
  * [X] Port "Download Manager" UI to Fluent.
* [ ] **Visual Polish & UX:**
  * [X] Implement Fluent motion and animations for transitions and interactions.
  * [X] Ensure appropriate use of Acrylic/Mica materials (especially for Windows).
  * [X] Test and refine light/dark mode theming with Fluent Design.
  * [X] Ensure responsive design for different window sizes and screen densities.
  * [ ] Accessibility review for Fluent components.
* [ ] **Testing & Refinement:**
  * [X] Thoroughly test all UI elements and interactions.
  * [ ] Gather user feedback on the new Fluent design.
  * [ ] Address any UI/UX bugs or inconsistencies.
* [X] **Documentation & Screenshots:**
  * [X] Update README screenshots with the new Fluent UI.
  * [X] Document any new Fluent-specific features or settings.

## 📸 Screenshots

*(Screenshots will be updated once the Fluent Design rewrite is further along)*

![Alt text](assets/readme/1.png?raw=true "Home Page")
![Alt text](assets/readme/2.png?raw=true "Repack Details")
![Alt text](assets/readme/3.png?raw=true "Repack Library")
![Alt text](assets/readme/4.png?raw=true "Download Manager")

## 🚀 Roadmap & Future Enhancements

FitFlutterFluent is continuously evolving! The primary focus is currently on completing the Microsoft Fluent Design rewrite. Future enhancements will build upon this new foundation.

Planned future enhancements include:

* [X] Add support for Linux ARM builds.
* [X] Automatic updates for the Linux version.
* [X] Automatic updates for the Android version.
* [X] Fixing icon and background display issues on Android Version.
* [X] Adding functionality to refresh details of the repack.
* [X] Adding options to open webpage of repack.
* [X] Show close prevention dialog only when downloading.
* [X] Removing Windows-specific UI elements from the Android interface.
* [X] Implementing AppImage builds for Linux distribution.
* [X] Checking for updates of repacks.
* [X] Implementing app localization.
* [X] Adding automatic installation of repacks.
* [ ] Adding filtering capabilities for repacks.
* [ ] Developing a feature to manage installed games.
* [ ] GOG Games support.

I am open for contributions and suggestions!

## 🐛 Known Issues

This section lists known issues that have been reported. While these issues have been observed, they may not affect all users or all devices. We are working to resolve them. *(This section will be updated as the rewrite progresses)*

* **Genres Showing Hrefs:** Some repack genres may display as raw URLs (e.g., `https://...`) instead of readable text. A fix is planned to parse and display genres as plain text.
* **Limited Testing:** The application (especially the new Fluent UI) will initially undergo limited testing. We are actively seeking broader testing to identify and address issues.

## 📦 Installation

### Windows

To install and run the latest setup of FitFlutterFluent, follow these steps:

1. **Download the Latest Release:**
   * Visit the [Releases](https://github.com/THR3ATB3AR/fit_flutter_fluent/releases/latest) page on GitHub.
   * Download the latest release for your operating system.
2. **Run Setup:**
   * Install the app to a directory of your choice.

### Linux

1. **Download the tar.gz File:**

   * Visit the [Releases](https://github.com/THR3ATB3AR/fit_flutter_fluent/releases/latest) page on GitHub.
   * Download the latest `fitflutterfluent.tar.gz` file for Linux.
2. **Extract the tar.gz File:**

   ```bash
   tar -xzf fitflutterfluent.tar.gz -C /path/to/install/directory
   ```
3. **Run the Application:**

   ```bash
   cd /path/to/install/directory/fitflutterfluent
   ./fitflutterfluent
   ```

## 🛠️ Building

1. **Prerequisites:**

   * Flutter SDK installed and configured. (See [Flutter Installation Guide](https://docs.flutter.dev/get-started/install))
   * Dart SDK (usually comes with Flutter).
   * An emulator or physical device for testing.
   * (Potentially) Specific dependencies for Fluent UI packages.
2. **Clone the Repository:**

   ```bash
   git clone https://github.com/THR3ATB3AR/fit_flutter_fluent.git fit_flutter_fluent 
   cd fit_flutter_fluent
   ```
3. **Get Dependencies:**

   ```bash
   flutter pub get
   ```
4. **Run the App:**

   ```bash
   flutter run
   ```

   or to build:

   ```bash
   flutter build windows # for windows
   flutter build android # for android
   flutter build linux # for linux
   ```

   See [Flutter build documentation](https://docs.flutter.dev/deployment/build-guides)

## 🙏 Acknowledgements

* FitGirl Repacks (for the repack content, though this project is unofficial).
* The Flutter team and community.
* Microsoft for the Fluent Design System.
* Google Gemini for assisting with this README.

## 📞 Contact

If you have any questions or suggestions, feel free to open an issue on GitHub.
