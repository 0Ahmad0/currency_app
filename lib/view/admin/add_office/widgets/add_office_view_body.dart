import 'package:currency_app/controller/provider/auth_provider.dart';
import 'package:currency_app/view/navbar/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
            width: 25.w,
            height: 25.h,
          )),
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
              longitudeController.text=p!.longitude.toString();

              // List<Placemark> placemarks =
              //     await placemarkFromCoordinates(p!.latitude, p.longitude);
              // print(placemarks.first.street);
              // locationController.text = '${placemarks.first.country}'
              //     ' ${placemarks.first.name}';
            },
            iconData: Icons.location_on,
            hintText: tr(LocaleKeys.location),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
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
                    Get.off(() => HomeView(),
                        transition: Transition.circularReveal);
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
}
