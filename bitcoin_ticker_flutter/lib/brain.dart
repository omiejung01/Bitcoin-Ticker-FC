import 'package:bitcoin_ticker_flutter/secret.dart' as my;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';
import 'dart:io';
/*
Future<double> getPrice(String base, String quote) async {
  double result = 0.0;

  String url = "https://rest.coinapi.io/v1/exchangerate/$base/$quote?apikey=${my.coin_io}";
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    String body = response.body;
    var encodedData = jsonDecode(body);
    result = encodedData['rate'];
  }
  return result;
}*/
/*
Future<dynamic> getPrice(String base, String quote) async {

  String url = "${my.coin_url}$base/$quote?apikey=${my.coin_io}";
  print(url);
  http.Response response = await http.get(Uri.parse(url));
  print(response);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return null;
  }
}*/

Future<dynamic> fetch(String base, String quote) async {
  String url = "${my.cypto_api_io_url}$base/$quote";
  //print (url);
  //String key = "${my.cypto_api_io_key}";
  //const Map<String, String> header = {
  //  'X-API-Key': "$key",
  //};

  final response = await http.get(

    Uri.parse(url),
    // Send authorization headers to the backend.
    headers: my.header,
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
  //print(responseJson);
  return responseJson;
}
