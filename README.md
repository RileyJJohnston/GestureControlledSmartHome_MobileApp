# Smart Home Flutter App

## Overview
###### This project implements the mobile application associated with the HomePixel team's capstone project for Carleton University. The app is responsible for configuring and remotely controlling the gesture-controlled smart home system developed for SYSC 4907: Carleton University capstone project.  

## Background
###### Smart home technology has become widespread and popular as a home automation tool, allowing users to remotely manage multiple appliances and systems. It has also become increasingly popular for people to use voice assistant technologies as the preferred method of controlling smart devices in a home; however, this technology is not compatible for everyone. As there are over 6500 languages in the world, it is not feasible for the system to be integrated with recognizing every dialect. Many people exist in the world with speech disorders and others are not able to speak at all. Our project amalgamates the use of hand gesture detection through machine learning to control a smart home system. This key functionality provides more individuals with control of a smart home system through a universal form of interaction. Our product is also remarkably versatile and would be especially useful in critical care facilities, configured to allow patients or elderly to call a nurse for help with just lifting their hand or finger. Our team aims to constantly strive to provide solutions as we value and promote inclusivity for all walks of life. 

## Application Flow
###### The purpose of the mobile application is to configure the system and provide users with a method of controlling the smart home remotely. The mobile application has several different pages including the Login/Registration Page, Home Page, Add Gesture Page, Configure Page, Control Page, and History Page. 

### Login Page & Registration Page
###### The mobile application is protected by a layer of security by integration with Google Firebase.  Users are required to register accounts and must provide login credentials in order to access the smart home system. Furthermore, all actuator actions executed by the system are logged to Firebase and can be viewed in the History page. 

### Home Page
###### Once an account is created and the user is logged into the application, the user is brought to the app’s home menu where he may navigate to the Configure page, Control page, History page, or Add Gesture page.
