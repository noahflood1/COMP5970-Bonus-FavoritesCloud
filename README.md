# FavoritesCloud

Educational project to learn Swift and MVVM design.

Track your favorite cities, books, and hobbies and store that informaton in the cloud.

# Assignment requirements

## Bonus Assignment requirements:

In this bonus assignment, you'll create a new version of the Favorites app that stores data using Firebase Firestore instead of local storage.

Rebuild the Favorites app (with cities, hobbies, and books), but this time:

- Allow users to add or remove their favorite items just like before.
- Instead of using UserDefaults, store and fetch all favorite data from Firestore.
- Make sure each user sees only their own favorites — link data to the currently signed-in user using Firebase Authentication.
- Requirements
- Use Firestore to store favorite items.
- Fetch data on app load and display in each section (cities, hobbies, books).
- Allow users to update their favorites and reflect those changes in Firestore.
- Refactor your application using MVVM pattern.
- The application should run for all size classes, including iPads, and for the landscape orientation.

### Requirments from Assignment 8

Use a three-tab layout to explore cities, hobbies, and books. On the Home tab, show categories using custom views. Cities appear as cards with background images and text, while hobbies are listed with SF Symbol icons.
Allow users to favorite items with a heart button. Track favorites locally and view them in the Favorites tab. In the Settings tab, provide options to switch dark/light mode and clear all favorites.

Finish the Favorites application by adding the missing features for Books and Favorites display.

- Use the existing hardcoded books data in your FavoritesViewModel. Display the Books category alongside Cities and Hobbies in HomeView.
- Show the list of books with their titles and authors. Allow users to favorite and unfavorite books just like other categories.
- Update the Favorites tab to display all favorited cities, hobbies, and books.
- Allow removing items directly from the Favorites tab by unfavoriting them, and ensure the list updates immediately.
- Keep using the shared FavoritesViewModel so favorites stay in sync across all tabs.
- Make sure your UI remains consistent with the existing app design.

## Note about `GoogleService-Info.plist'

This code requires a `GoogleService-Info.plist` file to be added to the Project so that it can connnect to my Firebase. 

If you are the grader for this, I will send you this file directly.
