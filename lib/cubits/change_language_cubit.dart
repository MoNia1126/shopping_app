import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubits/change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(ChangeLanguageState(Locale("en")));

  void changeLanguage(String languageCode) {
    emit(ChangeLanguageState(Locale(languageCode)));
  }
}
