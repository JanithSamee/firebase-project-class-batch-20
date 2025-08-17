import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(home: Scaffold(appBar: AppBar(), body: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> taskList = [];

  late FirebaseFirestore db;

  String taskInput = "";

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;

    db.collection("test").get().then((event) {
      for (var doc in event.docs) {
        var data = doc.data();
        setState(() {
          taskList.add({
            "done": data["done"],
            "task": data["task"],
            "id": doc.id,
          });
        });
      }
    });
  }

  Future<void> addData() async {
    db
        .collection("test")
        .add({"done": false, "task": taskInput})
        .then(
          (DocumentReference doc) => setState(() {
            taskList.add({"done": false, "task": taskInput, "id": doc.id});
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Add Task",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        onChanged:
                            (value) => setState(() {
                              taskInput = value;
                            }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter task",
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          addData();
                          Get.back();
                        },
                        child: Text("Add"),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
              );
            },
            child: Text("Add Task"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: Checkbox(
                      value:
                          taskList[index]["done"], // Replace with your task completion status
                      onChanged: (value) {
                        // Handle checkbox change
                      },
                    ),
                    title: Text(
                      taskList[index]["task"],
                    ), // Replace with actual task title
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        db
                            .collection("test")
                            .doc(taskList[index]["id"])
                            .delete()
                            .then(
                              (doc) {
                                Get.snackbar("Success", "Deleted ");
                                setState(() {
                                  taskList.removeWhere(
                                    (item) => item.id == taskList[index]["id"],
                                  );
                                });
                              },
                              onError:
                                  (e) => Get.snackbar(
                                    "error",
                                    "Error updating document $e",
                                  ),
                            );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
