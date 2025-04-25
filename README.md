# Book List App 
A Flutter application that displays a collection of books from the Gutendex API with responsive design for all devices. 

#Features

- **Responsive UI**: Adapts to phones, tablets, and desktops
- **Book Listing**: Displays books with covers, titles, and authors
- **Search Functionality**: Find books by title 
- **Offline Support**: Caches data for offline access
- **Infinite Scroll**: Loads books as you scroll

#Technical Stack
- **Flutter**: 3.19.5 (Dart 3.3.0)
- **State Management**: Flutter Bloc (Cubit)
- **Local Storage**: SQLite (sqflite)
- **Networking**: Http 
- **Responsive Design**: MediaQuery + LayoutBuilder

#Prerequisites
- Flutter SDK (version 3.19.5 or higher)
- Android Studio/Xcode for emulators
- Java 17+ for Android development

# Android Requirements

Ensure your `android/app/build.gradle` has:
```gradle
android {
    compileSdkVersion 34
    minSdkVersion 23
    targetSdkVersion 34
}




#### Project Structure

lib/
├── core/
│   ├── constants/ 
             ├──appColors.dart
             ├── appLinks.dart  
│   ├── utils/  
            ├── DeviceUtils.dart      
│   
├── features/
│       ├── Controller/  
             ├── Book_Cubit.dart  
             ├── Book_state.dart  
│       ├── View/  
             ├──Screen
                  ├── HomePage.dart  
                  ├── SplashScreen.dart  
             ├── SharedWidgets 
                  ├── BookListView.dart  
                  ├── SearchBar.dart  
   
│       └── data/ 
               ├── SQFlite.dart  
        └── model/
               ├── BookModel.dart  
        └── repo/
               ├── BookRepo.dart  

└── main.dart           

#Screenshots


