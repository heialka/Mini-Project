import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fellas_app/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text editing controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register() async {
    // Ambil nilai dari setiap text editing controller
    String username = usernameController.text.trim();
    String name = nameController.text.trim();
    String address = addressController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // You can do something with the form data here
    }

    // Buat objek Map yang berisi data pengguna
    Map<String, dynamic> userData = {
      'username': username,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
    };

    try {
      // Buat pengguna baru di Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: address,
        password: password,
      );

      // Ambil ID pengguna yang baru dibuat
      String userId = userCredential.user!.uid;

      // Simpan data pengguna ke Firestore
      await _firestore.collection('users').doc(userId).set(userData);

      // Tampilkan pesan sukses
      Get.snackbar(
        'Success',
        'User registered successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
      );

      // Clear text editing controllers setelah pendaftaran berhasil
      clearControllers();

      // Navigate to login page
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      // Tampilkan pesan error jika terjadi masalah saat pendaftaran
      Get.snackbar(
        'Error',
        'Failed to register user. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
      );
    }
  }

  // Fungsi untuk mengosongkan text editing controllers
  void clearControllers() {
    usernameController.clear();
    nameController.clear();
    addressController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  final formKey = GlobalKey<FormState>();
}
