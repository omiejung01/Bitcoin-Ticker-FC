This is my version of Bitcoin-Ticker flutter course in April 2025
I need to use "Crypto API" instead of "Coin API".
You need to add "secret.dart" file in "lib" folder.

<<File content start>>
const cypto_api_io_key = '<your crypto API key>';
String cypto_api_io_url = 'https://rest.cryptoapis.io/market-data/exchange-rates/by-symbol/';

const Map<String, String> header = {
  'X-API-Key': cypto_api_io_key,
};

<<End>>
The original course GitHub is at
https://github.com/londonappbrewery/bitcoin-ticker-flutter
