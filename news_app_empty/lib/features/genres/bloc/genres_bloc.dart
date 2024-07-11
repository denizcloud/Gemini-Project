import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  GenresBloc() : super(GenresInitial()) {
    on<GenresEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
