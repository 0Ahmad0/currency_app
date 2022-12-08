import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/translations/locale_keys.g.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/color_manager.dart';
import '/view/resourse/style_manager.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/button_app.dart';
import '../../resourse/values_manager.dart';

class ProfileViewBody extends StatefulWidget {
  final bool isIgnor;

  const ProfileViewBody({super.key, required this.isIgnor});
  @override
  State<ProfileViewBody> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileViewBody> {
  // final name = TextEditingController(text: "أحمد الحريري");

  bool nameIgnor = true;

  bool emailIgnor = true;

  // ProfileProvider profileProvider = ProfileProvider();
  ImagePicker picker = ImagePicker();

  XFile? image;

  pickFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  pickFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    // await uploadImage( );
    setState(() {});
  }

//   Future uploadImage() async {
//     try {
//       String path = basename(image!.path);
//       print(image!.path);
//       File file =File(image!.path);
//
// //FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
//       Reference storage = FirebaseStorage.instance.ref().child("profileImage/${path}");
//       UploadTask storageUploadTask = storage.putFile(file);
//       TaskSnapshot taskSnapshot = await storageUploadTask;
//       //Const.LOADIG(context);
//       String url = await taskSnapshot.ref.getDownloadURL();
//       //Navigator.of(context).pop();
//       print('url $url');
//       return url;
//     } catch (ex) {
//       //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
//     }
//   }

  @override
  Widget build(BuildContext context) {
    // final profileProvider = Provider.of<ProfileProvider>(context);
    // final loginProvider = Provider.of<LoginProvider>(context);
    // profileProvider.serial_number.text=profileProvider.user.serialNumber;
    return IgnorePointer(
      ignoring: widget.isIgnor,
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: AppPadding.p10, horizontal: AppPadding.p20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 35.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: AppSize.s4)),
                        child: image == null
                            ? CachedNetworkImage(
                            imageUrl:
                                // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                                "https://images.techhive.com/images/article/2017/05/pcw-translate-primary-100723319-large.jpg",
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  width: 5.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                              )
                            :   ClipOval(
                              child: Image.file(File(image!.path),
                                width: 5.w,
                                height: 5.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: () {
                              _showDialog(context);
                            },
                            icon: Icon(Icons.edit,size: 15.sp,),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.s10,),
                  TextFiledApp(
                      iconData: Icons.person,
                      hintText: tr(LocaleKeys.full_name)
                  ),
                  const SizedBox(height: AppSize.s10,),
                  TextFiledApp(
                      iconData: Icons.email,
                      hintText: tr(LocaleKeys.email_address)
                  ),
                  const SizedBox(height: AppSize.s10,),
                  TextFiledApp(
                      iconData: Icons.phone_iphone,
                      hintText: tr(LocaleKeys.mobile_number)
                  ),
                  const SizedBox(height: AppSize.s10,),
                  TextFiledApp(
                      iconData: Icons.lock,
                      hintText: tr(LocaleKeys.password)
                  ),
                 Visibility(
                   // TODO if user is office
                   visible: true == true,
                   child: Column(
                     children: [
                       const SizedBox(height: AppSize.s10,),
                       TextFiledApp(
                           iconData: Icons.money_off,
                           hintText: tr(LocaleKeys.amount)
                       ),
                     ],
                   ),
                 ),
                  const SizedBox(height: AppSize.s20,),
                  ButtonApp(text: tr(LocaleKeys.edit_password), onPressed: (){
                    Get.dialog(
                        Center(
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.all(AppPadding.p20),
                              margin: EdgeInsets.all(AppMargin.m20),
                              height: 34.h,
                              decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(AppSize.s24)
                              ),
                              child: Column(
                                children: [
                                  TextFiledApp(
                                      iconData: Icons.lock,
                                      hintText: tr(LocaleKeys.new_password)
                                  ),
                                  const SizedBox(height: AppSize.s10,),
                                  TextFiledApp(
                                      iconData: Icons.lock,
                                      hintText: tr(LocaleKeys.confirm_new_password)
                                  ),
                                  Spacer(),
                                  ButtonApp(text: tr(LocaleKeys.done),
                                      onPressed: (){
                                        Get.back();
                                      })
                                ],
                              ),
                            ),
                          ),
                        )
                    );

                  }),
                  const SizedBox(height: AppSize.s10,),
                  ButtonApp(text: tr(LocaleKeys.edit), onPressed: (){}),
                ],
              ),
            ),
          )),
    );
  }
  void _showDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: Container(
              height: 20.h,
              width: SizerUtil.width - 30.0,
              color: Theme.of(context).cardColor,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pickFromCamera();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              AppPadding.p8),
                          child: Row(
                            children: [
                              Icon(Icons.camera),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text("Camera"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()  {

                          pickFromGallery();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              AppPadding.p8),
                          child: Row(
                            children: [
                              Icon(Icons.photo),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text("Gallery"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()  {

                          // removeGallery();
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              AppPadding.p8),
                          child: Row(
                            children: [
                              Icon(Icons.delete),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Text("Remove"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
/*
Center(
                                          child: Container(
                                            height: Sizer.getW(context) * 0.4,
                                            width:
                                                Sizer.getW(context) - AppSize.s30,
                                            color: Theme.of(context).cardColor,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        pickFromCamera();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.all(
                                                            AppPadding.p8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.camera),
                                                            const SizedBox(
                                                              width: AppSize.s8,
                                                            ),
                                                            Text("Camera"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 0.0,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: ()  {

                                                        pickFromGallery();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.all(
                                                            AppPadding.p8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.photo),
                                                            const SizedBox(
                                                              width: AppSize.s8,
                                                            ),
                                                            Text("Gallery"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 0.0,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: ()  {

                                                        removeGallery();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.all(
                                                            AppPadding.p8),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.delete),
                                                            const SizedBox(
                                                              width: AppSize.s8,
                                                            ),
                                                            Text("Remove"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
 */