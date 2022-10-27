import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/const/poke_api.dart';
import 'package:pokemon_pictorial_book/models/favorite.dart';
import 'package:pokemon_pictorial_book/models/pokemon.dart';
import 'package:pokemon_pictorial_book/poke_list_item.dart';
import 'package:provider/provider.dart';

List<Favorite> _favMock = [
  Favorite(pokeId: 1),
  Favorite(pokeId: 4),
  Favorite(pokeId: 7),
];

class PokeList extends StatefulWidget {
  const PokeList({super.key});

  @override
  State<PokeList> createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  static const int pageSize = 30;

  bool isFavoriteMode = false;
  int _currentPage = 1;

  int itemCount(int page) {
    int ret = page * pageSize;
    if (isFavoriteMode && ret > _favMock.length) {
      ret = _favMock.length;
    }

    if (ret > pokeMaxId) {
      ret = pokeMaxId;
    }
    return ret;
  }

  int itemId(int index) {
    int ret = index + 1;
    if (isFavoriteMode) {
      ret = _favMock[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int page) {
    final currentPageSize = _currentPage * pageSize;
    final maxSize = isFavoriteMode ? _favMock.length : pokeMaxId;

    if (maxSize > currentPageSize) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonNotifier>(
      builder: (context, pokes, child) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          itemCount: itemCount(_currentPage) + 1,
          itemBuilder: (context, index) {
            if (index == itemCount(_currentPage)) {
              return OutlinedButton(
                  onPressed: !isLastPage(_currentPage)
                      ? () => {
                            setState(() => _currentPage++),
                          }
                      : null,
                  child: const Text('more'));
            } else {
              return PokeListItem(
                pokemon: pokes.byId(itemId(index)),
              );
            }
          }),
    );
  }
}
