import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:i_baza_profile/features/presentation/pages/emty_page.dart';
import 'package:i_baza_profile/features/presentation/pages/profile_edit_screen.dart';

import '../data/models/authentication_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? avatar;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box("Profile");
    final String photo;
    final String snfn;
    final String location;
    if (box.isEmpty) {
      photo = "";
      snfn = "";
      location = "";
    } else {
      AuthenticationUser authenticationUser = box.get("Profile");
      avatar = File(authenticationUser.photo);
      snfn = authenticationUser.snfn;
      location = authenticationUser.location;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Center(
            child: Text(
              "Profil ma’lumotlari",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 335,
                  width: double.infinity,
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 16,
                  child: Container(
                    height: 70,
                    width: 70,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    // ignore: unnecessary_null_comparison
                    child: avatar == null
                        ? const Icon(Icons.person, size: 30, color: Colors.grey)
                        : Image.file(
                      avatar!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ProfileEditScreen()),
                      );
                    },
                    child: SvgPicture.asset('assets/icons/edit.svg'),
                  ),
                ),
                Positioned(
                  top: 108,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('F.I.Sh',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey)),
                      Text(snfn,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Manzilingiz',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey)),
                      Text(location,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                      // Add more Text widgets as needed
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 76,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EmtyPage()),
                    );
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/exit.svg'),
                        Text('Chiqish', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFEEEE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
