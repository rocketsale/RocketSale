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
![](https://i.imgur.com/KOjQfIE.jpg)

## Schema

### Models

#### User

| Property      | Type          | Description  |
| --- | --- | --- |
| phoneNUmber      | String | User's phone number |
| profilePicture      | PFFileObject     |   User's profile picture |
| interests | [Strings]      |    User's interests used for buyers to find like-minded sellers |
| numberOfItemsBought | Int | Number of products user has bought |
| numberOfItemsUpForSale | Int | Number of products user has listed that are available for purchase |
| numberOfItemsSold | Int | Number of products user has sold |
| favoritedProducts | [Product] | Products user has "liked" on the feed |
| purchasedProducts | [Product] | Products user had bought |

#### Product

| Property      | Type          | Description  |
| ------------- | ------------- | ----- |
| name      | String | User's phone number |
| blurb      | String     |   Name of the product given by seller |
| price | Double      |    Price of the product set by seller |
| picture | PFFileObject | Picture of the product uploaded by seller |
| tags | [String] | Tags assigned to the product allowing users' to search for it by tag |
| seller | User | User who listed the product for sale|
| isPurchased | Bool | True if a user has bought the product |
| purchaser | User | User who bought the product |
| favoritedUser | [User] | Users who have "liked" the product on the feed |
| latitude | Double | Latitude coordinate of the product |
| longitude | Double | Longitude coordinate of the product |

### Networking

#### List of network requests by screen

* Login Screen
    * (Read/GET) Log in user
    ![](https://i.imgur.com/NseuxzM.png)
* Signup Screen
    * (Create/POST) Signup new user
* Home Feed Screen
    * (find/READ) Query all recent products available to purchase
    ![](https://i.imgur.com/9JvFxV0.png)
    * (find/READ) Query all products with tags specified by user
    * (Update/PUT) "Like" product
* List Product Screen
     * (Create/POST) List product for sale
     ![](https://i.imgur.com/ie7t4Rd.png)
* Detailed Product Screen
    * (Update/PUT) Buy product
* Transactions Screen
    * (find/READ) Query all products user has bought
    * (find/READ) Query all products user has sold
* Favorites Screen
    * (find/READ) Query all products user has "liked"
    * (Update/PUT) "Unlike" product
* Profile Screen
    * (Read/GET) Query current user
* Edit Profile Screen
    * (Update/PUT) Edit user profile information


## Video Walkthrough

Here's a walkthrough of implemented user stories:

Signing Up A New User

<img src='http://g.recordit.co/pa1T9gxWlC.gif' title='Edit Profile Walkthrough' width='' alt='Edit Profile Walkthrough' />

Home Feed

<img src='http://g.recordit.co/ugprygz0H6.gif' title='Home Feed/Search Walkthrough' width='' alt='Home Feed/Search Walkthrough' />

Product Map

<img src='http://g.recordit.co/dw2P5OMbIj.gif' title='Map Walkthrough' width='' alt='Map Walkthrough' />

Buying a Product

<img src='http://g.recordit.co/jL43Itv7Yu.gif' title='Buy Product Walkthrough' width='' alt='Buy Product Walkthrough' />

Liking a Product

<img src='http://g.recordit.co/WTcKAHb5Kt.gif' title='Favorite Product Walkthrough' width='' alt='Favorite Product Walkthrough' />

Editing User Information

<img src='http://g.recordit.co/xta85oUe2x.gif' title='Edit Profile Walkthrough' width='' alt='Edit Profile Walkthrough' />

## Presentation

Here's our group's [presentation](https://docs.google.com/presentation/d/1K4hWnZvDNBNhtFP86CC2isnme1pPXQQFDEsXKq6Rmbc/edit?usp=sharing) for CodePath at UCI's Demo Day 6/8/19.
