import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/pages/favorites/bloc/favorites_state.dart';

class FavoritesBloc extends Cubit<FavoritesState> {
  FavoritesBloc() : super(FavoritesState());
}
