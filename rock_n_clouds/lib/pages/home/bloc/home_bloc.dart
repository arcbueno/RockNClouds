import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_clouds/pages/home/bloc/home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState(isLoading: false));
}
