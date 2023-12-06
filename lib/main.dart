import 'package:bitcoi_ticker/Screens/price_screen.dart';
import 'package:bitcoi_ticker/const.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//Add you Coin ApiKey
//Ajoutez votre clé d'Api Coin

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //  Titre de l'application.
      //  Title of the application.
      title: 'Symbole de Crypto',
      //  Désactive la bannière de débogage en mode développement.
      //  Disables the debug banner in development mode.
      debugShowCheckedModeBanner: false,
      //  Thème global de l'application, mode sombre activé avec une couleur de fond spécifique.
      //  Global theme of the application, dark mode enabled with a specific background color.
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      //  Page d'accueil de l'application.
      //  Home page of the application.
      home: kApiKey == ""
          ? const SafeArea(
              child: Center(
                  child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Add your Coin ApiKey',
                style: TextStyle(fontSize: 25),
              ),
            )))
          : const PriceScreen(),
    );
  }
}
