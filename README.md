# 🦖 Flutter Digimon App

A simple, lightweight Flutter application built primarily as a hands-on project to practice **Cubit (Bloc)** for state management with API. This project focuses on cleanly handling API requests, managing different UI states, and decoupling business logic from the user interface.

## 📸 Screenshots

<p align="center">

  <img src="https://github.com/user-attachments/assets/595fefc2-334d-41cc-922d-599936e83375" width="30%" alt="Home Screen"/> &nbsp;
  <img src="https://github.com/user-attachments/assets/2803b876-844b-4596-8824-dc1dd3d5e2bd" width="30%" alt="Search Feature showing results"/> &nbsp;
  <img src="https://github.com/user-attachments/assets/7d3717ae-cfd3-4670-baea-4139ffc174ac" width="30%" alt="Card Selection feature"/>
  
  <br><br> 
  
  <img src="https://github.com/user-attachments/assets/e74acb74-616c-40ee-8576-66c9e0535d12" width="30%" alt="Search Feature no results"/> &nbsp;
  <img src="https://github.com/user-attachments/assets/fb3c2445-a5b2-4948-b7a2-4122aebb03bf" width="30%" alt="No Internet"/>
</p>
## ✨ Key Features

* **State Management (Cubit):** Utilizes `flutter_bloc` to handle the entire data flow. The UI seamlessly reacts to different states (`DataLoading`, `DataLoaded`, `DataError`) ensuring precise rebuilds and a clean separation of concerns.
* **Robust API Integration (Dio):** Fetches data from a public Digimon API using the `dio` package and centralized error handling, converting technical exceptions into user-friendly messages.
* **Pagination Logic:** Implements custom, in-memory pagination (10 items per page) using list slicing (`skip` and `take`), providing a smooth navigation experience without redundant API calls.
* **Smart Search System:** 
  * You can search by name or by level.
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
