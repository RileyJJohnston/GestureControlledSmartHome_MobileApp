# Smart Home Flutter App

## Overview
###### This project implements the mobile application associated with the HomePixel team's capstone project for Carleton University. The app is responsible for configuring and remotely controlling the gesture-controlled smart home system developed for SYSC 4907: Carleton University capstone project.  

## Background
###### Smart home technology has become widespread and popular as a home automation tool, allowing users to remotely manage multiple appliances and systems. It has also become increasingly popular for people to use voice assistant technologies as the preferred method of controlling smart devices in a home; however, this technology is not compatible for everyone. As there are over 6500 languages in the world, it is not feasible for the system to be integrated with recognizing every dialect. Many people exist in the world with speech disorders and others are not able to speak at all. Our project amalgamates the use of hand gesture detection through machine learning to control a smart home system. This key functionality provides more individuals with control of a smart home system through a universal form of interaction. Our product is also remarkably versatile and would be especially useful in critical care facilities, configured to allow patients or elderly to call a nurse for help with just lifting their hand or finger. Our team aims to constantly strive to provide solutions as we value and promote inclusivity for all walks of life. 

## Application Flow
###### The purpose of the mobile application is to configure the system and provide users with a method of controlling the smart home remotely. The mobile application has several different pages including the Login/Registration Page, Home Page, Add Gesture Page, Configure Page, Control Page, and History Page. 

#### Login Page & Registration Page
###### The mobile application is protected by a layer of security by integration with Google Firebase.  Users are required to register accounts and must provide login credentials in order to access the smart home system. Furthermore, all actuator actions executed by the system are logged to Firebase and can be viewed in the History page. 

#### Home Page
###### Once an account is created and the user is logged into the application, the user is brought to the app’s home menu where he may navigate to the Configure page, Control page, History page, or Add Gesture page.

#### Add Gesture Page
###### The Add Gesture page allows the user to register a new gesture and associate it with an actuator that it will control.  The user must assign a name and associated actuator as well as take a photo of his hand showing the new gesture.  When submitted, the picture is uploaded to Firebase Storage and the data is uploaded to Firebase Realtime Database.  The new gesture may now be used to control the selected actuator.  

#### Configure Page
###### The configure page provides a way for the user to add actuators, modify actuators, remove actuators, or set associated gestures.  When an actuator is added to the smart home, it must be added to the system by specifying its IP address in the mobile application’s Configure page. The IP address specified for each actuator must represent the local IP address of the physical device.  As well as the default gestures provided, users may register custom gestures with the system in the Add Gestures page.  Users may configure which gesture control each actuator. 

#### Control Page
###### Users directly control each actuator through the Control page.  When an actuator is selected, an MQTT message is published via HiveMQ to the server.  The server responds in real-time by delivering a message to the appropriate actuator using the Kasa API. 

#### History Page
###### The history page displays to the user a log of past actuator events.  It does so by fetching the event log from Firebase Realtime Database. 

## Integration with Cloud Services
#### Firebase Authentication
###### Google Firebase provides cloud-based authentication services for the mobile application. The user can securely login to their account from any network. 

###### To access the application, the user must create an account.  Through this account only, the user will be able to access his smart home environment.  All login attempts are checked against the credentials stored in the Firebase Authentication database.   

###### Using a secure cloud service to provide authentication ensures that no data is stored on the device (or on the system’s server), which could be exploited by an attacker. By using Firebase Authentication, users can rest assured that their data remains confidential, as this Google service implements industry standard protocols such as OpenID connect.   

#### HiveMQ
###### HiveMQ provides a broker for the MQTT protocol. The server subscribes to a channel and receives updates when they are published. In normal use, the server will receive messages when a gesture has been detected by the client. To aid in debugging and as a useful tool, the ability to publish a message to a MQTT channel was added to the mobile application.

###### In the mobile application there is a control page that lists the devices the server is connected to. When one of the devices is selected it will publish a message to the correct MQTT channel. The server will receive the message and activate the corresponding smart home device. 

#### Firebase Storage
###### Firebase Storage provides cloud storage in the form of a buckets.  A bucket stores files in the form of a filesystem.  This form of storage is convenient for storing files with a specific file type (e.g. .jpg or .txt); however, it inherently comes with latency.  Thus, uploads may take seconds to become available.  This is an unacceptable level of latency for controlling actuators from actions.  Despite this, Firebase Storage is used to store profile pictures and photos of hand gestures as latency is not a critical factor when registering new gestures and users. 

#### Firebase Realtime Database
###### Firebase Realtime Database is a lightweight NoSQL database optimized for low latency queries.  By using this form of database, the server and mobile application can very quickly share JSON data.  The quick response time makes the database perfect for storing system configuration data.  This data includes a list of all the actuators (which are devices) that are available in the system.  This also includes a list of gestures.  Each gesture entry in the database indicates which actuator it is associated with.
