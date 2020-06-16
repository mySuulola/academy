import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fastorder/bloc/provider.dart';
import 'package:fastorder/models/bookItem.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';


class CartListBloc extends BlocBase {

  CartListBloc();

  CartProvider cartProvider = CartProvider();

  var _listController = BehaviorSubject<List<BookItem>>.seeded([]);

  Stream<List<BookItem>> get listStream => _listController.stream;

  Sink<List<BookItem>> get listSink => _listController.sink;

  // business logic

  addToList(BookItem bookItem) {
    listSink.add(cartProvider.addToList(bookItem));
  }


  removeFromList(BookItem bookItem) {
    listSink.add(cartProvider.removeFromList(bookItem));
  }


  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }

}