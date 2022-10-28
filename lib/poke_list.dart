import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/const/poke_api.dart';
import 'package:pokemon_pictorial_book/models/favorite.dart';
import 'package:pokemon_pictorial_book/models/pokemon.dart';
import 'package:pokemon_pictorial_book/poke_list_item.dart';
import 'package:provider/provider.dart';

class PokeList extends StatefulWidget {
  const PokeList({super.key});

  @override
  State<PokeList> createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  static const int pageSize = 30;

  bool isFavoriteMode = false;
  int _currentPage = 1;

  int itemCount(int favsCount, int page) {
    int ret = page * pageSize;
    if (isFavoriteMode && ret > favsCount) {
      ret = favsCount;
    }
    if (ret > pokeMaxId) {
      ret = pokeMaxId;
    }
    return ret;
  }

  int itemId(List<Favorite> favs, int index) {
    int ret = index + 1;
    if (isFavoriteMode) {
      ret = favs[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int favsCount, int page) {
    final currentPageSize = _currentPage * pageSize;
    final maxSize = isFavoriteMode ? favsCount : pokeMaxId;

    if (maxSize > currentPageSize) {
      return false;
    } else {
      return true;
    }
  }

  void changeFavMode(bool currentMode) {
    setState(() => isFavoriteMode = !currentMode);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesNotifier>(
      builder: (context, value, child) => Column(
        children: [
          Container(
            height: 24,
            alignment: Alignment.topRight,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.auto_awesome_outlined),
              onPressed: () async {
                var ret = await showModalBottomSheet<bool>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return ViewModeBottomSheet(
                      favMode: isFavoriteMode,
                      changeFavMode: changeFavMode,
                    );
                  },
                );
                if (ret != null && ret) {
                  changeFavMode(isFavoriteMode);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<PokemonNotifier>(builder: (context, pokes, child) {
              return itemCount(value.favs.length, _currentPage) == 0
                  ? const Text('No Data')
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      itemCount: itemCount(value.favs.length, _currentPage) + 1,
                      itemBuilder: (context, index) {
                        if (index ==
                            itemCount(value.favs.length, _currentPage)) {
                          return OutlinedButton(
                              onPressed:
                                  !isLastPage(value.favs.length, _currentPage)
                                      ? () => {
                                            setState(() => _currentPage++),
                                          }
                                      : null,
                              child: const Text('more'));
                        } else {
                          return PokeListItem(
                            pokemon: pokes.byId(itemId(value.favs, index)),
                          );
                        }
                      });
            }),
          ),
        ],
      ),
    );
  }
}

class ViewModeBottomSheet extends StatelessWidget {
  const ViewModeBottomSheet({
    Key? key,
    required this.favMode,
    required this.changeFavMode,
  }) : super(key: key);
  final bool favMode;
  final void Function(bool) changeFavMode;

  String get mainText => '表示設定';

  String menuFavTitle(bool fav) {
    if (fav) {
      return '「すべて」表示に切り替え';
    } else {
      return '「お気に入り」表示に切り替え';
    }
  }

  String menuFavSubtitle(bool fav) {
    if (fav) {
      return '全てのポケモンが表示されます';
    } else {
      return 'お気に入りに登録したポケモンのみが表示されます';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 5,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).backgroundColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                mainText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: Text(
                menuFavTitle(favMode),
              ),
              subtitle: Text(
                menuFavSubtitle(favMode),
              ),
              onTap: () {
                changeFavMode(favMode);
                Navigator.pop(context);
              },
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
    );
  }
}
