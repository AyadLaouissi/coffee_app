import 'dart:io';

import 'package:coffee/src/coffee/view/coffee_page.dart';
import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee/src/favourite/view/favourite_page.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.coffeeRepository,
    required this.documentDirectory,
  });

  final CoffeeRepository coffeeRepository;
  final Directory documentDirectory;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CoffeeRepository>(
      create: (context) => coffeeRepository,
      child: BlocProvider<FavouriteCubit>(
        create: (context) => FavouriteCubit(
          coffeeRepository,
          documentDirectory,
        ),
        child: MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(
            primarySwatch: Colors.brown,
          ),
          // darkTheme: ThemeData.dark(),
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case FavouritePage.routeName:
                    return const FavouritePage();
                  default:
                    return const CoffeePage();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
