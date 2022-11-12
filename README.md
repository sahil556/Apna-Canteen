<!-- <h1 align="center">musicify 🎶</h1> -->
<p align="center"><img src="https://github.com/sahil556/Apna-Canteen/blob/main/user_app/assets/images/menus/ic_food_express.png"  width = 40%></p>


<div align="center">
<a href="https://github.com/sahil556/Apna-Canteen/network/members"><img src="https://img.shields.io/github/forks/sahil556/Apna-Canteen?color=orange&style=for-the-badge" alt="Forks"/></a>
<a href="https://github.com/sahil556/Apna-Canteen"><img src="https://img.shields.io/github/stars/sahil556/Apna-Canteen?color=yellow&style=for-the-badge" alt="Stars"/></a>
<a><img src="https://img.shields.io/github/issues/sahil556/Apna-Canteen?color=white&style=for-the-badge"/></a>
<a><img src="https://img.shields.io/github/issues-pr/sahil556/Apna-Canteen?color=lightblue&style=for-the-badge"></a>
<a href="https://github.com/sahil556/Apna-Canteen/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/sahil556/Apna-Canteen?color=lightgreen&style=for-the-badge"></a>
</div>

## Contribution Guidelines 🏗
```
1. Make sure to make UI consistency while adding new features to Apna-Canteen
2. Use the packages which are compatible with our appplication.
3. Make sure that your code is well documented to be easily readable and understandable, especially in tougher areas.
4. Use the uniform naming convention throughout the codebase.
5. Make sure that the code is as modular as possible.
6. Separate UI and logic part
7. Do not spam unnecessary merge requests.
```

<p align="left"><img src="https://user-images.githubusercontent.com/84856389/193465719-f208d8c9-9da6-4745-ad7b-1a18a046e1b8.jpg"  width = 40%></p>

**1.**  Fork [this](https://github.com/sahil556/Apna-Canteen/fork) repository.

**2.**  Clone your forked copy of the project.

```
git clone https://github.com/<your_user_name>/Apna-Canteen.git
```

**3.** Open Android Studio or Install it from [here.](https://developer.android.com/studio) 


**4.** Open project in android studio.


## Adding  Firebase to our android application via Firebase console

**1.** go to the [Firebase Console](https://firebase.google.com/) and click on get started.

**2.** we first have to create a Firebase project. Firebase project will go through and describe what it is. This allows us to add an app to that project can have many projects inside of Firebase. Click on Create a Project.

**3.** give a name and id to the project, enable Google Analytics for the project, set an analytics location, and accept all the terms and conditions. Firebase console automatically creates a unique id for the project. Finally Click on Create Project.

**4.** once project is created (it takes some time) click on continue to enter in our project.

**5.** In this step, we have to choose the platform to add Firebase to our application. The platform can be Android, iOS, Web, and Unity. 
- Choose Android.

**6.** In this step, we have to mention the package name, and the package name is the mandatory and important thing. The package name should be matched with our Android applications package name. You can find the package name of our application in Your Android project -> android/app/build.gradle -> defaultConfig -> applicationId. 
- Other fields are optional, so click on Register App.


**7.** It is one of the most important steps. In this step, we have to download the google-services.json file. This file is provided by Firebase for us to put it inside our application folder in our application. Download it and put it inside android/app/
- Note: *this file might be there, if so replace it with downloaded file.*



**8.** In the next step, we will add the Firebase SDK. This has been done inside the Android Studio. We have to modify the build. Gradle files. But it is already done. so no need to do it.

- Click on Next button.

**Click on continue to console. Firebase setup is done.**

## Let’s Setup Firestore database:

**1.** Click on firestore database in left panel.

**2.** Click on create database & choose in production mode & click next & select firestore location as asia-south1 (Mumbai) & click on enable.

**3.** Click on start collection & provide collection id  categories click next and click autoid in document id and save it.
- Do the above step for 5 time for following collections:
feedback, orders, products, startstop, users.


**Firestore setup is also complete.**

- In Android Studio run this command on console ```flutter pub get```
- It install all the required dependency. 
- After that select Emulator and click on run button.


 **Congratulations!** You're good to go! 🙌

<p align="left"><img src="https://user-images.githubusercontent.com/84856389/193466574-8a0d5108-f30a-40a9-be49-e78143548960.jpg"  width = 40%></p>

For further details, Refer [Firebase documentation.](https://firebase.google.com/docs)

<h2 align= "left"><b>Code of Conduct</b></h2>

<h1 align= "left"><b>Who are the makers of Apna-Canteen ?</b></h1>

<!--|<img src="https://avatars.githubusercontent.com/u/82492391?v=4">|<img src="https://avatars.githubusercontent.com/u/84856389?v=4">|<img src="https://avatars.githubusercontent.com/u/86891879?v=4">| 
|----------------------------|--------|----------------------------|
<p align="center"> -->
- [Sahil Nandaniya](https://github.com/sahil556)
- [Parshwa Mehta](https://github.com/parshwa0510)
