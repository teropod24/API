import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'Series_model.dart';

class AddSeriesFormPage extends StatefulWidget {
  const AddSeriesFormPage({super.key});

  @override
  _AddDigimonFormPageState createState() => _AddDigimonFormPageState();
  
}

class _AddDigimonFormPageState extends State<AddSeriesFormPage> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  void submitPup(BuildContext context) async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the series name'),
      ));
    } else {
      setState(() {
        isLoading = true; // Mostrar un indicador de carga
      });

      try {
        // Buscar el ID relacionado al nombre
        String? idtitle = await fetchIdByName(nameController.text);
        if (idtitle != null) {
          var newDigimon = Series(nameController.text, idtitle);
          Navigator.of(context).pop(newDigimon); // Regresar la nueva serie
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Series not found. Please check the name.'),
          ));
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Error: $error'),
        ));
      } finally {
        setState(() {
          isLoading = false; // Ocultar el indicador de carga
        });
      }
    }
  }

  Future<String?> fetchIdByName(String name) async {
    HttpClient http = HttpClient();
    try {
      var uri = Uri.https('peticiones.online', '/api/series');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      List<dynamic> data = json.decode(responseBody);
      // Buscar el ID por el nombre ingresado
      var matchedSeries = data.firstWhere(
        (item) => (item["title"] as String).toLowerCase() == name.toLowerCase(),
        orElse: () => null,
      );

      return matchedSeries?["_id"];
    } catch (exception) {
      throw 'Failed to fetch data: $exception';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new serie'),
        backgroundColor: const Color(0xFF0B479E),
      ),
      body: Container(
        color: const Color(0xFFABCAED),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Series Name',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: isLoading ? null : () => submitPup(context),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Submit Series'),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
