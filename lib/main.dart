import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/poke_detail.dart';
import 'package:pokemon_pictorial_book/poke_list_item.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TopPage(),
    );
  }
}

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemBuilder: ((context, index) => PokeListItem(index: index)),
      itemCount: 10,
    ));
  }
}
