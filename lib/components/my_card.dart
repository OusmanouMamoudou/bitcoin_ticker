import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.rate,
    required this.selectedCurrency,
    required this.name,
    required this.coin,
    required this.image,
    required this.isLoading,
  });

  final String selectedCurrency, rate, name, image, coin;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 50),
                  Image.asset(
                    'images/$image',
                    height: 100,
                  ),
                  // Nom de la cryptomonnaie.
                  //  Cryptocurrency name.
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Affiche un indicateur de chargement si la donnée est en cours de chargement.
              //  Displays a loading indicator if the data is still loading.
              isLoading
                  ? const SpinKitHourGlass(
                      color: Colors.white,
                      size: 50,
                    )
                  // Affiche le taux de change si la donnée n'est plus en cours de chargement.
                  //  Displays the exchange rate if the data is no longer loading.
                  : Text(
                      '1 $coin = ${NumberFormat.compact().format(int.parse(rate))} $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
