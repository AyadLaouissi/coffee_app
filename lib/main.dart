import 'package:coffee/src/app.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentsDirectory = await getApplicationDocumentsDirectory();

  final storage = await HydratedStorage.build(
    storageDirectory: documentsDirectory,
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(
      MyApp(
        coffeeRepository: CoffeeRepository(),
        directory: documentsDirectory,
      ),
    ),
    storage: storage,
  );
}
