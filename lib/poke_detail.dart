import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/const/poke_api.dart';
import 'package:pokemon_pictorial_book/models/favorite.dart';
import 'package:pokemon_pictorial_book/models/pokemon.dart';
import 'package:provider/provider.dart';

class PokeDetail extends StatelessWidget {
  const PokeDetail({super.key, this.pokemon});

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesNotifier>(
      builder: (context, value, child) => Scaffold(
        body: SafeArea(
          child: pokemon != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      trailing: IconButton(
                        icon: value.isExist(pokemon!.id)
                            ? const Icon(Icons.star, color: Colors.orangeAccent)
                            : const Icon(Icons.star_outline),
                        onPressed: () =>
                            {value.toggle(Favorite(pokeId: pokemon!.id))},
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32),
                          child: Image.network(
                            pokemon!.imageUrl,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'No.${pokemon!.id}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      pokemon!.name,
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: pokemon!.types
                          .map(
                            (type) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Chip(
                                backgroundColor:
                                    pokeTypeColors[type] ?? Colors.grey,
                                label: Text(
                                  type,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: (pokeTypeColors[type] ?? Colors.grey)
                                                .computeLuminance() >
                                            0.5
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const Spacer(),
                  ],
                )
              : const Center(child: Text('Not Found')),
        ),
      ),
    );
  }
}
