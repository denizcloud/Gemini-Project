part of 'saved_news_bloc.dart';

@immutable
abstract class SavedNewsState {}

abstract class SNActionState extends SavedNewsState {}

class SNInitial extends SavedNewsState {}

class SavedSuccessState extends SavedNewsState {
  final List<NewsDataModel> snItems;
  SavedSuccessState({
    required this.snItems,
  });
}