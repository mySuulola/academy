import 'package:meta/meta.dart';

BookLibrary bookLibrary = BookLibrary(bookItems: [
  BookItem(
    id: 1, 
    description: 'In this stunning new book, Malcolm Gladwell takes us on an intellectual journey through the world of "outliers"--the best and the brightest, the most famous and the most successful. He asks the question: what makes high-achievers different?', 
    title: 'Outliers', 
    price: 30.60, 
    imgUrl: 'https://images-na.ssl-images-amazon.com/images/I/41S-f0G1J5L._SX328_BO1,204,203,200_.jpg',
    author: 'Malcom Gladwell',
    ),
  BookItem(
    id: 2, 
    description: "Three thousand years ago on a battlefield in ancient Palestine, a shepherd boy felled a mighty warrior with nothing more than a stone and a sling, and ever since then the names of David and Goliath have stood for battles between underdogs and giants. David's victory was improbable and miraculous. He shouldn't have won.", 
    title: 'David and Goliath', 
    price: 11.98, 
    imgUrl: 'https://images-na.ssl-images-amazon.com/images/I/41H9ZCmjenL._SX331_BO1,204,203,200_.jpg',
    author: 'Malcom Gladwell',
    ),
  BookItem(
    id: 3, 
    description: 'The tipping point is that magic moment when an idea, trend, or social behavior crosses a threshold, tips, and spreads like wildfire. Just as a single sick person can start an epidemic of the flu, so too can a small but precisely targeted push cause a fashion trend, the popularity of a new product, or a drop in the crime rate. This widely acclaimed bestseller, in which Malcolm Gladwell explores and brilliantly illuminates the tipping point phenomenon, is already changing the way people throughout the world think about selling products and disseminating ideas.', 
    title: 'The Tipping Point', 
    price: 11.99, 
    imgUrl: 'https://images-na.ssl-images-amazon.com/images/I/41rR8bYsqXL._SX331_BO1,204,203,200_.jpg',
    author: 'Malcom Gladwell',
    ),
]);

class BookLibrary {
  List<BookItem> bookItems;

  BookLibrary({ 
    @required this.bookItems,
   });
}

class BookItem {
  int id;
  String title;
  String description;
  double price;
  String imgUrl;
  String author;
  int quantity;

  BookItem({
    @required this.id,
    @required this.description,
    @required this.title,
    @required this.author,
    @required this.price,
    @required this.imgUrl,

    this.quantity = 1,

  });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }
  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }




}