import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/poke_detail.dart';

class PokeListItem extends StatelessWidget {
  const PokeListItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
        height: 50,
        width: 50,
      ),
      title: const Text('Pikacheu'),
      subtitle: const Text('electric'),
      trailing: const Icon(Icons.navigate_next),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => const PokeDetail()),
        ),
      ),
    );
  }
}
