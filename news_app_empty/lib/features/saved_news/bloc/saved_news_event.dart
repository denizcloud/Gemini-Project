part of 'saved_news_bloc.dart';

@immutable
abstract class SavedNewsEvent {}

class SNInitialEvent extends SavedNewsEvent{
  
}


class SNRemoveFromSNEvent extends SavedNewsEvent {
  final NewsDataModel newsDataModel;
  SNRemoveFromSNEvent({
    required this.newsDataModel,
  });
}
