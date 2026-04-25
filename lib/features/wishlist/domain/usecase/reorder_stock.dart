import 'package:diamondhandllp/features/wishlist/domain/repository/wishlist_repository.dart';

class ReorderStock {
  final WishlistRepository repository;

  ReorderStock({required this.repository});

  Future<void> call(String id, int oldIndex, int newIndex) async {
    await repository.reorderStock(id, oldIndex, newIndex);
  }
}
