import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture_app/core/utils/app_colors.dart';
import 'package:lecture_app/core/utils/app_images.dart';
import 'package:lecture_app/core/utils/app_strings.dart';
import 'package:lecture_app/core/utils/local/local_controller.dart';
import 'package:lecture_app/features/presentation/screens/students%20attendance/Attendance.dart';
import 'package:lecture_app/features/presentation/screens/Projector/DataShow_test.dart';
import 'package:lecture_app/features/presentation/screens/Notify%20Students/Notify.dart';
import 'package:lecture_app/features/presentation/screens/Quiz%20Pages/Quiz.dart';
import 'package:lecture_app/features/presentation/screens/aboutApp/about_app.dart';
import 'package:lecture_app/features/presentation/screens/account_page/information_screen.dart';
import 'package:lecture_app/features/presentation/screens/nav_bottom_screens/nav_home.dart';
import 'package:lecture_app/features/presentation/screens/settings_page/setting_screen.dart';
import 'package:lecture_app/features/presentation/widget/settins_tile.dart';
import 'package:lecture_app/features/presentation/screens/record%20lecture/Start_record.dart';
import 'package:lecture_app/features/presentation/screens/splash_screen/splash_screen.dart';
import 'package:lecture_app/features/presentation/widget/item.dart';
import 'upload content/Upload_files.dart';
import 'package:lecture_app/core/utils/network/local_network.dart';
class HomePage extends StatefulWidget {
  static final ROUTE='HomePage';
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool lang=true;
  MyLocaleController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            children: [
              DrawerHeader(child:  CircleAvatar(radius: 60,

                child:  Image(image: AssetImage("R/icons/PIC-1.png"),),),
              ),
              SettingsTile(
                color: AppColors.primary,
                icon: Icons.person,
                title: "Account".tr,
                onTap: () {
                  Navigator.pushNamed(context,InformationScreen.ROUTE);
                },
              ),
              Divider(
                color: Colors.grey,
                height: 30,
                endIndent: 4,
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    lang?"English":"العربية",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Switch(value: lang, onChanged: (value){
                    setState(() {
                      lang = !lang;
                      if (lang == false) {
                        controller.changeLang("ar");
                      }
                      else {
                        controller.changeLang("en");
                      }
                    });
                  }),
                ],
              ),
              Divider(
                color: Colors.grey,
                height: 30,
              ),
              SettingsTile(
                color: AppColors.primary,
                icon: Icons.add_alert_sharp,
                title: "Notification".tr,
                onTap: ()=>Navigator.pushNamed(context,DataShow.ROUTE),
              ),
              Divider(
                color: Colors.grey,
                height: 30,
                endIndent: 4,
              ),
              SettingsTile(
                color: AppColors.primary,
                icon: Icons.house_outlined,
                title: "Home".tr,
                onTap: ()=>Navigator.pushNamedAndRemoveUntil(context,NavHome.ROUTE,(route)=>false),
              ),
              Divider(
                color: Colors.grey,
                height: 30,
                endIndent: 4,
              ),
              SettingsTile(
                color: AppColors.primary,
                icon: Icons.cloud_upload_outlined,
                title: "Upload".tr,
                onTap: ()=>Navigator.pushNamed(context,UploadFiles.ROUTE),
              ),
              Divider(
                color: Colors.grey,
                height: 30,
                endIndent: 4,
              ),
              SettingsTile(
                color: AppColors.primary,
                icon: Icons.question_mark_sharp,
                title: "About App".tr,
                onTap: ()=>Navigator.pushNamed(context,AboutApp.ROUTE),
              ),
              Divider(
                color: Colors.grey,
                height: 30,
                endIndent: 4,
              ),
              SettingsTile(
                color: AppColors.primary,
                icon:  Icons.settings,
                title: 'Settings'.tr,
                onTap: ()=>Navigator.pushNamed(context,SettingsScreen.ROUTE),
              ),
              Padding(padding: EdgeInsets.only(top: 70)),
              TextButton.icon(
                icon: Icon(Icons.person,color: AppColors.primary,),
                onPressed: (){
                  cashNetwork.removeFromCash(key: "token");
                  Navigator.pushNamedAndRemoveUntil(context,SplshScreen.ROUTE,(route)=>false);
                },
                label: Text(
                  "LogOut".tr,
                  style: TextStyle(
                      fontFamily: AppStrings.constantFont,
                      color: AppColors.primary,
                      fontSize:  20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],

      ),
        ),
      ),
      appBar: AppBar(
        title:  Text('Home'.tr,
        ),
        backgroundColor:AppColors.primary ,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top:55,left: 25,right: 25),
            child: GridView(
              children: [
                cards(context: context,pushNamed: RecordPage.ROUTE,text:'Record',icon_path:ImageAssets.video ),
                cards(context: context,pushNamed: UploadFiles.ROUTE,text:'Upload',icon_path:ImageAssets.upload ),
                cards(context: context,pushNamed: AttendanceList.ROUTE,text:'Attandance',icon_path: ImageAssets.immigration ),
                cards(context: context,pushNamed: DataShow.ROUTE,text:'projector',icon_path: ImageAssets.tablet ),
                cards(context: context,pushNamed: notify.ROUTE,text:'Notify',icon_path: ImageAssets.notification ),
                cards(context: context,pushNamed: QuizPage.ROUTE,text:'Quiz',icon_path:ImageAssets.quiz),
              ],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing:50,crossAxisSpacing: 25)
              ,),
          ),
        ),),
    );
  }
}

