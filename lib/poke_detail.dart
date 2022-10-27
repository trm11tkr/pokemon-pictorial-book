import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/const/poke_api.dart';
import 'package:pokemon_pictorial_book/models/pokemon.dart';

class PokeDetail extends StatelessWidget {
  const PokeDetail({super.key, this.pokemon});

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
          child: pokemon != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      pokemon!.imageUrl,
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      pokemon!.name,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Chip(
                      label: Text(
                        pokemon!.types.join(' , '),
                        style: TextStyle(
                          color: Colors.yellow.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      backgroundColor: (pokeTypeColors[pokemon!.types.first] ??
                              Colors.grey[100])
                          ?.withOpacity(.3),
                    )
                  ],
                )
              : const Text('Not Found')),
    );
  }
}
