import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:poc_clean/feature/cart/views/checkout_view.dart';
import 'package:poc_clean/feature/cart/widgets/cart_counter.dart';
import 'package:poc_clean/feature/catalog/widgets/add_to_card_button.dart';
import 'package:poc_clean/feature/catalog/widgets/product_card.dart';

import 'package:poc_clean/main.dart';

void main() {
  testWidgets(
    "must add products to cart",
    (WidgetTester tester) async {
      mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(const MyApp());
          await tester.pumpAndSettle();

          expect(find.byType(CartCounter), findsOneWidget);
          expect(find.byType(Badge), findsNothing);

          expect(find.byType(AddToCardButton), findsWidgets);
          var buttonAddToCard = find.byType(AddToCardButton).first;
          await tester.tap(buttonAddToCard);
          await tester.pumpAndSettle();

          expect(find.byType(CartCounter), findsOneWidget);

          final badge = find.byType(Badge);
          expect(badge, findsOneWidget);
          expect(((badge.evaluate().single.widget as Badge).badgeContent as Text).data, '1');

          expect(find.byType(ProductCard), findsWidgets);

          final input = find.byType(TextField);
          expect(input, findsOneWidget);
          await tester.enterText(input, 'Alexa');
          await tester.pump(const Duration(seconds: 1));
          expect(find.byType(ProductCard), findsNWidgets(1));

          final productCard = find.byType(ProductCard).first;
          await tester.tap(productCard);
          await tester.pumpAndSettle();

          expect(find.byType(ProductCard), findsNothing);

          expect(find.byType(AddToCardButton), findsOneWidget);
          buttonAddToCard = find.byType(AddToCardButton).first;
          await tester.tap(buttonAddToCard);
          await tester.pumpAndSettle();

          expect(((badge.evaluate().single.widget as Badge).badgeContent as Text).data, '2');

          await tester.tap(buttonAddToCard);
          await tester.pumpAndSettle();

          expect(((badge.evaluate().single.widget as Badge).badgeContent as Text).data, '3');

          await tester.tap(badge);
          await tester.pumpAndSettle();

          expect(find.byType(CartCounter), findsNothing);
          expect(find.byType(CheckOutView), findsOneWidget);

          final list = find.byType(ListView);
          expect((list.evaluate().single.widget as ListView).semanticChildCount, 3);
        },
      );
    },
  );
}
