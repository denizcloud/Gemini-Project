part of 'saved_news_bloc.dart';

sealed class SavedNewsState extends Equatable {
  const SavedNewsState();
  
  @override
  List<Object> get props => [];
}

final class SavedNewsInitial extends SavedNewsState {}
