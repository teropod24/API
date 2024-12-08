import 'package:flutter/material.dart';
import 'dart:async';
import 'Series_model.dart';
import 'Series_list.dart';
import 'new_Series_form.dart';
//
// Punto de entrada principal de la aplicación.
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración del MaterialApp con un tema oscuro y desactivación del banner de depuración.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My fav Series',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(
        title: 'My fav Series',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  // Declaración del estado asociado a este widget.
  // El uso de "library_private_types_in_public_api" está silenciado aquí.
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Lista inicial de series favoritas con títulos y un identificador.
  List<Series> initialSeries = 
  [
    Series('Juego de Tronos','63741002e2c75d8744f80a50'), 
    Series('Breaking Bad', '63741002e2c75d8744f80a51'),
    Series('Stranger Things', '63741002e2c75d8744f80a52')
  ];

  // Método para mostrar el formulario de nueva serie utilizando navegación.
  Future _showNewDigimonForm() async {
    Series? newDigimon = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddSeriesFormPage();
    }));
    // Si se devuelve una nueva serie del formulario, se añade a la lista.
    if(newDigimon != null){
      initialSeries.add(newDigimon);
      // Se actualiza el estado para reflejar los cambios en la UI.
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      // Barra superior con título centrado y botón para agregar series.
      appBar: AppBar( 
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0B479E),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showNewDigimonForm,
          ),
        ],
      ),
      body: Container(
          // Fondo de la aplicación con un color personalizado y lista de series en el centro.
          color: const Color.fromARGB(255, 88, 111, 137),
          child: Center(
            child: DigimonList(initialSeries),
          )),
    );
  }
}
