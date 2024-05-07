// ignore_for_file: use_super_parameters, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 3;
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/login');
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/splash.png'),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: EdgeInsets.only(top: height),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/img/fellasicon.png'),
                  Text(
                    'HELLO FELLAS.',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      'Temukan segala jenis bunga dari berbagai belahan dunia!',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
