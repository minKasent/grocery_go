class CartEntity {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final String thumbnail;

  const CartEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.thumbnail,
  });
}
