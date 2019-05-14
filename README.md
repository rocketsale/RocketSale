# RocketSale

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
The application connects buyers and sellers located in population dense areas (cities, universities, etc). The goal of the application is to simplify and speed up product transactions between peer groups. Could be potentially used to discover people with similar interests.

### App Evaluation
- **Category:** Shopping/Social Networking
- **Mobile:** This application will be optimized for iOS (mobile) because of the native mobile experience that people typically expect from an app that allows them to swipe through products they may be interested in. Also, this application will rely on location and map services, which are more mature features for mobile. However, this application could also function just as well as a web application. But it will need additional UI optimizations to do so.
- **Story:**  User browses through items and selects items of interest. Seller receives buyer information. Seller can post information about products that they are selling. Application will analyze user preferences to predict future products they may be interested in.
- **Market:** Any person living in a population dense area (i.e. college students, urban dwellers). People who are looking to conveniently buy and sell stuff they own. People who like to shop and receive products quickly.
- **Habit:** The average user, who is a casual shopper, will probably use this once every other week. A more frequent user, who shops regularly, will probably use this application daily to look for new deals. 
- **Scope:** We would first start with creating a product discovery app where people can upload products they want to sell and others can browse and search through products. The application will be focused primarily on college students initially (kind of like Free and For Sale Pages). The application will expand in functionality and streamlining the process for buyers and sellers. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create account and add personal information about themselves
* User can login to either buy or sell items
* Seller can list item for sale
* Seller can see a list of all of their listed items and their statuses
* Seller receives buyer contact information when buyer selects item
* Buyer can browse through items for sale
* Buyer can search through items for sale
* Buyer can select items to favorite
* Buyer can select item to purchase and notify sellers 
* Buyer can see all items that they favorited
* Buyer can see all items they are interested in buying

### 2. Screen Archetypes
* Login/Signup screen
   * Upon opening the application, the user will have the option to login with an existing account or sign up for a new account. 
* Signup information screen
   * After selecting the sign up button on the login screen, the user will be asked to enter their desired login information (username/password) and their profile information (display name & profile picture).
* Feed/Home screen
   * The feed displays a collection or table view of all of the products for sale. There will also be a search bar at the top for users to look for items that interest them
* Detailed Product screen
   * After selecting products from the home screen, the detailed product screen shows more information like descriptions, pricing, and location
* Profile screen
   * The profile screen shows user information such as the number of items listed, transactions completed, name, and profile picture
* Transaction list screen
   * The transaction lists screen allows users view pending/bought items and separately view pending/sold items.
* Detailed Buy Screen
   *User views a list of items they have bought or are in the process of buying.
* Detailed Sell Screen
   * User views a list of items they have sold or are in the process of selling.
* Favorites screen
   * User can view items they have selected while browsing and submit formal requests to buy them.
* List Item for Sale screen
   * User provides photos and a short description of their item to list on the marketplace.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Feed/Home screen
* Transaction list screen
* Favorites screen
* Profile screen

**Flow Navigation** (Screen to Screen)

* Login screen -> Forced signup or login if not logged in
* Signup screen -> Signup information screen -> Feed/Home screen
* Feed/Home screen -> Detailed Product screen
* Transaction list screen -> Detailed buy screen or Detailed sell screen
* Favorites screen -> Detailed Product screen
* Profile screen -> Login screen on logout

## Wireframes
[TODO]
