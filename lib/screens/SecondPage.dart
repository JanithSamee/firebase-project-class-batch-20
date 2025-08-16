import 'package:first_app/model/DataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});

  final Data dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(child: Obx(() => Text("data - ${dataController.count}"))),
          Center(
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Back"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Get.snackbar(
                  "Error",
                  "This is a message",
                  backgroundColor: Colors.redAccent,
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: Text("Snack Bar"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Get.defaultDialog(title: "Hello", content: Text("data"));
              },
              child: Text("Alert Dialog"),
            ),
          ),
        ],
      ),
    );
  }
}
