# 🧱 Clean Architecture with Riverpod in Flutter

This project demonstrates how to structure a Flutter app using **Clean Architecture** principles and **Riverpod** for state management and dependency injection.

---
![Screenshot](assets/riverpod_clean_architcture.jpg)


## 📐 Project Structure (Clean Architecture)

![FolderStructure](assets/folder_structure.png)


## 🔄 Folder Responsibility

| Layer         | Responsibility                                  |
|---------------|--------------------------------------------------|
| `core/`       | Shared constants, utilities, network handler     |
| `data/`       | Connects app to external sources (e.g., APIs)    |
| `domain/`     | Pure business logic — use cases and entities     |
| `presentation/` | UI layer & ViewModels (Riverpod providers)    |

---