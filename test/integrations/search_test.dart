import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:poc_clean/feature/catalog/widgets/product_card.dart';

import 'package:poc_clean/main.dart';

void main() {
  testWidgets(
    "should search products",
    (WidgetTester tester) async {
      mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(const MyApp());
          await tester.pumpAndSettle();

          expect(find.byType(ProductCard), findsNWidgets(2));

          final input = find.byType(TextField);
          expect(input, findsOneWidget);

          await tester.enterText(input, 'Cane');
          await tester.pump(const Duration(seconds: 1));
          expect(find.byType(ProductCard), findsNWidgets(1));

          await tester.enterText(input, 'Descricao_Que_Nao_Existe');
          await tester.pump(const Duration(seconds: 1));
          expect(find.byType(ProductCard), findsNothing);

          await tester.enterText(input, 'Alexa');
          await tester.pump(const Duration(seconds: 1));
          expect(find.byType(ProductCard), findsNWidgets(1));
        },
      );
    },
  );
}
