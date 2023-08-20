Robots Race
===========

# Techinical Design

## Objective
A board game which contains a 7x7 board, two robots places in opposite places and a target randomly positioned on the matrix. For each turn, a robot may decide what the next move is, and leave a trail where no other robot could be moved. The roboto who finds the the target earns one point.

## System Architecture
Per the game simplicity, we are following the MVVM (Model-View-ViewModel) architecture. Each layer is represented as folder on the projects source code. The following layers are:

* Model: represents the data and business logic of the application.
* View: responsible for presenting the data to the user and capturing user interactions.
* ViewModel: acts as an intermediary between the Model and the View. Its primary role is to expose data and commands that the View can bind to.

Other solutions were considered, as VIPER, MVC, and MVP, but considering MVVM has a better fit to SwiftUI and the logic complexity does not require a more abstract sofware architecture, the MVVM architeture was chose to solve the given problem.

# Tutorial

## How to build and run

There is no dependencies and configuration to run the project! Just open the RobotsRace.xcworkspace project and run it on Product > Run (command + R).

Have fun!
