part of 'genres_bloc.dart';

sealed class GenresState extends Equatable {
  const GenresState();
  
  @override
  List<Object> get props => [];
}

final class GenresInitial extends GenresState {}
