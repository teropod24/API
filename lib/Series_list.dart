import 'package:digimon/Series_card.dart';
import 'package:flutter/material.dart';
import 'Series_model.dart';

class DigimonList extends StatelessWidget {
  final List<Series> series;
  const DigimonList(this.series, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: series.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return DigimonCard(series[int]);
      },
    );
  }
}