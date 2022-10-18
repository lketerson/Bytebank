import 'dart:convert';
import 'package:bytebankv3/http/webclient.dart';
import 'package:http/http.dart';
import '../../models/transaction.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(Uri.parse(baseUrl));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(Uri.parse(baseUrl),
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw HttpException(_statusCodeResponses[response.statusCode]!);
    }
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Error while submiting transaction',
    401: 'Error while submiting password',
    409: 'Transaction alredy exist'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
