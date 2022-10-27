import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/models/pokemon.dart';
import 'package:pokemon_pictorial_book/poke_list_item.dart';
import 'package:provider/provider.dart';

class PokeList extends StatelessWidget {
  const PokeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonNotifier>(
      builder: (context, pokes, child) => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        itemCount: 10,
        itemBuilder: (context, index) =>
            PokeListItem(pokemon: pokes.byId(index + 1)),
      ),
    );
  }
}
