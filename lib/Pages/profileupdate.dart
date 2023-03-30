import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sanad/Theme/color.dart';
import 'package:sanad/pages/profile.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/utils/sharepref.dart';
import 'package:sanad/utils/utility.dart';
import 'package:sanad/widget/CustomDropDown.dart';
import 'package:sanad/widget/myText.dart';
import 'package:sanad/widget/myappbar.dart';
import 'package:sanad/widget/mynetimage.dart';

bool topBar = false;

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final SingleValueDropDownController genderController =
      SingleValueDropDownController();
  final SingleValueDropDownController countryController =
      SingleValueDropDownController();
  String? profilePic;
  XFile? _image;
  String? userId;
  // String? userCountry;
  SharePref sharePref = SharePref();

  _imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  initState() {
    getUserId();
    // getUserCountry();
    super.initState();
  }

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID===>${userId.toString()}');

    final profiledata = Provider.of<ApiProvider>(context, listen: false);
    await profiledata.getProfile(context, userId);
  }

  // getUserCountry() async {
  //   userCountry = await sharePref.read('userCountry') ?? '"';
  //   debugPrint('userCountry===>${userCountry.toString()}');
  // }

  @override
  Widget build(BuildContext context) {
    return buildProfile();
  }

  buildProfile() {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dash_bg.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(50.0, 50.0)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getAppbar(),
                  buildHeader(),
                ],
              ),
            ]),
            buildData(),
          ],
        ),
      ),
    );
  }

  getAppbar() {
    return const MyAppbar(title: "Edit Profile");
  }

  buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                _showPicker(context);
              },
              child: Consumer<ApiProvider>(
                builder: (context, profile, child) {
                  return Opacity(
                    opacity: 0.5,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              File(_image!.path),
                              width: 120,
                              height: 120,
                              fit: BoxFit.fill,
                            ),
                          )
                        : (profile.profileModel.result?[0].profileImg
                                        .toString() ??
                                    "")
                                .isEmpty
                            ? Image.asset(
                                'assets/images/ic_user_default.png',
                                width: 120,
                                height: 120,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: MyNetImage(
                                    width: 120,
                                    height: 120,
                                    imagePath: profile
                                            .profileModel.result?[0].profileImg
                                            .toString() ??
                                        ""),
                              ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ]),
          Positioned(
              child: InkWell(
            onTap: () {
              _showPicker(context);
            },
            child: Image.asset(
              'assets/images/ic_camera.png',
              height: 70,
            ),
          ))
        ],
      ),
    );
  }

  buildData() {
    return Consumer<ApiProvider>(
      builder: (context, profiledata, child) {
        print(nameController.text.toString());
        if (nameController.text.isEmpty) {
          countryController.dropDownValue = DropDownValueModel(
              name: profiledata.profileModel.result![0].country!, value: 1);
          genderController.dropDownValue = DropDownValueModel(
              name: profiledata.profileModel.result![0].gender!, value: 1);
          nameController.text =
              profiledata.profileModel.result?[0].fullname.toString() ?? "";
          emailController.text =
              profiledata.profileModel.result?[0].email.toString() ?? "";
          contactController.text =
              profiledata.profileModel.result?[0].mobileNumber.toString() ?? "";
          // _addressController.text =
          //     profiledata.profileModel.result?[0].biodata.toString() ?? "";
          ageController.text =
              profiledata.profileModel.result![0].age.toString() ?? '';
          // _addressController.text = userCountry ?? 'address';
        }
        profilePic =
            profiledata.profileModel.result?[0].profileImg.toString() ?? "";
        List<DropDownValueModel> genderTypeList = [
          const DropDownValueModel(name: 'Female', value: 0),
          const DropDownValueModel(name: 'Male', value: 1),
        ];
        List<DropDownValueModel> countryTypeList = [
          const DropDownValueModel(name: 'Egypt', value: 0),
          const DropDownValueModel(name: 'Malaysia', value: 1),
        ];

        // File f =
        //     File(profiledata.profileModel.result?[0].biodata.toString() ?? "");
        // _image = XFile(f.path);

        return Container(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                formField("Name", "assets/images/ic_profile_user.png",
                    nameController),
                formField("Email", "assets/images/ic_profile_email.png",
                    emailController),
                formField("Contact No", "assets/images/ic_profile_contact.png",
                    contactController),
                // formField("Address", "assets/images/ic_profile_address.png",
                //     _addressController),
                formField(
                    'Age', "assets/images/ic_profile_user.png", ageController),
                const SizedBox(
                  height: 20,
                ),
                MyCustomDropDown(
                    dropDownValueList: genderTypeList,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Gender cant be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      sharePref.save('userGender', value.name);
                    },
                    borderSide: BorderSide(color: baseColor, width: 2),
                    enableDropDown: true,
                    controller: genderController,
                    label: const Text('Select Your Gander')),
                const SizedBox(
                  height: 20,
                ),
                MyCustomDropDown(
                    dropDownValueList: countryTypeList,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Country cant be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      sharePref.save('userCountry', value.name);
                    },
                    borderSide: const BorderSide(color: baseColor, width: 2),
                    enableDropDown: true,
                    controller: countryController,
                    label: const Text('Select Your Gander')),
                const SizedBox(height: 40),
                Center(
                  child: TextButton(
                      onPressed: () {
                        updateProfile();
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(200, 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28.0))),
                          backgroundColor: MaterialStateProperty.all(appColor)),
                      child: MyText(
                        title: ' Save ',
                        size: 18,
                        fontWeight: FontWeight.w500,
                        colors: white,
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  formField(String title, String iconpath, var contl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        MyText(
            title: "  $title",
            size: 16,
            fontWeight: FontWeight.w500,
            colors: black),
        const SizedBox(height: 5),
        TextField(
          controller: contl,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  iconpath,
                  height: 10,
                  width: 10,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[600]),
              hintText: title,
              fillColor: Colors.white70),
        ),
      ],
    );
  }

  updateProfile() async {
    if (nameController.text.isEmpty) {
      Utility.toastMessage("Please enter your name");
      return;
    }
    if (emailController.text.isEmpty) {
      Utility.toastMessage("Please enter your email");
      return;
    }
    if (contactController.text.isEmpty) {
      Utility.toastMessage("Please enter your contact number");
      return;
    }
    // if (_addressController.text.isEmpty) {
    //   Utility.toastMessage("Please enter your address");
    //   return;
    // }
    if (ageController.text.isEmpty) {
      Utility.toastMessage("Please enter your address");
      return;
    }
    if (genderController.dropDownValue!.name.isEmpty) {
      Utility.toastMessage("Please enter your gender");
      return;
    }
    if (countryController.dropDownValue!.name.isEmpty) {
      Utility.toastMessage("Please enter your Country");
      return;
    }
    if (_image == null && profilePic == "") {
      Utility.toastMessage("Please select profile picture");
      return;
    }
    File? image;
    if (_image != null) {
      image = File(_image!.path);
      debugPrint('===>path ${_image!.path}');
    }
    var update = Provider.of<ApiProvider>(context, listen: false);
    if (image != null) {
      await update.getUpdateProfile(
        contact: contactController.text.toString(),
        // address: _addressController.text,
        image: image,
        userId: userId!,
        email: emailController.text,
        gender: genderController.dropDownValue!.name,
        fullname: nameController.text,
        age: ageController.text,
        country: countryController.dropDownValue!.name,
      );
    } else {
      await update.getUpdateProfile(
        contact: contactController.text.toString(),
        // address: _addressController.text,
        userId: userId!,
        email: emailController.text,
        gender: genderController.dropDownValue!.name,
        fullname: nameController.text,
        age: ageController.text,
        country: countryController.dropDownValue!.name,
      );
    }
    if (!update.loading) {
      if (update.successModel.status == 200) {
        Utility.toastMessage(update.successModel.message.toString());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Profile()));
      } else {
        Utility.toastMessage(update.successModel.message.toString());
      }
    }
  }
}
