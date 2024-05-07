import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final HomeController controller = Get.find();
  final ImagePicker _picker = ImagePicker();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/img/home.png',
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello, ${userData['name']}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Obx(() => CircleAvatar(
                              radius: 26,
                              backgroundImage:
                                  controller.profilePhotoUrl.value.isNotEmpty
                                      ? NetworkImage(
                                          controller.profilePhotoUrl.value)
                                      : const AssetImage('assets/img/user.png')
                                          as ImageProvider,
                            )),
                      ],
                    ),
                    Text(
                      'How\'s your day going',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 5, color: Colors.black38),
                    const SizedBox(height: 8),
                    Text(
                      'My Phone Number: ${userData['phoneNumber']}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'My Address: ${userData['address']}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFD567CD), // Warna tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(300, 41),
                        ),
                        onPressed: () async {
                          final XFile? pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            controller.uploadPhoto(pickedFile.path);
                          }
                        },
                        child: Text(
                          'Upload Photo',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
