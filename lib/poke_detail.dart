import 'package:flutter/material.dart';

class PokeDetail extends StatelessWidget {
  const PokeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
            height: 100,
            width: 100,
          ),
          const Text(
            'Pikachu',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const Chip(
            label: Text('electric'),
            backgroundColor: Colors.yellow,
          )
        ],
      )),
    );
  }
}
