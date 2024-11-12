import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_Textfield_widget.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:foodapp/view/screens/cart/account_type.dart';
import '../../widget/Custom_text_widget.dart';

class EasypaisaScreen extends StatefulWidget {
  final List<dynamic> cartItems;
  final String amount;

  EasypaisaScreen({required this.cartItems, required this.amount});
  @override
  _EasypaisaScreenState createState() => _EasypaisaScreenState();
}

class _EasypaisaScreenState extends State<EasypaisaScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  String? username;
  String? password;
  String? storeId;
  bool isSandbox = true;
  AccountType accountType = AccountType.MA;

  @override
  void initState() {
    super.initState();
    print(widget.cartItems);
    initialize('Tehreem Rizwan', 'Qwer@1234', '677170', true, AccountType.MA);
    _amountController.text = widget.amount;
  }

  void initialize(String username, String password, String storeId,
      bool? isSandbox, AccountType? accountType) {
    this.username = username;
    this.password = password;
    this.storeId = storeId;
    this.isSandbox = isSandbox ?? true;
    this.accountType = accountType ?? AccountType.MA;
  }

  Future<void> initiatePayment() async {
    if (!validateForm()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await requestPayment(
        amount: _amountController.text,
        accountNo: _accountNoController.text,
        email: _emailController.text,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transaction successful: ${response.body}')),
        );
      } else {
        // Print more details for debugging
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transaction failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initiating payment: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool validateForm() {
    if (_amountController.text.isEmpty ||
        double.tryParse(_amountController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid amount')),
      );
      return false;
    }
    if (_accountNoController.text.isEmpty ||
        _accountNoController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid account number')),
      );
      return false;
    }
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email')),
      );
      return false;
    }
    return true;
  }

  Future<http.Response> requestPayment({
    required String amount,
    required String accountNo,
    required String email,
  }) async {
    if (username == null || password == null || storeId == null) {
      throw Exception(
          'Username, password, and storeId must be initialized first.');
    }

    String expiryToken = generateExpiryToken();
    var requestBody = accountType == AccountType.MA
        ? {
            "orderId": "${DateTime.now().millisecondsSinceEpoch}",
            "storeId": "677170",
            "transactionAmount": "10000", // dynamic amount
            "transactionType": 'MA',
            "mobileAccountNo": "03207166412",
            "emailAddress": "tehreemrizwan30@gmail.com", // dynamic email
          }
        : {
            "orderId": "${DateTime.now().millisecondsSinceEpoch}",
            "storeId": storeId,
            "transactionAmount": amount, // dynamic amount
            "transactionType": 'OTC',
            "msisdn": accountNo, // dynamic mobile account number
            "emailAddress": email, // dynamic email
            "tokenExpiry": expiryToken,
          };

    String url =
        '${getBaseUrl()}${accountType == AccountType.MA ? "initiate-ma-transaction" : "initiate-otc-transaction"}';

    var jsonBody = json.encode(requestBody);

    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Authorization":
            "Basic ${base64.encode(utf8.encode('$username:$password'))}",
        "Content-Type": "application/json",
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      print('Error response: ${response.body}');
      throw Exception('Transaction failed: ${response.body}');
    }
  }

  String getBaseUrl() {
    return isSandbox
        ? 'https://easypaystg.easypaisa.com.pk/easypay-service/rest/v4/'
        : 'https://easypay.easypaisa.com.pk/easypay-service/rest/v4/';
  }

  // Dummy function for generating an expiry token (implement your logic here)
  String generateExpiryToken() {
    return "dummy-token";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
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
          text: "Easypaisa Payment",
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: symmetric(context, vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: only(context, right: 280),
              child: CustomText(
                text: "Amount",
                size: 14,
                weight: FontWeight.w700,
                color: kBlackyColor,
              ),
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: _amountController,
              hintText: "Amount",
            ),
            SizedBox(height: h(context, 12)),
            Padding(
              padding: only(context, right: 260),
              child: CustomText(
                text: "Account No.",
                size: 14,
                weight: FontWeight.w700,
                color: kBlackyColor,
              ),
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: _accountNoController,
              hintText: "Enter Account No.",
            ),
            SizedBox(height: h(context, 12)),
            Padding(
              padding: only(context, right: 290),
              child: CustomText(
                text: "Email",
                size: 14,
                weight: FontWeight.w700,
                color: kBlackyColor,
              ),
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: _emailController,
              hintText: "Enter Email",
            ),
            SizedBox(height: h(context, 50)),
            isLoading
                ? CircularProgressIndicator()
                : CustomButton(
                    height: 52,
                    width: 327,
                    buttonText: "Proceed with Easypaisa Payment",
                    textSize: 14,
                    backgroundColor: kTertiaryColor,
                    onTap: () async {
                      {
                        if (validateForm()) {
                          initiatePayment();
                        }
                      }
                      ;
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
