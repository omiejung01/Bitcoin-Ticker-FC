import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_flutter/coin_data.dart' as data;
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker_flutter/brain.dart' as brain;
import 'package:intl/intl.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<String> currencies = data.currenciesList;
  String selectedCurrency = 'USD';
  String currentRateBTC = '0.0';
  String currentRateETH = '0.0';
  String currentRateLTC = '0.0';


  void initState ()  {
    super.initState();
    updateUI(selectedCurrency);
  }

  void updateUI(String quote) async {
    dynamic infoBTC = await brain.fetch('BTC'.toLowerCase(), quote.toLowerCase());
    dynamic infoETH = await brain.fetch('ETH'.toLowerCase(), quote.toLowerCase());
    dynamic infoLTC = await brain.fetch('LTC'.toLowerCase(), quote.toLowerCase());

    //print(data);
    setState(() {
      if (infoBTC == null) {
      // pop up error
      } else {
        String fetchData = infoBTC['data']['item']['rate'];
        double dblRate = double.parse(fetchData);
        currentRateBTC = doubleToFourDigitStringWithComma(dblRate);
      }

      if (infoETH == null) {
        // pop up error
      } else {
        String fetchData = infoETH['data']['item']['rate'];
        double dblRate = double.parse(fetchData);
        currentRateETH = doubleToFourDigitStringWithComma(dblRate);
      }

      if (infoLTC == null) {
        // pop up error
      } else {
        String fetchData = infoLTC['data']['item']['rate'];
        double dblRate = double.parse(fetchData);
        currentRateLTC = doubleToFourDigitStringWithComma(dblRate);
      }

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🤑 Coin Ticker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 BTC = $currentRateBTC $selectedCurrency',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 ETH = $currentRateETH $selectedCurrency',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 LTC = $currentRateLTC $selectedCurrency',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }

  Widget getPicker() {
    //return Platform.isIOS ? iosPicker() : androidDropdown();
    return iosPicker();
  }

  Widget androidDropdown() {
    List<DropdownMenuItem<String>> list = [];

    int len = currencies.length;

    for (int i = 0; i < len; i++) {
      list.add(
        DropdownMenuItem(
          child: Center(child: Text(currencies[i])),
          value: currencies[i],
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: list,
      onChanged: (value) async {
          selectedCurrency = value.toString();
          //print(value);
          //currentRate = await brain.getPrice('BTC', selectedCurrency);
          updateUI(selectedCurrency);

      },
    );
  }

  // CupertinoPicker
  Widget iosPicker() {
    List<Widget> list = [];

    for (String item in currencies) {
      list.add(Text(item));
    }

    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: currencies.indexOf('USD')),
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currencies[selectedIndex];
        updateUI(selectedCurrency);
        //print(selectedCurrency);
      },
      children: list,
    );
  }
}

String doubleToFourDigitStringWithComma(double value) {
  final formatter = NumberFormat('#,##0.0000', 'en_US');
  return formatter.format(value);
}
