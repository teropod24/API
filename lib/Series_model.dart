// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Series {
  String? title;
  String? channel;
  String? creator;
  String? imageUrl;
  String? dates;
  final String name;
  String? idtitle;
  int rating = 10;

  Series(this.name, this.idtitle);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = HttpClient();
    try {
      title = name.toLowerCase();
      var uri = Uri.https('peticiones.online', '/api/series');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      List<dynamic> data = json.decode(responseBody);

      // Buscamos el elemento con el idtitle correspondiente.
      var matchedSeries = data.firstWhere(
        (item) => item["_id"] == idtitle,
        orElse: () => null,
      );

      if (matchedSeries != null) {
        imageUrl = matchedSeries["image"];
        title = matchedSeries["title"];
        creator = matchedSeries["creator"];
        channel = matchedSeries["channel"];
        dates = matchedSeries["dates"];
      }
      //print(levelDigimon);
    } catch (exception) {
      //print(exception);
    }
  }
}
