import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentSummaryWidget extends StatelessWidget {
  final double totalItemsCost;
  final double deliveryFee;
  final double discount;
  final double finalTotal;

  PaymentSummaryWidget({
    required this.totalItemsCost,
    required this.deliveryFee,
    required this.discount,
    required this.finalTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: all(context, 12),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEDEDED), width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppLocalizations.of(context)!.paymentsummary,
            size: 16,
            weight: FontWeight.w600,
            color: kBlackyColor,
          ),
          SizedBox(height: h(context, 8)),
          _buildSummaryItem(context, AppLocalizations.of(context)!.totalItems,
              '\$$totalItemsCost'),
          _buildSummaryItem(context, AppLocalizations.of(context)!.deliveryFee,
              AppLocalizations.of(context)!.free),
          _buildSummaryItem(
              context, AppLocalizations.of(context)!.discount, '-\$$discount',
              highlight: true),
          _buildSummaryItem(
              context, AppLocalizations.of(context)!.total, '\$$finalTotal',
              isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value,
      {bool highlight = false, bool isTotal = false}) {
    return Padding(
      padding: symmetric(context, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            size: 14,
            weight: highlight || isTotal ? FontWeight.w700 : FontWeight.w400,
            color: highlight || isTotal ? kTertiaryColor : kBlackyColor,
          ),
          CustomText(
            text: value,
            size: 14,
            weight: FontWeight.w700,
            color: highlight || isTotal ? kTertiaryColor : kBlackyColor,
          ),
        ],
      ),
    );
  }
}
