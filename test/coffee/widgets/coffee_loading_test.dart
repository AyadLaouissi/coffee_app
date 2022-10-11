import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:coffee/src/coffee/widgets/coffee_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../view/coffee_page_test.dart';

void main() {
  group('CoffeeLoading', () {
    late Widget widget;
    late CoffeeCubit coffeeCubit;

    setUp(() {
      coffeeCubit = MockCoffeeCubit();
      widget = BlocProvider.value(
        value: coffeeCubit,
        child: const MaterialApp(
          home: CoffeeLoading(),
        ),
      );
    });

    testWidgets('render correct text and progress indicator', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.text('Loading Coffee...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
