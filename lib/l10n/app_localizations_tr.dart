// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get temperature => 'Sıcaklık';

  @override
  String get hijri_month_1 => 'Muharrem';

  @override
  String get voice_Memo => 'Sesli Not';

  @override
  String get decrease_hijri_day => 'Hicri günü azalt';

  @override
  String get increase_hijri_day => 'Hicri günü artır';

  @override
  String get hijri_month_2 => 'Safer';

  @override
  String get hijri_month_3 => 'Rebiülevvel';

  @override
  String get hijri_month_4 => 'Rebiülahir';

  @override
  String get hijri_month_5 => 'Cemaziyelevvel';

  @override
  String get hijri_month_6 => 'Cemaziyelahir';

  @override
  String get hijri_month_7 => 'Recep';

  @override
  String get hijri_month_8 => 'Şaban';

  @override
  String get hijri_month_9 => 'Ramazan';

  @override
  String get hijri_month_10 => 'Şevval';

  @override
  String get hijri_month_11 => 'Zilkaide';

  @override
  String get hijri_month_12 => 'Zilhicce';

  @override
  String get month_1 => 'Ocak';

  @override
  String get month_2 => 'Şubat';

  @override
  String get month_3 => 'Mart';

  @override
  String get month_4 => 'Nisan';

  @override
  String get month_5 => 'Mayıs';

  @override
  String get month_6 => 'Haziran';

  @override
  String get month_7 => 'Temmuz';

  @override
  String get month_8 => 'Ağustos';

  @override
  String get month_9 => 'Eylül';

  @override
  String get month_10 => 'Ekim';

  @override
  String get month_11 => 'Kasım';

  @override
  String get month_12 => 'Aralık';

  @override
  String hijri_day_label(Object day) {
    return 'Hijri Day: $day';
  }

  @override
  String get day_name_sunday => 'Pazar';

  @override
  String get day_name_monday => 'Pazartesi';

  @override
  String get day_name_tuesday => 'Salı';

  @override
  String get day_name_wednesday => 'Çarşamba';

  @override
  String get day_name_thursday => 'Perşembe';

  @override
  String get day_name_friday => 'Cuma';

  @override
  String get day_name_saturday => 'Cumartesi';

  @override
  String get app_title => 'Takvim';

  @override
  String get note_subject => 'Note Subject';

  @override
  String get save => 'Kaydet';

  @override
  String get go_to_date => 'Tarihe Git';

  @override
  String get gregorian_calendar => 'Miladi Takvim';

  @override
  String get hijri_calendar => 'Hicri Takvim';

  @override
  String get back => 'Geri';

  @override
  String get next_day => 'Sonraki Gün';

  @override
  String get previous_day => 'Önceki Gün';

  @override
  String get greetings => 'Saygılarımla, Mohamed Al-Masry';

  @override
  String get settings => 'Ayarlar';

  @override
  String get add_note => 'Hatırlatma Ekle';

  @override
  String get reminder_log => 'Hatırlatma Kaydı';

  @override
  String get add_page => 'Defter Sayfası Ekle';

  @override
  String get notebook_pages => 'Defter Sayfaları';

  @override
  String time_remaining(Object prayer, Object time) {
    return 'Kalan süre $prayer namazı için: $time';
  }

  @override
  String get no_upcoming_prayer => 'Bugün için gelecek namaz bulunmamaktadır.';

  @override
  String get prayer_fajr => 'İmsak';

  @override
  String get prayer_sunrise => 'Güneş';

  @override
  String get prayer_dhuhr => 'Öğle';

  @override
  String get prayer_asr => 'İkindi';

  @override
  String get prayer_maghrib => 'Akşam';

  @override
  String get prayer_isha => 'Yatsı';

  @override
  String get change_Language => 'Dili Değiştir';

  @override
  String get prayer => 'prayer';

  @override
  String get celsius => 'Santigrat';

  @override
  String get list_note => 'Bilet Günlüğü';

  @override
  String get time_speech => 'Zaman Konuşması';

  @override
  String get weather_condition => 'Hava Durumu';
}
