import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart'; // for HMAC-SHA256

class JazzCash extends StatefulWidget {
  const JazzCash({super.key});

  @override
  State<JazzCash> createState() => _JazzCashState();
}

class _JazzCashState extends State<JazzCash> {
  Future<void> payment() async {
    try {
      String transactionRef =
          "T" + DateTime.now().millisecondsSinceEpoch.toString();
      String amount = "10000";
      String billReference = "billref";
      String description = "Description of transaction";
      String language = "EN";
      String merchantID = "MC135576";
      String password = "vs400ce283";
      String returnUrl =
          "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
      String txnDateTime =
          DateTime.now().toUtc().toString().replaceAll(' ', 'T');
      String expireDate = DateTime.now()
          .add(Duration(days: 1))
          .toUtc()
          .toString()
          .replaceAll(' ', 'T');
      String txnCurrency = "PKR";
      String txnType = "MWALLET";
      String integritySalt = "tg3358a7wu";
      String mpf1 = "4456733833993";
      String pp_ver = "1.1"; // API version

      // Concatenating the data for HMAC-SHA256 hashing
      String superdata = integritySalt +
          "&" +
          amount +
          "&" +
          billReference +
          "&" +
          description +
          "&" +
          language +
          "&" +
          merchantID +
          "&" +
          password +
          "&" +
          returnUrl +
          "&" +
          txnCurrency +
          "&" +
          txnDateTime +
          "&" +
          expireDate +
          "&" +
          transactionRef +
          "&" +
          txnType +
          "&" +
          pp_ver +
          "&" +
          mpf1;

      var key = utf8.encode(integritySalt);
      var bytes = utf8.encode(superdata);
      var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
      Digest secureHash = hmacSha256.convert(bytes);

      // API request body
      var body = {
        "pp_Version": pp_ver,
        "pp_TxnType": txnType,
        "pp_Language": language,
        "pp_MerchantID": merchantID,
        "pp_Password": password,
        "pp_TxnRefNo": transactionRef,
        "pp_Amount": amount,
        "pp_TxnCurrency": txnCurrency,
        "pp_TxnDateTime": txnDateTime,
        "pp_BillReference": billReference,
        "pp_Description": description,
        "pp_TxnExpiryDateTime": expireDate,
        "pp_ReturnURL": returnUrl,
        "pp_SecureHash": secureHash.toString(),
        "ppmpf_1": mpf1,
      };

      // Making the HTTP POST request
      var url = Uri.parse(
          'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print("Payment successful: ${response.body}");
      } else {
        print("Payment failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
              size: 16,
            ),
          ),
        ),
        title: CustomText(
          text: "JazzCash Payment",
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: CustomButton(
          height: 52,
          width: 327,
          buttonText: "Proceed with JazzCash",
          textSize: 14,
          backgroundColor: kTertiaryColor,
          onTap: () {
            payment;
          },
        ),
      ),
    );
  }
}
