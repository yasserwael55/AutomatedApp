import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lecture_app/core/utils/app_colors.dart';
import 'package:lecture_app/core/utils/app_strings.dart';
import 'package:lecture_app/features/presentation/screens/account_page/change_password.dart';
import 'package:lecture_app/core/utils/network/local_network.dart';

class AccountScreen extends StatefulWidget {
  static final ROUTE='AccountScreen';


  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var jopController = TextEditingController();
  var email,jop,name;
   File? uploadimage;
   final imagepicker = ImagePicker();
   static String? path;
  uploadImage() async {
    var pickedImage = await imagepicker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      setState(() {
        uploadimage = File(pickedImage.path);
        path=pickedImage.path;
      });
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  AppColors.primary,
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
              color:Colors.white
            ),
            onPressed: () {
              CircularProgressIndicator();
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    uploadimage = File(path!);
                    cashNetwork.insertToCash( key: "image_profile",value: path!);
                    cashNetwork.insertToCash( key: "name",value: name!);
                    cashNetwork.insertToCash( key: "jop",value: jop!);
                    cashNetwork.insertToCash( key: "email",value: email!);
                  });
                  Navigator.pop(
                    context,
                  );
                  }
              },
            ),
          ],
        ),
        body: Form(
          key: formKey,
          child: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Change Photo'.tr,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppStrings.primaryFont,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 70,
                              backgroundImage:uploadimage != null ?FileImage(uploadimage!,):FileImage( File(cashNetwork.getCashData(key: "image_profile")))
                      ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                                  elevation: 5.0,
                                  height: 40,
                                  onPressed:uploadImage,
                                  child: Text(
                                    "Upload".tr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: AppStrings.primaryFont,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: AppColors.primary,
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                                  elevation: 5.0,
                                  height: 40,
                                  onPressed: (){
                                    setState(() {
                                      uploadimage = File(path!);
                                      cashNetwork.insertToCash( key: "image_profile",value: path!);
                                    });
                                  },

                                  child: Text(
                                    "Save".tr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: AppStrings.primaryFont,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ],
                        ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Name'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppStrings.primaryFont,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        onChanged: (data){
                          name=data;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty'.tr;
                          }
                          if (value!.length>=7) {
                          }else{
                            return 'Please Enter The Correct Name'.tr;
                          }
                          return null;
                        },
                        controller:nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),),
                          suffix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text( 'Edit'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppStrings.primaryFont,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),

                          hintText: 'Dr.${cashNetwork.getCashData(key: "name")}',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppStrings.constantFont,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Email'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppStrings.primaryFont,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        onChanged: (data){
                          email=data;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email address must not be empty'.tr;
                          }
                          if (value!.isEmail) {

                          }else{
                            return 'Please Enter The Correct Email'.tr;
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),),
                          suffix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text( 'Edit'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppStrings.primaryFont,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          hintText: '${cashNetwork.getCashData(key: "email")}',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppStrings.constantFont,
                          ),

                        ),
                      ),
                    ),
                    Text(
                      'Proffessor'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppStrings.primaryFont,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        onChanged: (data){
                          jop=data;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'The position must not be empty'.tr;
                          }
                          if (value!.length>=2) {

                          }else{
                            return 'Please Enter The Correct Position'.tr;
                          }
                          return null;
                        },
                        controller: jopController,
                        decoration: InputDecoration(
                          suffix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text( 'Edit'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppStrings.primaryFont,
                              color: Colors.black,
                            ),
                            ),
                          ),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          hintText: '${cashNetwork.getCashData(key: "jop")}',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppStrings.constantFont,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      onPressed: () {
                        CircularProgressIndicator();
                        Navigator.pushNamed(context,ChangePassword.ROUTE);
                      },
                      child: Text(
                        "Change Password".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: AppStrings.primaryFont,
                            fontWeight: FontWeight.bold),
                      ),
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
