# SampleJokeDemo
A app to hit the Geek Joke Popular API

* Show a list of jokes 
* Show Cached articles if network not available

We'll are using the most viewed section of this API.https://geek-jokes.sameerkumar.website/api?format=json To test this API, For testAPI we used

* all-sections for the section path component in the URL
* 1 for period

This is configurable in ServiceHelper.Swift file in Project. We used MVVM Design pattern and swift generic approach to develop this application. For CI/CD App using XcodeServer + Fastlane combination.

# App Flow:


<img src="https://i.ibb.co/k6QRTWs/ezgif-com-gif-maker.gif" width="414" height="896" />


# TODO

* Add the jokes in every minutes in the list.
* Max 10 jokes in the list.
* The new jokes replace old ones.
* In every 10 secods API fetch new joke, we can configure this.

# Installation

* Installation by cloning the repository
* Go to directory
* use command + B or Product -> Build to build the project
* Press run icon in Xcode or command + R to run the project on Simulator

# CI/CD

* Xcode Server + Fastlane combination is used for CI/CD. Xcode server bots post script will be used to trigger fastlane lanes. We canrun them using terminal also.

# XcodeServer And XcodeServer Bot

* Xcode server is setup on local development machine with a new user. Steps for Xcode Server Setup: https://developer.apple.com/library/content/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/index.html

* Xcode Bot is setup on development machine with git configuration using master branch. Bot run periodically once per-day and configured for the following jobs:

* Pull changes from remote repository if there any .
* Configure to test parallel on specific simulator.
* Run unit test cases.
* Run UI Test cases.
* Run the Static analyser for leaks and warnings.
* Generate the report for UnitTest,UITest,Static analyser on project codebase.
* We did not setup for exporting the build or code-singing for now as iTunes credential required. Once credential is there we can setup these activity by re-edit the XcodeServer Bot .
* Post script for trigger fastlane lanes for screen shot and fastlane+scan code coverage.
* To run fastlane lanes configure PATH in XcodeServer Bot configuration under environment tab

# PATH="/usr/local/bin:$PATH"

# Architecture

We used MVVM :

<a href="https://ibb.co/Z2gN23W"><img src="https://i.ibb.co/LNgvNMn/41942613-a4008032-79bd-11e8-98b5-a40e7d871203.png" alt="41942613-a4008032-79bd-11e8-98b5-a40e7d871203" border="0"></a><br /><a target='_blank' href='https://imgbb.com/'>image uploader</a><br />

