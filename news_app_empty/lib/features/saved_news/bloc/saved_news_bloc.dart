import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'saved_news_event.dart';
part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  SavedNewsBloc() : super(SavedNewsInitial()) {
    on<SavedNewsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
