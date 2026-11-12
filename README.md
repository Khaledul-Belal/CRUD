# Flutter REST API CRUD App

A Flutter application that performs complete CRUD (Create, Read, Update, Delete) operations on a product list using a provided REST API.

> Assignment: REST API CRUD Operation (Ostad)

---

## Features

- **Read**: Fetch and display all products in a list
- **Create**: Add a new product through a form with validation
- **Update**: Edit an existing product
- **Delete**: Remove a product with a confirmation dialog
- **Loading state**: Progress indicator while data is loading or saving
- **Error handling**: Error message with a Retry button, plus SnackBar messages
- **Auto refresh**: The list reloads after every create, update and delete
- **Pull to refresh**: Swipe down on the list to reload

---

## API

**Base URL**

```
https://crud-api-ostad-live.onrender.com/api/v1
```

| Operation | Method | Endpoint |
|---|---|---|
| Get all products | GET | `/ReadProduct` |
| Get one product | GET | `/ReadProductById/{id}` |
| Create product | POST | `/CreateProduct` |
| Update product | POST | `/UpdateProduct/{id}` |
| Delete product | GET | `/DeleteProduct/{id}` |

> Note: This API uses **POST** for update and **GET** for delete, so the app uses the same methods.

**Request body (Create / Update)**

```json
{
  "ProductName": "Moto G96",
  "ProductCode": 754,
  "Img": "https://example.com/image.jpg",
  "Qty": 10,
  "UnitPrice": 27000,
  "TotalPrice": 270000
}
```

**Response (Read)**

```json
{
  "status": "success",
  "data": [
    {
      "_id": "6ad661f288bdc94dd3bf3036",
      "ProductName": "S23 Ultra",
      "ProductCode": 1792434671490414,
      "Img": "https://...",
      "Qty": 1,
      "UnitPrice": 72000,
      "TotalPrice": 80000
    }
  ]
}
```

---

## Project Structure

```
lib/
 ├─ main.dart                     # App entry point
 ├─ models/
 │   └─ product_model.dart        # Product model (fromJson / toJson)
 ├─ services/
 │   └─ api_service.dart          # All API calls (GET, POST, DELETE, UPDATE)
 └─ screens/
     ├─ home_screen.dart          # Product list, delete, refresh
     └─ add_edit_screen.dart      # Form to add / edit a product

postman/
 └─ CRUD_Ostad.postman_collection.json   # Postman collection for the API
```

---

## Tech Stack

- Flutter (Material 3)
- Dart
- [`http`](https://pub.dev/packages/http) package for API calls

---

## Getting Started

**Prerequisites**

- Flutter SDK installed (`flutter doctor` should pass)
- An emulator or a physical device

**Run the project**

```bash
# 1. Clone the repository
git clone <your-repo-url>
cd <project-folder>

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

**Dependency in `pubspec.yaml`**

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
```

---

## Testing the API with Postman

1. Open Postman and click **Import**.
2. Select the `postman/CRUD_Ostad.postman_collection.json` file from this repository.
3. Open the collection, go to **Variables**, and make sure `BaseUrl` is set to the base URL above.
4. Run `ReadProduct` first and check for `200 OK`.

---

## Important Notes

- The API is hosted on **Render's free plan**. If it has been idle, the **first request can take 1 to 2 minutes** while the server wakes up. The app uses a 90 second timeout for this reason.
- The API is **shared**, so other users' data may appear in the list. Only edit or delete the products you created yourself.
- `TotalPrice` is calculated automatically as `Qty × UnitPrice` when adding a product.
- Android needs the internet permission in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

---

## How It Works

```
User action (tap) → Flutter screen → ApiService (http request)
        → REST API server → Database
        → JSON response → Product model → UI update
```

1. The screen calls a method in `ApiService`.
2. `ApiService` sends an HTTP request to the API.
3. The JSON response is converted into `Product` objects using `fromJson`.
4. `setState` updates the UI.
5. After create, update or delete, the list is reloaded from the server.

---

## Screenshots

<img width="88" height="160" alt="WhatsApp Image 2026-11-12 at 9 56 41 PM" src="https://github.com/user-attachments/assets/f40c78cd-0661-4311-8b20-490a135f54a6" />

