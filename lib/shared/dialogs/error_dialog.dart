import 'dart:developer';

import 'package:clean_architecture_cubit/presentation/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog {
  static unauthorizedError() {
    return Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Not authorized',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Text('You have to login'),
              TextButton(
                onPressed: () {
                  log('Go to Login');
                  Get.back();
                  // Get.offAll(
                  //   () => const MovieDetailsPage(
                  //     movieId: 19019,
                  //   ),
                  // )!
                  //     .then(
                  //   (value) => Get.back(),
                  // );
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
