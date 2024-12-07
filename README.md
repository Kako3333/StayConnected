# Stay Connected
Stay Connected is an iOS app built using Xcode and UIKit, designed for developers to ask questions, answer other developers' questions, and earn scores based on their contributions.
# Table of Contents

## Introduction
## Features
## Architecture
## Installation
## Usage
## Contributing
## Introduction![Uploading Screenshot 2024-12-07 at 21.15.18.png…]()

<img width="211" alt="Screenshot 2024-12-07 at 21 14 33" src="https://github.com/user-attachments/assets/cc00085e-b0df-4890-a0ce-61e1d06ebb91">  
<img width="214" alt="Screenshot 2024-12-07 at 21 15 55" src="https://github.com/user-attachments/assets/ba9ec120-4afc-482f-8301-82d619687002">

<img width="214" alt="Screenshot 2024-12-07 at 21 16 38" src="https://github.com/user-attachments/assets/d55099f5-b092-4d70-adde-687d33dde3f8">

## The Stay Connected app provides a platform for developers to engage with each other, share knowledge, and build a community. The app allows users to:
	•	Ask questions on various programming topics
	•	Answer questions posted by other developers
	•	Earn scores based on the quality and quantity of their answers
	•	View their profile, including their question history and score
## The app integrates with a backend API for user authentication, question management, and score tracking.
## Features
	•	Ask Questions: Developers can ask questions on programming topics and seek help from the community.
	•	Answer Questions: Developers can browse and answer questions posted by other users, earning scores based on the quality of their answers.
	•	User Profiles: Developers can view their own profile, including their question history and score.
	•	Leaderboard: The app features a leaderboard that displays the top-scoring developers.
	•	Backend API Integration: The app integrates with a backend API for user authentication, question management, and score tracking.
# Architecture
## The Stay Connected app follows the Model-View-ViewModel (MVVM) architectural pattern. 
## StayConnectedApp.swift: The entry point of the app.
	2	Views:
	◦	StayConnectedView: The main view that displays the app's features.
	◦	AnsweredQuestionsPage: The view that displays the user's answered questions.
	◦	LoginPage: The view for user authentication.
	◦	ProfilePage: The view that displays the user's profile information.
	3	ViewControllers:
	◦	AnsweredQuestionsViewController: Manages the AnsweredQuestionsPage view.
	◦	LoginPageViewController: Manages the LoginPage view.
	◦	ProfilePageViewController: Manages the ProfilePage view.
	4	ViewModels:
	◦	AnsweredQuestionsViewModel: Handles the logic for displaying the user's answered questions.
	◦	LoginPageViewModel: Handles the logic for user authentication.
	◦	ProfilePageViewModel: Handles the logic for displaying the user's profile information.
	5	Models:
	◦	User: Represents the user's profile information.
	◦	Question: Represents a question posted by a developer.
	◦	Answer: Represents an answer provided by a developer.
	6	Networking:
	◦	APIClient: Handles the communication with the backend API for user authentication, question management, and score tracking.
## Installation
## To install and run the Stay Connected app, follow these steps:
	1	Clone the repository: git clone https://github.com/your-username/stay-connected.git
	2	Open the project in Xcode.
	3	Install the required dependencies (if any) using CocoaPods or Carthage.
	4	Configure the backend API integration by providing the necessary credentials or environment variables.
	5	Build and run the app on your iOS device or simulator.
## Usage
	1	Sign Up/Login: Users can sign up or log in to the app using their credentials.
	2	Ask Questions: Users can tap the "Ask Question" button to post a new question.
	3	Answer Questions: Users can browse the list of questions and tap on a question to provide an answer.
	4	View Profile: Users can tap on the profile icon to view their own profile, including their question history and score.
