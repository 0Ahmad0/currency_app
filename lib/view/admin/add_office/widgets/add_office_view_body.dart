import 'dart:io';

import 'package:currency_app/controller/provider/auth_provider.dart';
import 'package:currency_app/view/navbar/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/consts_manager.dart';
import '../../../../model/models.dart';
import '../../../../model/utils/const.dart';
import '../../../home/home_view.dart';
import '/translations/locale_keys.g.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../manager/widgets/textformfiled_app.dart';

class AddOfficeViewBody extends StatefulWidget {
  AddOfficeViewBody({required this.authProvider});
  AuthProvider authProvider;
  @override
  State<AddOfficeViewBody> createState() => _AddOfficeViewBodyState();
}

class _AddOfficeViewBodyState extends State<AddOfficeViewBody> {
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
  removeGallery() async {
    image =null ;
    // widget.profileProvider.user.photoUrl=" ";
    ///print(" ${image==null}");
    setState(() {});
  }
  final formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();

  final fullNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final amountController = TextEditingController();
  final latitudeController = TextEditingController(text: '0');
  final longitudeController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p12),
        children: [
          SafeArea(
              child: SvgPicture.asset(
            AssetsManager.addCurrencyIMG,
            width: 20.w,
            height: 20.h,
          )),
          const SizedBox(
            height: AppSize.s20,
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 20.h,
                decoration: BoxDecoration(
    color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(5.sp)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.sp),
                  //todo mriwed
                  child: image != null
                      ?Image.file(File(image!.path),
                  fit: BoxFit.fill,
                  )
                      :Image.asset(AssetsManager.logoIMG),
                ),
              ),
              Positioned(
                top: 5.sp,
                left: !Advance.language?null: 5.sp,
                right: Advance.language?null: 5.sp,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(onPressed: (){
                    _showDialog(context);
                  }, icon: Icon(Icons.add_a_photo,
                    color: Theme.of(context).cardColor,
                  )),
                ),
              ),

            ],
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          TextFiledApp(
            controller: fullNameController,
            iconData: Icons.person,
            hintText: tr(LocaleKeys.office_name),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            controller: emailAddressController,
            iconData: Icons.email,
            hintText: tr(LocaleKeys.email_address),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            controller: phoneNumberController,
            iconData: Icons.phone,
            hintText: tr(LocaleKeys.mobile_number),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            controller: passwordController,
            iconData: Icons.password,
            hintText: tr(LocaleKeys.password),
            obscureText: true,
            suffixIcon: true,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            controller: locationController,
            readOnly: true,
            onTap: () async {
              GeoPoint? p = await showSimplePickerLocation(
                context: context,
                isDismissible: true,
                title: tr(LocaleKeys.location),
                textConfirmPicker: tr(LocaleKeys.pick),
                initCurrentUserPosition: true,
              );
              latitudeController.text=p!.latitude.toString();
              longitudeController.text=p.longitude.toString();

              List<Placemark> placemarks =
                  await placemarkFromCoordinates(p.latitude, p.longitude);
              print(placemarks.first.street);
              locationController.text = '${placemarks.first.country}'
                  ' ${placemarks.first.name}';
            },
            iconData: Icons.location_on,
            hintText: tr(LocaleKeys.location),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            controller: amountController,
            iconData: Icons.attach_money,
            hintText: tr(LocaleKeys.amount),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          ButtonApp(
              text: tr(LocaleKeys.done),
              onPressed: () async {

                if(formKey.currentState!.validate()){
                  Const.LOADIG(context);
                  widget.authProvider.user=User(id: '', uid: '',
                      name: fullNameController.text,
                      email: emailAddressController.text,
                      phoneNumber: phoneNumberController.text
                      , password: passwordController.text,
                      typeUser: AppConstants.collectionOffice,
                      photoUrl: AppConstants.photoProfileOffice,
                      amount: amountController.text,
                      latitude: latitudeController.text,
                      location: locationController.text,
                      active: true,
                      gender: '', dateBirth: DateTime.now());
                  final result=await widget.authProvider.signupAD(context);
                  Get.back();
                  if(result['status']){
                   Get.off(NavbarView(),transition: Transition.rightToLeftWithFade);
                  }

                }else{
                  Get.snackbar("Error", "Please fill all");
                }
                FocusManager.instance.primaryFocus!.unfocus();
              })
        ],
      ),
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
        });
  }

}
