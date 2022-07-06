import 'package:bloc/bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeSelection> {
  HomeCubit() : super(HomeSelection.activity);

  void setPage(HomeSelection activity) {
    emit(activity);
  }
}
