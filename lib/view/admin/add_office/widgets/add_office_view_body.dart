import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';

import '/translations/locale_keys.g.dart';
import '/view/manager/widgets/button_app.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../manager/widgets/textformfiled_app.dart';

class AddOfficeViewBody extends StatefulWidget {
  @override
  State<AddOfficeViewBody> createState() => _AddOfficeViewBodyState();
}

class _AddOfficeViewBodyState extends State<AddOfficeViewBody> {
  final formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();

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
            iconData: Icons.person,
            hintText: tr(LocaleKeys.office_name),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
            iconData: Icons.email,
            hintText: tr(LocaleKeys.email_address),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFiledApp(
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
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(p!.latitude, p.longitude);
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
            iconData: Icons.attach_money,
            hintText: tr(LocaleKeys.amount),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          ButtonApp(
              text: tr(LocaleKeys.done),
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              })
        ],
      ),
    );
  }
}
