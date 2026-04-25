import 'package:diamondhandllp/features/wishlist/domain/entity/wishlist.dart';
import 'package:diamondhandllp/features/wishlist/domain/repository/wishlist_repository.dart';

class GetAllWishlist {
  final WishlistRepository repository;

  GetAllWishlist({required this.repository});

  Stream<List<Wishlist>> call() {
    return repository.getAllWishlists();
  }
}
