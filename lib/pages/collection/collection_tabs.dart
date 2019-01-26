import 'package:flutter/material.dart';
import './collection_favorite.dart';
import './collection_list.dart';
import './collection_repetead.dart';
import './../../entities/collectionEntity.dart';


class CollectionPage extends StatelessWidget {
  final List<CollectionEntity> collections;
  final int index;
  final int collectionId;

  CollectionPage(this.collections, this.index, this.collectionId);

  @override
  Widget build(BuildContext context) {
    var collection = collections[index];

    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(collection.name),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.view_list),
                  text: 'Itens',
                ),
                Tab(
                  icon: Icon(Icons.playlist_add_check),
                  text: 'Repetidos',
                ),
                Tab(
                  icon: Icon(Icons.favorite_border),
                  text: 'Favoritos',
                )
              ],
            ),
          ),
          body: TabBarView(children: <Widget>[
            CollectionListItemsView(),
            CollectionRepeatedItemsView(),
            CollectionFavoriteItemsView(),
          ],),
        ),
      ),
    );
  }
}
