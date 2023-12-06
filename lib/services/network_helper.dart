import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  //  Constructeur pour initialiser l'URL.
  // Constructor to initialize the URL.
  NetworkHelper(this.url);

  //  Fonction pour obtenir des données à partir de l'URL.
  // Function to get data from the URL.
  Future getData() async {
    //  Envoie une requête HTTP GET à l'URL.
    // Sends a GET HTTP request to the URL.
    http.Response response = await http.get(Uri.parse(url));

    //  Vérifie si la réponse a un code 200 (OK).
    // Checks if the response has a status code of 200 (OK).
    if (response.statusCode == 200) {
      //  Obtient les données du corps de la réponse.
      // Gets the data from the body of the response.
      var data = response.body;
      //  Extrait la valeur 'rate' du JSON et la convertit en double.
      // Extracts the 'rate' value from the JSON and converts it to a double.
      double price = jsonDecode(data)['rate'];
      //  Retourne le prix formaté en tant que chaîne de caractères.
      // Returns the formatted price as a string.
      return price.toStringAsFixed(0);
    } else {
      //  Affiche le code de statut de la réponse en cas d'erreur.
      // Prints the status code of the response in case of an error.
      print(response.statusCode);
    }
  }
}
