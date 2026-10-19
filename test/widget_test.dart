import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:fw_es/main.dart';
import 'package:fw_es/modules/home/controllers/home_controller.dart';

void main() {
  testWidgets('renders the company site and validates quote requests', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(1280, 900)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FencingWorldApp());
    await tester.pump();

    expect(
      find.text('Smart Fencing Solutions.\nStronger Security.'),
      findsOneWidget,
    );
    expect(find.text('Fencing for every boundary'), findsOneWidget);
    expect(find.text('Made for the places that matter'), findsOneWidget);
    expect(find.text('Solutions across industries'), findsOneWidget);
    expect(find.text('Our core values'), findsOneWidget);
    expect(find.text('Request a quotation'), findsOneWidget);

    final controller = Get.find<HomeController>();
    expect(controller.formKey.currentState!.validate(), isFalse);

    controller.nameController.text = 'Asha Sharma';
    controller.phoneController.text = '+91 98765 43210';
    controller.emailController.text = 'asha@example.com';
    controller.serviceController.text = 'Chain Link Fencing';
    controller.detailsController.text = 'Perimeter fencing for our site.';
    expect(controller.formKey.currentState!.validate(), isTrue);

    controller.submitQuote();
    await tester.pump();
    expect(
      find.textContaining('Backend integration is pending'),
      findsOneWidget,
    );

    tester.view.physicalSize = const Size(1440, 900);
    await tester.pump();
    expect(find.text('Home'), findsWidgets);
    expect(tester.takeException(), isNull);

    tester.view.physicalSize = const Size(390, 844);
    await tester.pump();
    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
    expect(
      find.text('Smart Fencing\nSolutions.\nStronger Security.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
