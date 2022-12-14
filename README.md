# coffee app

<p align="center">
    <img src="https://raw.githubusercontent.com/AyadLaouissi/coffee_app/main/screenshots/home.png" width="200"/>
    <img src="https://raw.githubusercontent.com/AyadLaouissi/coffee_app/main/screenshots/home_loaded.png" width="200"/>
    <img src="https://raw.githubusercontent.com/AyadLaouissi/coffee_app/main/screenshots/favourite.png" width="200"/>
</p>

In the coffee app you are able to get random coffee images and save to your favourites.
You are able to check your favourite images offline

## Getting Started ๐

To run the desired project either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
$ flutter run
```

Coffee app works on Android and iOS.

---

## Running Tests ๐งช

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/
# Open Coverage Report
$ open coverage/index.html
```
