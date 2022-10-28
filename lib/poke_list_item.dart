import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/const/poke_api.dart';
import 'package:pokemon_pictorial_book/models/pokemon.dart';
import 'package:pokemon_pictorial_book/poke_detail.dart';

class PokeListItem extends StatelessWidget {
  const PokeListItem({super.key, required this.pokemon});

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return pokemon != null
        ? ListTile(
            leading: Container(
              width: 80,
              decoration: BoxDecoration(
                color:
                    (pokeTypeColors[pokemon!.types.first] ?? Colors.grey[100])
                        ?.withOpacity(.3),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: CachedNetworkImageProvider(
                    pokemon!.imageUrl,
                  ),
                ),
              ),
            ),
            title: Text(
              pokemon!.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(pokemon!.types.first),
            trailing: const Icon(Icons.navigate_next),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => PokeDetail(pokemon: pokemon)),
              ),
            ),
          )
        : const Center(
            child: Text('...'),
          );
  }
}
