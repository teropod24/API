import 'package:flutter/material.dart';
import 'Series_model.dart';

class DigimonDetailPage extends StatefulWidget {
  final Series digimon;
  const DigimonDetailPage(this.digimon, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DigimonDetailPageState createState() => _DigimonDetailPageState();
}

class _DigimonDetailPageState extends State<DigimonDetailPage> {
  final double digimonAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color(0xFF0B479E),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text(
                  '${_sliderValue.toInt()}',
                  style: const TextStyle(color: Colors.black, fontSize: 25.0),
                ),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    setState(() {
      widget.digimon.rating = _sliderValue.toInt();
    });
  }

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.digimon.rating.toDouble();
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      child: const Text('Submit'),
    );
  }

  Widget get digimonImage {
    return Hero(
      tag: widget.digimon,
      child: Container(
        height: digimonAvarterSize,
        width: digimonAvarterSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.digimon.imageUrl ?? ""),
          ),
        ),
      ),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.star,
          size: 40.0,
          color: Colors.yellow,
        ),
        Text(
          '${widget.digimon.rating}/10',
          style: const TextStyle(color: Colors.black, fontSize: 30.0),
        ),
      ],
    );
  }

  Widget get digimonProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color(0xFFABCAED),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          digimonImage,
          const SizedBox(height: 10),
          Text(
            widget.digimon.name,
            style: const TextStyle(color: Colors.black, fontSize: 32.0),
          ),
          const SizedBox(height: 5),
          Text(
            'Created by ${widget.digimon.creator ?? "Unknown"}',
            style: const TextStyle(color: Colors.black54, fontSize: 18.0),
          ),
          const SizedBox(height: 5),
          Text(
            'You can see it in ${widget.digimon.channel ?? "Unknown"}',
            style: const TextStyle(color: Colors.black54, fontSize: 18.0),
          ),
          Text(
            'From ${widget.digimon.dates ?? "Unknown"} old',
            style: const TextStyle(color: Colors.black54, fontSize: 18.0),
          ),
          const SizedBox(height: 20),
          rating,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFABCAED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B479E),
        title: Text('Serie: ${widget.digimon.title ?? "Unknown"}'),
      ),
      body: ListView(
        children: <Widget>[digimonProfile, addYourRating],
      ),
    );
  }
}
