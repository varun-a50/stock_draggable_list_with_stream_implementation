import 'dart:async';

import 'package:diamondhandllp/features/stock_dashboard/domain/usecase/get_stock_stream.dart';
import 'package:diamondhandllp/features/stock_dashboard/presentation/bloc/dashboard_event.dart';
import 'package:diamondhandllp/features/stock_dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetStockStream getStockStream;

  StreamSubscription? _subscription;

  DashboardBloc({required this.getStockStream}) : super(StockInitial()) {
    on<StartStockStream>((event, emit) async {
      emit(StockLoading());

      _subscription = getStockStream().listen((stocks) {
        add(StockUpdated(stocks));
      });
    });

    on<StockUpdated>((event, emit) {
      emit(StockLoaded(event.stocks));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
