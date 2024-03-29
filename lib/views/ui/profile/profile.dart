// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sheoapp/service/store_data_Profile.dart';
import 'package:sheoapp/views/shared/app_style.dart';

import '../../../service/image_url.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final credential = FirebaseAuth.instance.currentUser;
  final userss = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('userSSS');
  File? imgPath;
  String? imgName;
  // uploadImage(ImageSource choosedPhoto) async {
  //   final pickedImg = await ImagePicker().pickImage(source: choosedPhoto);
  //   try {
  //     if (pickedImg != null) {
  //       setState(() {
  //         imgPath = File(pickedImg.path);
  //         imgName = basename(pickedImg.path);
  //         int random = Random().nextInt(9999999);
  //         imgName = "$random$imgName";
  //       });
  //     } else {
  //       showSnackBar(context, "NO img selected");
  //     }
  //   } catch (e) {
  //     showSnackBar(context, "Error => $e");
  //   }
  // }
  Uint8List? _image;
  selectImage() async {
    Uint8List img = await pickImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  saveProfile() async {
    String resp = await StoreData().saveData(file: _image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        leading: IconButton(
          icon: const Icon(
            Ionicons.qr_code_outline,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/usa.svg",
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      " |",
                      style: appstyle(20, Colors.grey, FontWeight.w500),
                    ),
                    Text(
                      " EGY",
                      style: appstyle(18, Colors.black, FontWeight.w600),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Ionicons.settings_outline,
                  color: Colors.black,
                )
              ],
            ),
          )
        ],
      ),
      body: Column(children: [
        Center(
          child: GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              // width: 30,
              // height: 30,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("LogOut"),
            ),
          ),
        )
        // Row(
        //   children: [
        //     Stack(
        //       children: [
        //         Container(
        //             padding: const EdgeInsets.all(3),
        //             decoration: const BoxDecoration(
        //                 shape: BoxShape.circle, color: Colors.grey),
        //             child: _image != null
        //                 ? CircleAvatar(
        //                     radius: 50,
        //                     backgroundImage: MemoryImage(_image!),
        //                   )
        //                 : const CircleAvatar(
        //                     radius: 50,
        //                     backgroundImage: NetworkImage(
        //                         "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
        //                   )),
        //         Positioned(
        //             top: 65,
        //             left: 65,
        //             child: Container(
        //               width: 40,
        //               height: 40,
        //               decoration: const BoxDecoration(
        //                   shape: BoxShape.circle, color: Colors.green),
        //               child: IconButton(
        //                   onPressed: () {
        //                     // showModalBottomSheet(
        //                     //     context: context,
        //                     //     builder: (BuildContext context) {
        //                     //       return Container(
        //                     //         padding: const EdgeInsets.all(22),
        //                     //         color: Colors.blue[200],
        //                     //         height: 120,
        //                     //         child: Row(
        //                     //           mainAxisAlignment:
        //                     //               MainAxisAlignment.spaceAround,
        //                     //           children: [
        //                     //             Container(
        //                     //               decoration: BoxDecoration(
        //                     //                   shape: BoxShape.circle,
        //                     //                   color: Colors.blue[500]),
        //                     //               child: IconButton(
        //                     //                   onPressed: () async {
        //                     //                     await uploadImage(
        //                     //                         ImageSource.gallery);
        //                     //                     if (imgPath != null) {
        //                     //                       final storageRef =
        //                     //                           FirebaseStorage.instance
        //                     //                               .ref(imgName);
        //                     //                       await storageRef
        //                     //                           .putFile(imgPath!);
        //                     //                       String url = await storageRef
        //                     //                           .getDownloadURL();
        //                     //                       users
        //                     //                           .doc(credential!.uid)
        //                     //                           .update({
        //                     //                         "imageLink": url,
        //                     //                       });
        //                     //                     }
        //                     //                   },
        //                     //                   icon: const Icon(
        //                     //                       Icons.add_photo_alternate)),
        //                     //             ),
        //                     //             const SizedBox(
        //                     //               width: 22,
        //                     //             ),
        //                     //             Container(
        //                     //               decoration: BoxDecoration(
        //                     //                   shape: BoxShape.circle,
        //                     //                   color: Colors.blue[500]),
        //                     //               child: IconButton(
        //                     //                   onPressed: () async {
        //                     //                     await uploadImage(
        //                     //                         ImageSource.camera);
        //                     //                     if (imgPath != null) {
        //                     //                       final storageRef =
        //                     //                           FirebaseStorage.instance
        //                     //                               .ref(imgName);
        //                     //                       await storageRef
        //                     //                           .putFile(imgPath!);

        //                     //                       String url = await storageRef
        //                     //                           .getDownloadURL();
        //                     //                       users
        //                     //                           .doc(credential!.uid)
        //                     //                           .update({
        //                     //                         "imgURL": url,
        //                     //                       });
        //                     //                     }
        //                     //                     void onButtonTapped(
        //                     //                         BuildContext context) {
        //                     //                       Navigator.of(context).pop();
        //                     //                     }
        //                     //                   },
        //                     //                   icon: const Icon(
        //                     //                       Icons.add_a_photo_outlined)),
        //                     //             ),
        //                     //           ],
        //                     //         ),
        //                     //       );
        //                     //     },
        //                     //     isScrollControlled: true);
        //                     setState(() {
        //                       selectImage();
        //                     });
        //                   },
        //                   color: Colors.white,
        //                   icon: const Icon(Icons.add_a_photo_sharp)),
        //             )),
        //       ],
        //     ),
        //     Column(
        //       children: [
        //         Text(
        //           "UserName",
        //           style: appstyle(18, Colors.black, FontWeight.w600),
        //         ),
        //         const SizedBox(
        //           height: 5,
        //         ),
        //         Text(
        //           "Email",
        //           style: appstyle(16, Colors.black, FontWeight.w500),
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        // ElevatedButton(
        //     onPressed: () {
        //       saveProfile();
        //     },
        //     child: const Text("Save"))
      ]),
    );
  }
}
