import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colecao_bolso_app/application/shared/shared.dart';

import '../bloc/list/exporter.dart';
import 'package:colecao_bolso_app/application/bloc/bloc.dart';
import 'collection_items_list.dart';
import '../../collections/collection_model.dart';

class CollectionListItemsView extends StatefulWidget {
  final int _collectionId;
  final CollectionBloc _bloc;
  final Collection _collection;

  const CollectionListItemsView(this._collectionId, this._bloc, this._collection);

  _CollectionListItemsViewState createState() =>
      _CollectionListItemsViewState();
}

class _CollectionListItemsViewState extends State<CollectionListItemsView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    widget._bloc
        .dispatch(CollectionFetchItemsEvent(widget._collectionId, false));
    super.initState();
  }

  _CollectionListItemsViewState() {
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      widget._bloc
          .dispatch(CollectionFetchItemsEvent(widget._collectionId, true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBaseEvent, BlocBaseState>(
      bloc: widget._bloc,
      builder: (BuildContext context, BlocBaseState state) {
        if (state is BlocLoadingIndicatorState) {
          return ShimmerList();
        }

        if (state is BlocErrorState) {
          return Empty(
            text: Text(state.error),
          );
        }

        if (state is CollectionItemsLoadedState) {
          if (state.data.isEmpty) {
            return Empty(
              text: Text('Que pena, ainda não há nenhum item cadastrado.'),
            );
          }
          return CollectionItemList(widget._bloc, state, widget._collection);
        }
      },
    );
  }
}
