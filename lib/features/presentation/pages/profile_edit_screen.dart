import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/authentication_user.dart';
import '../profile_screen.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final box = Hive.box("Profile");
  late String photo;
  late String fish;
  late String location;

  File? avatar;

  Future<void> pickAvatar() async {
    ImagePicker imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        avatar = File(file.path);
      });
    }
  }

  @override
  void initState() {
    if (avatar == null) {
      if (box.isEmpty) {
        photo = "";
        fish = "";
        location = "";
      } else {
        AuthenticationUser authenticationUser = box.get("Profile");
        avatar = File(authenticationUser.photo);
        fish = authenticationUser.snfn;
        location = authenticationUser.location;
        nameController.text = authenticationUser.snfn;
        locationController.text = authenticationUser.location;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 75, right: 90),
          child: Text(
            "Profilni tahrirlash",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: 370,
                width: double.infinity,
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 16,
                child: GestureDetector(
                  onTap: () async {
                    await pickAvatar();
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: avatar == null
                        ? const Icon(Icons.person, size: 30, color: Colors.grey)
                        : Image.file(
                            avatar!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'F.I.Sh',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "edit name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                // left: 16,
                // right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manzilingiz',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      constraints:
                          BoxConstraints.tightFor(width: 340.0, height: 120.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: locationController,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 300),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  box.put(
                      "Profile",
                      AuthenticationUser(
                          photo: avatar!.path,
                          snfn: nameController.text,
                          location: locationController.text));
                });

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
              child: Text('Saqlash', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
