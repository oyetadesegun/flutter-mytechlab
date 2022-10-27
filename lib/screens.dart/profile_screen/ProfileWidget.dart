import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mytechlab/components/constants/colors.dart';
import '../../data/user_data.dart';
import 'Edit_Profile_Screen.dart';

class ProfileWidget extends StatefulWidget {
  //File? pImage;
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;
  ProfileWidget({
    //required this.pImage,
    required this.imagePath,
    required this.onClicked,
    this.isEdit = false,
  });

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState(onClicked);
}

class _ProfileWidgetState extends State<ProfileWidget> {
  File? pImage;

  final VoidCallback openDrawer;

  _ProfileWidgetState(this.openDrawer);
  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pImage = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = NetworkImage(widget.imagePath);
    final color = Theme.of(context).colorScheme.primary;
    // Future uploadPic(BuildContext context) async {
    //   String fileName = basename(pImage!.path);
    //   Reference firebaseStorageRef =
    //       FirebaseStorage.instance.ref().child(fileName);
    //   UploadTask uploadTask = firebaseStorageRef.putFile(pImage!);
    //   TaskSnapshot taskSnapshot = await uploadTask;
    //   setState(() {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text("Profile Picture Uploaded")));
    //   });
    // }

    return Builder(builder: (context) {
      return Center(
        child: Stack(children: [
          //buildImage(),
          CircleAvatar(
            radius: 70,
            child: ClipOval(
                child: SizedBox(
                    width: 180,
                    height: 180,
                    child: (pImage != null
                        ? Image.file(
                            pImage!,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            Constants.myProfilePic,
                            fit: BoxFit.fill,
                          )))),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: GestureDetector(
                onTap: () async {
                  widget.isEdit
                      ? getImage()
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                                openDrawer: openDrawer,
                              )));
                },
                child: buildEditIcon(color)),
          ),
        ]),
      );
    });
  }

  Widget buildImage() {
    final image = NetworkImage(widget.imagePath);

    return Ink(
      child: Material(
        // color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: widget.onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: kAccent,
        all: 8,
        child: Icon(
          widget.isEdit ? Icons.add_a_photo : Icons.edit,
          size: 20,
          color: Colors.white,
        ),
      ));

  buildCircle(
          {required Color color, required double all, required Widget child}) =>
      ClipOval(
        child: Container(
          child: child,
          padding: EdgeInsets.all(all),
          color: color,
        ),
      );
}
