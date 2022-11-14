import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/theme_mode_item.dart';
import 'package:todo_app/service/storage_service.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/widgets/selected_lang.dart';
import '../theme_provider.dart';
import '../utils/images.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  String newName = '';
  String accountName = "Odilbek";

  @override
  void initState() {
    super.initState();
    accountName = StorageService.getString("accountName");
  }

  @override
  Widget build(BuildContext context) {
    var isLight = context.watch<ThemeProvider>().getIsLight();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1.26,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: isLight ? Colors.white : Colors.black,
            child: Form(
              key: formKey,
              child: Column(children: [
                Container(
                  child: CircleAvatar(
                    radius: 45.r,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300"),),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Text(
                  accountName,
                  style: TextStyle(
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.085,
                        width: MediaQuery.of(context).size.width * 0.41,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6).r,
                            color: isLight?Colors.grey:MyColors.C_363636),
                        child:  Center(
                            child: Text('10 Task left',
                                style: TextStyle(fontSize: 20.sp))),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.085,
                        width: MediaQuery.of(context).size.width * 0.41,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6).r,
                            color: isLight?Colors.grey:MyColors.C_363636,),
                        child: const Center(
                            child: Text(
                          '5 Task done',
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30).r,
                    child: const Text('settings',),),
                changeLaunguage(isLight),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 10).r,
                  child: ThemeModeItem(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30).r,
                    child: const Text('Account',)),
                changeName(isLight),
                titleWidget(MyImages.ic_key, 'Change account password', isLight),
                titleWidget(MyImages.ic_camera, 'Change account Image',isLight),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30),
                    child: const Text('Uptodo', style: TextStyle())),
                titleWidget(MyImages.ic_about, 'About US',isLight),
                titleWidget(MyImages.ic_faq, 'FAQ',isLight),
                titleWidget(MyImages.ic_help_feedback, 'Help & Feedback',isLight),
                titleWidget(MyImages.ic_like, 'Support US',isLight),
                logoutWidget(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
  Widget titleWidget(icon, word, isLight) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: SvgPicture.asset(
          icon,
          width: 26.w,
          color: isLight?Colors.black:Colors.white,
        ),
      ),
      title: Text(
        word,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: SvgPicture.asset(
        MyImages.ic_right,
        width: 26.w,
        color: isLight?Colors.black:Colors.white,
      ),
    );
  }

  Widget logoutWidget() {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: SvgPicture.asset(
          MyImages.ic_log_out,
          width: 26.w,
        ),
      ),
      title:  Text(
        'Log out',
        style: TextStyle(color: Colors.red, fontSize: 18.sp),
      ),
    );
  }

  int selectedLaunguage = 0;

  Widget changeLaunguage(isLight) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context, builder: (context) => const SelectLang());
        },
        child: titleWidget(MyImages.ic_settings, 'Change launguage'.tr(),isLight));
  }

  Widget changeName(isLight) {
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Change name"),
                content: TextFormField(
                  initialValue: accountName,
                  onChanged: (val) {
                    accountName = val;
                  },
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        StorageService.saveString(
                            "accountName", accountName);
                        Navigator.pop(context);
                      },
                      child: const Text("Save"))
                ],
              ));
        },
        child: titleWidget(MyImages.ic_profile, 'Change account name'.tr(), isLight));
  }
}
