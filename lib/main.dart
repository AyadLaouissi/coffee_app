import 'package:coffee/src/app.dart';
import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_api/image_api.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentsDirectory = await getApplicationDocumentsDirectory();

  final storage = await HydratedStorage.build(
    storageDirectory: documentsDirectory,
  );

  final client = http.Client();

  HydratedBlocOverrides.runZoned(
    () => runApp(
      MyApp(
        coffeeRepository: CoffeeRepository(
          imageApi: ImageApi(httpClient: client),
          coffeeApiClient: CoffeeApiClient(httpClient: client),
        ),
        documentDirectory: documentsDirectory,
      ),
    ),
    storage: storage,
  );
}
