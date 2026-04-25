import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreenEdit extends StatefulWidget {
  final List<String> stockNames;
  final String wishlistId;
  final String wishlistName;

  const WishlistScreenEdit({
    super.key,
    required this.stockNames,
    required this.wishlistId,
    required this.wishlistName,
  });

  @override
  State<WishlistScreenEdit> createState() => _WishlistScreenEditState();
}

class _WishlistScreenEditState extends State<WishlistScreenEdit> {
  late List<String> _stocks;

  @override
  void initState() {
    super.initState();
    _stocks = List.from(widget.stockNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 48, 16, 8),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(widget.wishlistName),
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: _onReorder,
              children: _stocks.map((stock) {
                return ListTile(
                  key: ValueKey(stock),
                  title: Text(stock),
                  trailing: Icon(Icons.drag_handle),
                );
              }).toList(),
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("We will get this in next release")),
                );
              },
              child: Text("Edit other Wishlist"),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,

            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255),
                  width: 2,
                ),
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                backgroundColor: Color.fromARGB(255, 2, 2, 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Save Watch List"),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;

      final item = _stocks.removeAt(oldIndex);
      _stocks.insert(newIndex, item);
    });

    context.read<WishlistBloc>().add(
      ReorderWishlistEvent(
        id: widget.wishlistId,
        newIndex: newIndex,
        oldIndex: oldIndex,
      ),
    );
  }
}
