import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:foodapp/view/screens/cart/account_type.dart';

class EasypaisaScreen extends StatefulWidget {
  @override
  _EasypaisaScreenState createState() => _EasypaisaScreenState();
}

class _EasypaisaScreenState extends State<EasypaisaScreen> {
  // Form controllers
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  // Easypaisa credentials
  String? username;
  String? password;
  String? storeId;
  bool isSandbox = true;
  AccountType accountType = AccountType.MA;

  @override
  void initState() {
    super.initState();
    initialize('Tehreem Rizwan', 'Qwer@1234', '677170', true, AccountType.MA);
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

  Future<Response> requestPayment({
    required String amount,
    required String accountNo,
    required String email,
  }) async {
    if (username == null || password == null || storeId == null) {
      throw Exception('Username and password must be initialized first.');
    }

    String expiryToken = generateExpiryToken();
    var requestBody = accountType == AccountType.MA
        ? {
            "orderId": "${DateTime.now().millisecondsSinceEpoch}",
            "storeId": "677170",
            "transactionAmount": "10000",
            "transactionType": 'MA',
            "mobileAccountNo": "03207166412",
            "emailAddress": "tehreemrizwan30@gmail.com",
          }
        : {
            "orderId": "${DateTime.now().millisecondsSinceEpoch}",
            "storeId": "677170",
            "transactionAmount": "10000",
            "transactionType": 'OTC',
            "msisdn": "03207166412",
            "emailAddress": "tehreemrizwan30@gmail.com",
            "tokenExpiry": expiryToken,
          };

    // Determine the API endpoint
    String url = isSandbox
        ? 'https://easypaystg.easypaisa.com.pk/easypay-service/rest/v4/${accountType == AccountType.MA ? "initiate-ma-transaction" : "initiate-otc-transaction"}'
        : 'https://easypay.easypaisa.com.pk/easypay-service/rest/v4/${accountType == AccountType.MA ? "initiate-ma-transaction" : "initiate-otc-transaction"}';

    var jsonBody = json.encode(requestBody);

    // Send the request
    var response = await post(
      Uri.parse(url),
      headers: {
        "Authorization":
            "Basic ${base64.encode(utf8.encode('$username:$password'))}",
        "Content-Type": "application/json",
      },
      body: jsonBody,
    );

    // Handle response
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Error response: ${response.body}');
      throw Exception('Transaction failed: ${response.body}');
    }
  }

  // Dummy function for generating an expiry token (implement your logic here)
  String generateExpiryToken() {
    return "dummy-token";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easypaisa Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _accountNoController,
              decoration: InputDecoration(labelText: 'Account No'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: initiatePayment,
                    child: Text('Proceed to Payment'),
                  ),
          ],
        ),
      ),
    );
  }
}
