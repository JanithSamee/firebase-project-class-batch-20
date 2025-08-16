import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/screens/UserScreen.dart';
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
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 15,
          children: [
            Text("Login"),
            TextField(
              onChanged:
                  (value) => setState(() {
                    username = value;
                  }),
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              onChanged:
                  (value) => setState(() {
                    password = value;
                  }),
              decoration: InputDecoration(labelText: "Password"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: username,
                        password: password,
                      );

                  Get.snackbar(
                    "Success",
                    "Success",
                    backgroundColor: Colors.lightGreen,
                  );
                  Get.to(() => UserScreen());
                  print(credential);
                } catch (e) {
                  Get.snackbar(
                    "Error",
                    "${e.toString()}",
                    backgroundColor: Colors.redAccent,
                  );
                  print(e);
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
