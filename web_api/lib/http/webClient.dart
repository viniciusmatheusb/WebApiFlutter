import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../models/contact.dart';
import '../models/transactions.dart';

String end = 'http://10.63.10.115:8080';

Future<List<Transactions>> findAll() async {
  final Client client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);
  final response = await client.get(Uri.parse('${end}/transactions'));
  final List<dynamic> decodeJson = jsonDecode(response.body);
  final List<Transactions> transactions = [];
  for (Map<String, dynamic> transactionJson in decodeJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transactions transaction = Transactions(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.toString());
    return data;
  }
}
