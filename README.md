# CV-Task
[![Coverage Status](https://coveralls.io/repos/github/Nitish145/CV-Task/badge.svg?branch=master)](https://coveralls.io/github/Nitish145/CV-Task?branch=master)
[![Build Status](https://travis-ci.org/Nitish145/CV-Task.svg?branch=master)](https://travis-ci.org/Nitish145/CV-Task)

This application contains MVP for the CircuitVerse Mobile.

## Setup Instructions

### Server Setup
We will be using `ngrok` to setup tunnel between `localhost` and `API`.

- Install `ngrok`.
- Open Terminal `(Ctrl + Alt + T)`
- `~ ngrok http 3000`
- Setup [CircuitVerse/CircuitVerse](https://github.com/CircuitVerse/CircuitVerse) on your machine (Instructions in `Readme.md`).
- Add `config.hosts << "{ngrok-base-url-without-http://}"` in `config/environments/development.rb`
- `rails s`

### Mobile App Setup
- Clone this repo.
- open in VScode/AndroidStudio.
- Go to `globals.dart`.
- Replace `url` with `ngrok-base-url`.
- Run the app with `flutter run`.
- See you localhost server live on Mobile.

## Below attatched are some GIFs attatched for CV Mobile

<p>
<img title="Home Page" src="https://user-images.githubusercontent.com/45434030/78035773-2c588780-7387-11ea-8596-68936a080d5b.gif" alt="Home Page" width="280" height="500">
<img title="Login Page" src="https://user-images.githubusercontent.com/45434030/78036138-95d89600-7387-11ea-9d3f-5991b4f12329.gif" alt="Login Page" width="280" height="500">
<img title="About Page" src="https://user-images.githubusercontent.com/45434030/78035479-c966f080-7386-11ea-9173-da494f41bb15.gif" alt="About Page" width="280" height="500">
<img title="Contribute Page" src="https://user-images.githubusercontent.com/45434030/78036321-c6203480-7387-11ea-8b13-bfbb075459d6.gif" alt="Contribute Page" width="280" height="500">
<img title="Teachers Page" src="https://user-images.githubusercontent.com/45434030/78036856-6b3b0d00-7388-11ea-9e31-3508bcaa70ac.gif" alt="Teachers Page" width="280" height="500">
<img title="Public Projects Page" src="https://user-images.githubusercontent.com/45434030/78035508-d71c7600-7386-11ea-9d33-63562d38ba00.gif" alt="Public Projects Page" width="280" height="500">
<img title="Logout Expansion Tile" src="https://user-images.githubusercontent.com/45434030/78035516-d97ed000-7386-11ea-837f-4d3751c5cfe4.gif" alt="Logout Expansion Tile" width="280" height="500">
</p>
