import 'dart:io';

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_repository/src/models/coffee.dart';
import 'package:image_api/image_api.dart';

class CoffeeRepository {
  CoffeeRepository({
    CoffeeApiClient? coffeeApiClient,
    ImageApi? imageApi,
  })  : _imageApi = imageApi ?? ImageApi(),
        _coffeeApiClient = coffeeApiClient ?? CoffeeApiClient();

  final CoffeeApiClient _coffeeApiClient;
  final ImageApi _imageApi;

  /// returns a coffee model with the url and image
  Future<Coffee> getRandomCoffeeImage() async {
    final url = await _coffeeApiClient.getRandomCoffee();
    final image = await _imageApi.getTempImage(url);

    return Coffee(
      url: url,
      image: image,
    );
  }

  /// Saves the coffee image to the application directory
  Future<File> saveCoffeeImage(Coffee coffee) =>
      _imageApi.saveImage(coffee.image);

  /// Removes the coffee image from the application directory
  Future<void> removeCoffeeImage(Coffee coffee) =>
      _imageApi.removeImage(coffee.image);
}
