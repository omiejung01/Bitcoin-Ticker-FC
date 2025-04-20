import 'package:bitcoin_ticker_flutter/secret.dart' as my;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';
import 'dart:io';

Future<dynamic> fetch(String base, String quote) async {
  String url = "${my.cypto_api_io_url}$base/$quote";

  final response = await http.get(

    Uri.parse(url),
    // Send authorization headers to the backend.
    headers: my.header,
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
  //print(responseJson);
  return responseJson;
}
