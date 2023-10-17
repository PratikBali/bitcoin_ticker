import 'dart:convert';
import 'package:http/http.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURL = 'rest.coinapi.io';
const apiKey = '12E99CD6-00EF-49DA-B9D2-34F0039AB25A';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    print('selectedCurrency: $selectedCurrency');
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
    print('crypto: $crypto');
      Response response = await get(
        Uri.https(coinAPIURL, '/v1/exchangerate/$crypto/$selectedCurrency',
          {'apikey': apiKey},
        ),
      );
      print('response: $response');

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        // print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
