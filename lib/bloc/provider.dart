import 'package:fastorder/models/bookItem.dart';

class CartProvider {
  List<BookItem> bookItems = [];

  List<BookItem> addToList(BookItem bookItem) {
    bookItems.add(bookItem);
    return bookItems;
  }

  List<BookItem> removeFromList(BookItem bookItem) {
    bookItems.remove(bookItem);
    return bookItems;
  }
}