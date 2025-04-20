// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get temperature => 'Temperature';

  @override
  String get hijri_month_1 => 'Мухаррам';

  @override
  String get voice_Memo => 'Голосовая заметка';

  @override
  String get decrease_hijri_day => 'Уменьшить хиджру день';

  @override
  String get increase_hijri_day => 'Увеличить хиджру день';

  @override
  String get hijri_month_2 => 'Сафар';

  @override
  String get hijri_month_3 => 'Раби аль-авваль';

  @override
  String get hijri_month_4 => 'Раби аль-ахир';

  @override
  String get hijri_month_5 => 'Джумад аль-авваль';

  @override
  String get hijri_month_6 => 'Джумад аль-ахира';

  @override
  String get hijri_month_7 => 'Раджаб';

  @override
  String get hijri_month_8 => 'Шаабан';

  @override
  String get hijri_month_9 => 'Рамадан';

  @override
  String get hijri_month_10 => 'Шавваль';

  @override
  String get hijri_month_11 => 'Зу-ль-Каада';

  @override
  String get hijri_month_12 => 'Зу-ль-Хиджа';

  @override
  String get month_1 => 'Январь';

  @override
  String get month_2 => 'Февраль';

  @override
  String get month_3 => 'Март';

  @override
  String get month_4 => 'Апрель';

  @override
  String get month_5 => 'Май';

  @override
  String get month_6 => 'Июнь';

  @override
  String get month_7 => 'Июль';

  @override
  String get month_8 => 'Август';

  @override
  String get month_9 => 'Сентябрь';

  @override
  String get month_10 => 'Октябрь';

  @override
  String get month_11 => 'Ноябрь';

  @override
  String get month_12 => 'Декабрь';

  @override
  String hijri_day_label(Object day) {
    return 'Хиджри день: $day';
  }

  @override
  String get day_name_sunday => 'Воскресенье';

  @override
  String get day_name_monday => 'Понедельник';

  @override
  String get day_name_tuesday => 'Вторник';

  @override
  String get day_name_wednesday => 'Среда';

  @override
  String get day_name_thursday => 'Четверг';

  @override
  String get day_name_friday => 'Пятница';

  @override
  String get day_name_saturday => 'Суббота';

  @override
  String get app_title => 'Калькулятор возраста';

  @override
  String get note_subject => 'Тема заметки';

  @override
  String get save => 'Сохранить';

  @override
  String get go_to_date => 'Перейти к дате';

  @override
  String get gregorian_calendar => 'Григорианский календарь';

  @override
  String get hijri_calendar => 'Календарь Хиджры';

  @override
  String get back => 'Назад';

  @override
  String get next_day => 'Следующий день';

  @override
  String get previous_day => 'Предыдущий день';

  @override
  String get greetings => 'С уважением, Мохаммед аль-Масри';

  @override
  String get settings => 'Настройки';

  @override
  String get add_note => 'Добавить заметку';

  @override
  String get reminder_log => 'Журнал напоминаний';

  @override
  String get add_page => 'Добавить страницу в блокнот';

  @override
  String get notebook_pages => 'Страницы блокнота';

  @override
  String time_remaining(Object prayer, Object time) {
    return 'Оставшееся время до азана';
  }

  @override
  String get no_upcoming_prayer => 'Нет предстоящей молитвы на сегодня';

  @override
  String get prayer_fajr => 'Фаджр';

  @override
  String get prayer_sunrise => 'Восход';

  @override
  String get prayer_dhuhr => 'Зухр';

  @override
  String get prayer_asr => 'Аср';

  @override
  String get prayer_maghrib => 'Магриб';

  @override
  String get prayer_isha => 'Иша';

  @override
  String get change_Language => 'Сменить язык';

  @override
  String get prayer => 'Молитва';

  @override
  String get celsius => 'Цельсий';

  @override
  String get list_note => 'Журнал билетов';

  @override
  String get time_speech => 'Озвучивание времени';

  @override
  String get weather_condition => 'Погодные условия';
}
