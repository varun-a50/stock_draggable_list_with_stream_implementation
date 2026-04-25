import 'package:diamondhandllp/features/wishlist/domain/repository/wishlist_repository.dart';

class CreateWishlist {
  final WishlistRepository wishlistRepository;

  CreateWishlist({required this.wishlistRepository});

  Future<void> call(String id, String name) async {
    await wishlistRepository.createWishList(id, name);
  }
}
