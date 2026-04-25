import 'package:diamondhandllp/features/wishlist/domain/repository/wishlist_repository.dart';

class AddStockToWishlist {
  final WishlistRepository repository;

  AddStockToWishlist({required this.repository});

  Future<void> call(String id, String name) async {
    await repository.addStockToWishList(id, name);
  }
}
