import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:news_app_empty/data/news_item.dart';
import 'package:news_app_empty/features/news_button_model/news_button_model.dart';

part 'saved_news_event.dart';
part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  SavedNewsBloc() : super(SNInitial()) {
    on<SNInitialEvent>(snInitialEvent);
    on<SNRemoveFromSNEvent>(snRemoveFromsnEvent);
  }

  FutureOr<void> snInitialEvent(
      SNInitialEvent event, Emitter<SavedNewsState> emit) {
    emit(SavedSuccessState(snItems: snItems));
  }

  FutureOr<void> snRemoveFromsnEvent(
      SNRemoveFromSNEvent event, Emitter<SavedNewsState> emit) {
    snItems.remove(event.newsDataModel);
// emit()
    emit(SavedSuccessState(snItems: snItems));
  }
}