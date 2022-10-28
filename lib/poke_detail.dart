import 'package:cached_network_image/cached_network_image.dart';
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
        body: Container(
          color: (pokeTypeColors[pokemon?.types.first] ?? Colors.grey[100])
              ?.withOpacity(.5),
          child: SafeArea(
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
                              ? const Icon(Icons.star,
                                  color: Colors.orangeAccent)
                              : const Icon(Icons.star_outline),
                          onPressed: () =>
                              {value.toggle(Favorite(pokeId: pokemon!.id))},
                        ),
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              height: 280,
                              width: 280,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(180),
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                          ),
                          Positioned(
                            child: SizedBox(
                              child: CachedNetworkImage(
                                imageUrl: pokemon!.imageUrl,
                                height: 250,
                                width: 250,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.white.withOpacity(.5),
                        ),
                        child: Text(
                          '#${pokemon?.id.toString().padLeft(3, "0")}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${pokemon?.name.substring(0, 1).toUpperCase()}${pokemon?.name.substring(1)}',
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
                                      color:
                                          (pokeTypeColors[type] ?? Colors.grey)
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
      ),
    );
  }
}
