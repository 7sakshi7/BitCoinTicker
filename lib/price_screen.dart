import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin.dart';
import './generating_url.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';
  String selectedCrypto = 'BTC';
  int selectedIndex = 0;
  double result1 = 0;
  double result2 = 0;
  double result3 = 0;

  // for android
  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    currenciesList.forEach((element) {
      var menuItem = DropdownMenuItem(
        child: Text('$element'),
        value: '$element',
      );
      dropdownItems.add(menuItem);
    });

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(
            () {
              selectedCurrency = value.toString();
              pageNaviagtion();
            },
          );
        });
  }

  void pageNaviagtion() async {
    GenerateUrl genurl1 = GenerateUrl(
        cryptoString: cryptoList[0], currencyString: selectedCurrency);
    GenerateUrl genurl2 = GenerateUrl(
        cryptoString: cryptoList[1], currencyString: selectedCurrency);
    GenerateUrl genurl3 = GenerateUrl(
        cryptoString: cryptoList[2], currencyString: selectedCurrency);

    result1 = await genurl1.getData();
    result2 = await genurl2.getData();
    result3 = await genurl3.getData();
    print(result1);
  }

  @override
  void initState() {
    pageNaviagtion();
  }
  // for ios

  CupertinoPicker getItemsPicker() {
    List<Text> pickerItems = [];

    currenciesList.forEach((element) {
      var items = Text(element);
      pickerItems.add(items);
    });

    return CupertinoPicker(
      itemExtent: 40,
      onSelectedItemChanged: (index) {
        selectedIndex = index;
      },
      children: pickerItems,
    );
  }

  Widget choosePlatform() {
    if (Platform.isIOS) return getItemsPicker();
    return getDropDownButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                CardText(
                    result: result1.toInt(),
                    selectedCurrency: selectedCurrency,
                    index: 0),
                CardText(
                    result: result2.toInt(),
                    selectedCurrency: selectedCurrency,
                    index: 1),
                CardText(
                    result: result3.toInt(),
                    selectedCurrency: selectedCurrency,
                    index: 2),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: choosePlatform(),
          ),
        ],
      ),
    );
  }
}

class CardText extends StatelessWidget {
  const CardText({
    Key? key,
    required this.result,
    required this.selectedCurrency,
    required this.index,
  }) : super(key: key);

  final int result;
  final String selectedCurrency;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: Text('1 ${cryptoList[index]} = $result $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            )),
      ),
    );
  }
}
