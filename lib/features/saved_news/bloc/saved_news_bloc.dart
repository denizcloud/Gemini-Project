import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:news_app_empty/data/news_item.dart';
import 'package:news_app_empty/features/news_button_model/news_button_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'saved_news_event.dart';
part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  SavedNewsBloc() : super(SNInitial()) {
    on<SNInitialEvent>(snInitialEvent);
    on<SNRemoveFromSNEvent>(snRemoveFromsnEvent);
  }


  Future<List<String>> getSaved() async {
    var pref = await SharedPreferences.getInstance();
    List<String> saved = pref.getStringList('saved') ?? [];
    return saved;
  }



  FutureOr<void> snInitialEvent(
      SNInitialEvent event, Emitter<SavedNewsState> emit) {
          Future<List<String>> saved = getSaved();
          FutureBuilder(
            future: saved,
            builder: (context, snapshot){
              if (snapshot.hasData){
                print("here");
                emit (SavedSuccessState(snItems: snapshot.data ?? []));
                return Container();
              }else{
                print("there");
                emit(SavedSuccessState(snItems:[]));
                return Container();
              }
            },
          );

  }

  FutureOr<void> snRemoveFromsnEvent(
      SNRemoveFromSNEvent event, Emitter<SavedNewsState> emit) {
    snItems.remove(event.newsDataModel);
// emit()
    emit(SavedSuccessState(snItems: []));
  }
}