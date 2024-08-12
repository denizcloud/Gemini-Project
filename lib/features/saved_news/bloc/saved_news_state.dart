part of 'saved_news_bloc.dart';

@immutable
abstract class SavedNewsState {}

abstract class SNActionState extends SavedNewsState {}

class SNInitial extends SavedNewsState {}

Future<List> getSaved() async {
  var pref = await SharedPreferences.getInstance();
  List saved = pref.getStringList('saved') ?? [];
  return saved;
}

class SavedSuccessState extends SavedNewsState {
  final List<String> snItems;
  SavedSuccessState({
    required this.snItems,
  });
}