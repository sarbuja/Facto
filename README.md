# Facto

A simple iOS SwiftUI App where we can go through random facts and favourite them. Favourited facts can be viewed offline too.

# Getting Started

1. You will need Xcode to run the project.
2. Either download the project zip or clone the project to your machine.
3. Open the Facto.xcodeproj file.
4. Run the active scheme (Facto).

# Architecture

The project is following Clean Architecture where the components are assigned to 3 different modules. Domain, Data and Presentation. A couple of screenshots for the app is shown below.

![home page](screenshot1.png)
![favourites page](screenshot2.png)

# External Frameworks

The project uses Swift Package Manager to manages 3rd party libraries. This is the list of frameworks used.
1. [Lottie](https://github.com/airbnb/lottie-ios) -> This framework renders vector-based animations with very little amount of code on app side.

# API

The project uses https://api-ninjas.com/api/facts REST api to fetch the facts.
