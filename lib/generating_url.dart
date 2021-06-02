import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/material.dart';
import './networking.dart';

const apiKey = '6D2A2DFD-687A-4E9C-9BB7-8863D34315D4';

class GenerateUrl {
  String cryptoString = '';
  String currencyString = '';

  GenerateUrl({required this.cryptoString, required this.currencyString});

  Future getData() async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/$cryptoString/$currencyString?apikey=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url);

    var coinData = await networkHelper.getData();
    return coinData['rate'];
  }
}
