# 🦖 Flutter Digimon App

A simple, lightweight Flutter application built primarily as a hands-on project to practice **Cubit (Bloc)** for state management with API. This project focuses on cleanly handling API requests, managing different UI states, and decoupling business logic from the user interface.

## 📸 Screenshots

<p align="center">
<p align="center">
  <img src="https://github.com/user-attachments/assets/595fefc2-334d-41cc-922d-599936e83375" width="22%" alt="Home Screen"/> &nbsp;
  <img src="https://github.com/user-attachments/assets/ab30b614-d7a1-4883-8f9f-f78f71f10f31" width="22%" alt="Search Feature showing results"/> &nbsp;
  <img src="https://github.com/user-attachments/assets/03abb12b-f02d-4559-9ff0-9a67e6b02946" width="22%" alt="Search Feature no results"/> &nbsp;
  <img src="https://github.com/user-attachments/assets/7d3717ae-cfd3-4670-baea-4139ffc174ac" width="22%" alt="Card Selection feature"/>
</p>
</p>

## ✨ Key Features

* **State Management (Cubit):** Utilizes `flutter_bloc` to handle the entire data flow. The UI seamlessly reacts to different states (`DataLoading`, `DataLoaded`, `DataError`) ensuring precise rebuilds and a clean separation of concerns.
* **Robust API Integration (Dio):** Fetches data from a public Digimon API using the `dio` package and centralized error handling, converting technical exceptions into user-friendly messages.
* **Pagination Logic:** Implements custom, in-memory pagination (10 items per page) using list slicing (`skip` and `take`), providing a smooth navigation experience without redundant API calls.
* **Smart Search System:** 
  * Instantly filters the active data list by Digimon name.
  * Preserves the current page state when clearing the search dynamically.
  * Tap outside to unfocus the keyboard seamlessly.
* **Interactive UI/UX:** 
  * Tap on any Digimon card to highlight it with custom borders and shadows.
  * Integrated `RefreshIndicator` for quick data reloading.
  * Empty state handling with a custom UI layout when no Digimon is found.

## 🛠️ Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **State Management:** flutter_bloc (Cubit)
* **Networking & HTTP:** Dio
* **Fonts:** Google Fonts
