import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB-mUpfdqVqak9zok1PoJQEbAFvosbUyoM",
      appId: "1:641019966598:android:648de668a9378df6070d07",
      messagingSenderId: "641019966598",
      projectId: "fellas-app",
      storageBucket: "gs://fellas-app.appspot.com",
    ),
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fellas Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
