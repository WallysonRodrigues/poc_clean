import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:poc_clean/feature/cart/views/checkout_view.dart';
import 'package:poc_clean/feature/cart/widgets/cart_counter.dart';
import 'package:poc_clean/feature/catalog/views/product_detail_view.dart';
import 'package:poc_clean/feature/catalog/widgets/add_to_card_button.dart';
import 'package:poc_clean/feature/catalog/widgets/product_card.dart';

import 'package:poc_clean/main.dart';

void main() {
  testWidgets(
    "must navigate to detail page and checkout page",
    (WidgetTester tester) async {
      mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(const MyApp());
          await tester.pumpAndSettle();

          expect(find.byType(ProductCard), findsWidgets);

          final productCard = find.byType(ProductCard).first;
          await tester.tap(productCard);
          await tester.pumpAndSettle();

          expect(find.byType(ProductCard), findsNothing);
          expect(find.byType(ProductDetailView), findsOneWidget);

          expect(find.byType(AddToCardButton), findsOneWidget);
          final buttonAddToCard = find.byType(AddToCardButton).first;
          await tester.tap(buttonAddToCard);
          await tester.pumpAndSettle();

          final badge = find.byType(Badge);
          expect(badge, findsOneWidget);
          await tester.tap(badge);
          await tester.pumpAndSettle();

          expect(find.byType(CartCounter), findsNothing);
          expect(find.byType(CheckOutView), findsOneWidget);

          final list = find.byType(ListView);
          expect((list.evaluate().single.widget as ListView).semanticChildCount, 1);
        },
      );
    },
  );
}
