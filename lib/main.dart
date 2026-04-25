import 'package:diamondhandllp/features/bottom_navigation/presentation/screens/bottom_navigation.dart';
import 'package:diamondhandllp/features/stock_dashboard/data/datasource/stock_datasource.dart';
import 'package:diamondhandllp/features/stock_dashboard/data/repository/stock_repository_impl.dart';
import 'package:diamondhandllp/features/stock_dashboard/domain/usecase/get_stock_stream.dart';
import 'package:diamondhandllp/features/stock_dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:diamondhandllp/features/stock_dashboard/presentation/bloc/dashboard_event.dart';
import 'package:diamondhandllp/features/wishlist/data/datasource/wishlist_datasource.dart';
import 'package:diamondhandllp/features/wishlist/data/model/wishlist_model.dart';
import 'package:diamondhandllp/features/wishlist/data/repository/wishlist_repository_impl.dart';
import 'package:diamondhandllp/features/wishlist/domain/usecase/add_stock_to_wishlist.dart';
import 'package:diamondhandllp/features/wishlist/domain/usecase/create_wishlist.dart';
import 'package:diamondhandllp/features/wishlist/domain/usecase/get_all_wishlist.dart';
import 'package:diamondhandllp/features/wishlist/domain/usecase/get_wishlist_by_id.dart';
import 'package:diamondhandllp/features/wishlist/domain/usecase/reorder_stock.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(WishlistModelAdapter());
  final datasource = StockDataSourceImpl();
  final repository = StockRepositoryImpl(datasource);

  final wishlistBox = await Hive.openBox<WishlistModel>("wishlist");

  final wishlistDatasource = WishlistDatasourceImpl(
    wishlistBox: wishlistBox,
    source: datasource,
  );

  final wishlistRepository = WishlistRepositoryImpl(
    datasource: wishlistDatasource,
  );
  await wishlistDatasource.seedDefaultWishlists();
  runApp(MyApp(repository: repository, wishlistRepository: wishlistRepository));
}

class MyApp extends StatelessWidget {
  final StockRepositoryImpl repository;
  final WishlistRepositoryImpl wishlistRepository;
  const MyApp({
    super.key,
    required this.repository,
    required this.wishlistRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StockRepositoryImpl>.value(value: repository),
        RepositoryProvider<GetStockStream>(
          create: (context) =>
              GetStockStream(context.read<StockRepositoryImpl>()),
        ),
        RepositoryProvider<WishlistRepositoryImpl>.value(
          value: wishlistRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final bloc = DashboardBloc(
                getStockStream: context.read<GetStockStream>(),
              );
              bloc.add(StartStockStream());
              return bloc;
            },
          ),
          BlocProvider(
            create: (context) {
              final bloc = WishlistBloc(
                getWishlishById: GetWishlistById(
                  repository: wishlistRepository,
                ),
                createWishlist: CreateWishlist(
                  wishlistRepository: wishlistRepository,
                ),
                addStockToWishlist: AddStockToWishlist(
                  repository: wishlistRepository,
                ),
                getAllWishlist: GetAllWishlist(repository: wishlistRepository),
                reorderStock: ReorderStock(repository: wishlistRepository),
              );

              bloc.add(LoadWishlistsEvent()); // ✅ ADD THIS

              return bloc;
            },
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const BottomNavigation(),
        ),
      ),
    );
  }
}
