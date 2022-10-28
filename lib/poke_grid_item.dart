import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/const/poke_api.dart';
import './poke_detail.dart';
import './models/pokemon.dart';

class PokeGridItem extends StatelessWidget {
  const PokeGridItem({Key? key, required this.pokemon}) : super(key: key);
  final Pokemon? pokemon;
  @override
  Widget build(BuildContext context) {
    if (pokemon != null) {
      return Column(
        children: [
          InkWell(
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PokeDetail(pokemon: pokemon),
                ),
              ),
            },
            child: Hero(
              tag: pokemon!.name,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color:
                      (pokeTypeColors[pokemon!.types.first] ?? Colors.grey[100])
                          ?.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: CachedNetworkImageProvider(
                      pokemon!.imageUrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            pokemon!.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return const SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Text('...'),
        ),
      );
    }
  }
}
