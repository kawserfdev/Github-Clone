# GitHub Flutter App

A simple Flutter app that fetches and displays GitHub user profile and repository information using the GitHub API. Built using Flutter with Riverpod for state management.

## 🔧 Features

### A. GitHub Profile Screen
Fetches and displays the following details of a GitHub user from:
```
https://api.github.com/users/<username>
```
- Name
- Avatar
- Bio
- Location
- Followers / Following count
- Public repositories count

### B. Repositories List Screen
Fetches and lists a GitHub user's public repositories from:
```
https://api.github.com/users/<username>/repos
```
Displays:
- Repository name
- Description
- Star count
- Language

Features:
- Infinite scroll pagination using `?per_page=10&page=1`
- Pull to refresh support

### C. Repository Detail Screen
On tapping a repository, navigates to a detail screen that:
- Displays the repository description, language, and stars
- Provides a button to open the repository in the browser

##  Expectations
- Clean and readable code
- Good structure and state management with `flutter_riverpod`
- Proper error handling and user feedback
- Efficient logic with loading states and pagination
- Follows good UI/UX principles

##  Packages Used
- `flutter_riverpod`: For state management
- `http`: For making API calls
- `url_launcher`: For opening GitHub repo links in browser

## Getting Started
1. Clone the repository
2. Run `flutter pub get`
3. Launch on your emulator or connected device:
```
flutter run
```


## Problem-Solving Task

A problem-solving algorithm is implemented in the branch removeDuplicates, inside this file:

gitbub_clone/problem_solving_file/removeDuplicates.dart

Problem: Remove Duplicates from Sorted Linked List

## Description

Given the head of a sorted linked list, delete all duplicates so each element appears only once.

## Example:

Input:  head = [1, 1, 2, 3, 3, 4, 4, 8, 8, 9, 9, 10]        
Output: 1,2,3,4,8,9,10

 Solution Language: Dart

## Getting Started

1. Clone the repository:
2. Checkout the removeDuplicates branch:
3. Run the removeDuplicates.dart code on this page
