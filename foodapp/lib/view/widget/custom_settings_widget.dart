import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/profile/language_selection_page.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuSectionSettings extends StatefulWidget {
  @override
  _MenuSectionSettingsState createState() => _MenuSectionSettingsState();
}

class _MenuSectionSettingsState extends State<MenuSectionSettings> {
  bool _isPushNotificationEnabled = false;
  bool _isLocationEnabled = true;
  late String selectedLanguage = AppLocalizations.of(context)!.englishus;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: only(context, right: 280),
          child: CustomText(
            text: AppLocalizations.of(context)!.profile,
            size: 14,
            color: kgreyblackColor,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: h(context, 10)),
        ListTile(
          title: CustomText(
            text: AppLocalizations.of(context)!.pushNotifications,
            size: 14,
            weight: FontWeight.bold,
            color: kBlackyColor,
          ),
          trailing: Switch(
            value: _isPushNotificationEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _isPushNotificationEnabled = newValue;
              });
            },
            activeColor: kSecondaryColor,
            inactiveThumbColor: kSecondaryColor,
            activeTrackColor: kTertiaryColor,
            inactiveTrackColor: Color(0xffDFE0F3),
          ),
        ),
        ListTile(
          title: CustomText(
            text: AppLocalizations.of(context)!.location,
            size: 14,
            weight: FontWeight.bold,
            color: kBlackyColor,
          ),
          trailing: Switch(
            value: _isLocationEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _isLocationEnabled = newValue;
              });
            },
            activeColor: kSecondaryColor,
            inactiveThumbColor: kSecondaryColor,
            activeTrackColor: kTertiaryColor,
            inactiveTrackColor: Color(0xffDFE0F3),
          ),
        ),
        ListTile(
          leading: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: double.infinity,
                    height: h(context, 504),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                      color: kSecondaryColor,
                    ),
                    child: LanguageSelectionPage(
                      onLanguageSelected: (String language) {
                        setState(() {
                          selectedLanguage = language;
                        });
                      },
                    ),
                  );
                },
              );
            },
            child: CustomText(
              text: AppLocalizations.of(context)!.language,
              size: 14,
              weight: FontWeight.bold,
              color: kBlackyColor,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: selectedLanguage,
                size: 14,
                color: kBlackyColor,
                weight: FontWeight.w600,
              ),
              SizedBox(
                width: w(context, 20),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: kBlackyColor),
            ],
          ),
        ),
        SizedBox(height: h(context, 10)),
        Padding(
          padding: only(context, right: 285),
          child: CustomText(
            text: AppLocalizations.of(context)!.other,
            size: 14,
            color: kgreyblackColor,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: h(context, 10)),
        MenuItem1(
          label: AppLocalizations.of(context)!.aboutticketis,
          onTap: () {},
        ),
        MenuItem1(
          label: AppLocalizations.of(context)!.privacypolicy,
          onTap: () {},
        ),
        MenuItem1(
          label: AppLocalizations.of(context)!.termsandconditions,
          onTap: () {},
        ),
      ],
    );
  }
}

class MenuItem1 extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const MenuItem1({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomText(
        text: label,
        size: 14,
        weight: FontWeight.bold,
        color: kBlackyColor,
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: kBlackyColor),
      onTap: onTap,
    );
  }
}
