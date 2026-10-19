import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final menuOpen = false.obs;
  final formSubmitted = false.obs;
  final formKey = GlobalKey<FormState>();

  final sectionKeys = <String, GlobalKey>{
    'home': GlobalKey(),
    'about': GlobalKey(),
    'services': GlobalKey(),
    'projects': GlobalKey(),
    'industries': GlobalKey(),
    'why': GlobalKey(),
    'values': GlobalKey(),
    'contact': GlobalKey(),
  };

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final serviceController = TextEditingController();
  final detailsController = TextEditingController();

  void scrollTo(String section) {
    menuOpen.value = false;
    final context = sectionKeys[section]?.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: 0.04,
    );
  }

  void submitQuote() {
    if (formKey.currentState?.validate() ?? false) {
      formSubmitted.value = true;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    serviceController.dispose();
    detailsController.dispose();
    super.onClose();
  }
}
