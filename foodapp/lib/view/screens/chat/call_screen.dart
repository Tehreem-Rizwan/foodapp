import 'package:flutter/material.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:get/get.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_featureList_call.dart';
import 'package:foodapp/view/widget/custom_record_indicator_call.dart';
import 'package:foodapp/controllers/call_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CallScreen extends StatelessWidget {
  final CallController callController = Get.put(CallController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonImageView(
            imagePath: Assets.imagesCallbg,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: kPrimaryColor.withOpacity(0.5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: AppLocalizations.of(context)!.stevanoClirover,
                size: 24,
                weight: FontWeight.w600,
                color: kSecondaryColor,
              ),
              SizedBox(height: h(context, 16)),
              Obx(() => RecordIndicator(
                    formattedTime:
                        callController.formatTime(callController.seconds.value),
                  )),
              SizedBox(height: h(context, 40)),
              FeatureList(),
            ],
          ),
        ],
      ),
    );
  }
}
