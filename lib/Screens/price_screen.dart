import 'package:bitcoi_ticker/services/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoi_ticker/components/my_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'XOF';
  double? rateBtc, rateEth, rateLtc;
  Map<String, String> coinsData = {};
  bool isLoading = false;
  bool isAndroid = true;

  //  Fonction pour créer le dropdown pour Android.
  // Function to create the dropdown for Android.
  DropdownButton myDropdownButton() {
    List<DropdownMenuItem<String>> dropdowns = [];
    for (String currency in currencies) {
      DropdownMenuItem<String> dropdown = DropdownMenuItem(
        value: currency,
        child: Text(currency, textAlign: TextAlign.center),
      );
      dropdowns.add(dropdown);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropdowns,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getCoinsData();
        });
      },
    );
  }

  CoinData coinData = CoinData();

  //  Fonction pour créer le picker pour iOS.
  // Function to create the picker for iOS.
  CupertinoPicker myPicker() {
    List<Text> texts = [];
    for (String currency in currencies) {
      Text text = Text(currency);
      texts.add(text);
    }
    return CupertinoPicker(
      itemExtent: currencies.length.toDouble(),
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currencies[selectedIndex];
          getCoinsData();
        });
      },
      children: texts,
    );
  }

  //  Fonction pour récupérer les données des cryptomonnaies.
  // Function to retrieve cryptocurrency data.
  Future<void> getCoinsData() async {
    isLoading = true;

    try {
      var coinsD = await coinData.getCoinsData(selectedCurrency);
      setState(() {
        coinsData = coinsD;
        isLoading = false;
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  //  Fonction pour créer la colonne de cartes.
  // Function to create the column of cards.
  Column myColumn() {
    List<Widget> columns = [];
    for (String coin in cryptoList) {
      columns.add(MyCard(
        rate: coinsData[coin].toString(),
        selectedCurrency: coinData.getCurrenciesName(selectedCurrency),
        coin: coin,
        name: coinData.getName(coin),
        image: coinData.getImage(coin),
        isLoading: isLoading,
      ));
    }
    return Column(children: columns);
  }

  @override
  void initState() {
    getCoinsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        actions: [
          //  Bouton pour changer entre Android et iOS.
          // Button to switch between Android and iOS.
          isAndroid == true
              ? IconButton(
                  icon: const Icon(
                    Icons.android,
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isAndroid = !isAndroid;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(
                    Icons.apple,
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isAndroid = !isAndroid;
                    });
                  },
                ),
          const SizedBox(
            width: 20,
          )
        ],
        title: const Text(
          "Symbole de Crypto",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //  Affiche la colonne de cartes.
          // Display the column of cards.
          myColumn(),
          Container(
            alignment: Alignment.center,
            color: Colors.lightBlue,
            height: 150,
            // Affiche le picker pour iOS ou le dropdown pour Android.
            // Display the picker for iOS or the dropdown for Android.
            child: (Platform.isIOS || isAndroid == false)
                ? myPicker()
                : myDropdownButton(),
          ),
        ],
      ),
    );
  }
}
