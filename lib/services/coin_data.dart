import 'package:bitcoi_ticker/const.dart';
import 'package:bitcoi_ticker/services/network_helper.dart';

const List<String> currencies = [
  'XOF',
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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String apiAddress = "https://rest.coinapi.io/v1/exchangerate";

  //  Fonction pour obtenir les données des cryptomonnaies.
  // Function to get cryptocurrency data.
  Future<Map<String, String>> getCoinsData(String selectedCurrency) async {
    Map<String, String> exchangesData = {};

    for (String exchange in cryptoList) {
      NetworkHelper networkHelper = NetworkHelper(
          "$apiAddress/$exchange/$selectedCurrency?apikey=$kApiKey");
      var price = await networkHelper.getData();
      exchangesData[exchange] = price;
    }

    return exchangesData;
  }

  //  Fonction pour obtenir l'image associée à une cryptomonnaie.
  // Function to get the image associated with a cryptocurrency.
  String getImage(coin) {
    if (coin == 'BTC') {
      return 'bitcoin.gif';
    } else if (coin == 'LTC') {
      return 'litecoin.gif';
    } else {
      return 'ethereum.gif';
    }
  }

  //  Fonction pour obtenir le nom complet d'une cryptomonnaie.
  // Function to get the full name of a cryptocurrency.
  String getName(coin) {
    if (coin == 'BTC') {
      return 'BITCOIN';
    } else if (coin == 'LTC') {
      return 'LITECOIN';
    } else {
      return 'ETHEREUM';
    }
  }

  //  Fonction pour obtenir le nom complet d'une devise.
  // Function to get the full name of a currency.
  String getCurrenciesName(selectedCurrency) {
    String value = '';
    switch (selectedCurrency) {
      case 'XOF':
        value = 'FCFA';
        break;
      case 'AUD':
        value = 'DOLLAR AUS';
        break;
      case 'EUR':
        value = 'EURO';
        break;
      case 'GBP':
        value = 'LIVRE STER';
        break;
      case 'INR':
        value = 'ROUPIE';
        break;
      default:
        value = selectedCurrency;
    }
    return value;
  }
}
