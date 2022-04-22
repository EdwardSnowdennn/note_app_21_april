import 'dart:io';
import 'package:note_app_21_april/services/language_service.dart';

import 'locals/en_US.dart';
import 'locals/ru_RU.dart';
import 'locals/uz_UZ.dart';

///  this service for extencion for language

extension ExtString on String {
  String get tranlate {
    switch (LangService.language) {
      case Language.uz:
        return uzUZ[this] ?? this;
      case Language.ru:
        return ruRU[this] ?? this;
      case Language.en:
        return enUS[this] ?? this;
    }
  }

  /// this methods for parse int , double ,bool
  int get toInt {
    return int.tryParse(this) ?? 0;
  }

  double get toDouble {
    return double.tryParse(this) ?? 0;
  }

  bool get toBool {
    if (this == 'true') {
      return true;
    } else {
      return false;
    }
  }
}
