// ignore_for_file: avoid_print

import 'package:http/http.dart';

import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: const Duration(seconds: 10));
const String baseUrl = 'http://192.168.0.78:8080/transactions';
