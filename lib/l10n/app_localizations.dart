import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ku.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
    Locale('ja'),
    Locale('tr'),
    Locale('de'),
    Locale('ku'),
    Locale('ru')
  ];

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @hijri_month_1.
  ///
  /// In en, this message translates to:
  /// **'Muharram'**
  String get hijri_month_1;

  /// No description provided for @voice_Memo.
  ///
  /// In en, this message translates to:
  /// **'Voice Memo'**
  String get voice_Memo;

  /// No description provided for @decrease_hijri_day.
  ///
  /// In en, this message translates to:
  /// **'Decrease Hijri Day'**
  String get decrease_hijri_day;

  /// No description provided for @increase_hijri_day.
  ///
  /// In en, this message translates to:
  /// **'Increase Hijri Day'**
  String get increase_hijri_day;

  /// No description provided for @hijri_month_2.
  ///
  /// In en, this message translates to:
  /// **'Safar'**
  String get hijri_month_2;

  /// No description provided for @hijri_month_3.
  ///
  /// In en, this message translates to:
  /// **'Rabi\' al-Awwal'**
  String get hijri_month_3;

  /// No description provided for @hijri_month_4.
  ///
  /// In en, this message translates to:
  /// **'Rabi\' al-Thani'**
  String get hijri_month_4;

  /// No description provided for @hijri_month_5.
  ///
  /// In en, this message translates to:
  /// **'Jumada al-Awwal'**
  String get hijri_month_5;

  /// No description provided for @hijri_month_6.
  ///
  /// In en, this message translates to:
  /// **'Jumada al-Thani'**
  String get hijri_month_6;

  /// No description provided for @hijri_month_7.
  ///
  /// In en, this message translates to:
  /// **'Rajab'**
  String get hijri_month_7;

  /// No description provided for @hijri_month_8.
  ///
  /// In en, this message translates to:
  /// **'Sha\'ban'**
  String get hijri_month_8;

  /// No description provided for @hijri_month_9.
  ///
  /// In en, this message translates to:
  /// **'Ramadan'**
  String get hijri_month_9;

  /// No description provided for @hijri_month_10.
  ///
  /// In en, this message translates to:
  /// **'Shawwal'**
  String get hijri_month_10;

  /// No description provided for @hijri_month_11.
  ///
  /// In en, this message translates to:
  /// **'Dhu al-Qi\'dah'**
  String get hijri_month_11;

  /// No description provided for @hijri_month_12.
  ///
  /// In en, this message translates to:
  /// **'Dhu al-Hijjah'**
  String get hijri_month_12;

  /// No description provided for @month_1.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get month_1;

  /// No description provided for @month_2.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get month_2;

  /// No description provided for @month_3.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get month_3;

  /// No description provided for @month_4.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get month_4;

  /// No description provided for @month_5.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get month_5;

  /// No description provided for @month_6.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get month_6;

  /// No description provided for @month_7.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get month_7;

  /// No description provided for @month_8.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get month_8;

  /// No description provided for @month_9.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get month_9;

  /// No description provided for @month_10.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get month_10;

  /// No description provided for @month_11.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get month_11;

  /// No description provided for @month_12.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get month_12;

  /// No description provided for @hijri_day_label.
  ///
  /// In en, this message translates to:
  /// **'Hijri Day: {day}'**
  String hijri_day_label(Object day);

  /// No description provided for @day_name_sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get day_name_sunday;

  /// No description provided for @day_name_monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get day_name_monday;

  /// No description provided for @day_name_tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get day_name_tuesday;

  /// No description provided for @day_name_wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get day_name_wednesday;

  /// No description provided for @day_name_thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get day_name_thursday;

  /// No description provided for @day_name_friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get day_name_friday;

  /// No description provided for @day_name_saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get day_name_saturday;

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get app_title;

  /// No description provided for @note_subject.
  ///
  /// In en, this message translates to:
  /// **'Note Subject'**
  String get note_subject;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @go_to_date.
  ///
  /// In en, this message translates to:
  /// **'Go to Date'**
  String get go_to_date;

  /// No description provided for @gregorian_calendar.
  ///
  /// In en, this message translates to:
  /// **'Gregorian Calendar'**
  String get gregorian_calendar;

  /// No description provided for @hijri_calendar.
  ///
  /// In en, this message translates to:
  /// **'Hijri Calendar'**
  String get hijri_calendar;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next_day.
  ///
  /// In en, this message translates to:
  /// **'Next Day'**
  String get next_day;

  /// No description provided for @previous_day.
  ///
  /// In en, this message translates to:
  /// **'Previous Day'**
  String get previous_day;

  /// No description provided for @greetings.
  ///
  /// In en, this message translates to:
  /// **'Best regards, Mohamed Al-Masry'**
  String get greetings;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @add_note.
  ///
  /// In en, this message translates to:
  /// **'Add Reminder'**
  String get add_note;

  /// No description provided for @reminder_log.
  ///
  /// In en, this message translates to:
  /// **'Reminder Log'**
  String get reminder_log;

  /// No description provided for @add_page.
  ///
  /// In en, this message translates to:
  /// **'Add Notebook Page'**
  String get add_page;

  /// No description provided for @notebook_pages.
  ///
  /// In en, this message translates to:
  /// **'Notebook Pages'**
  String get notebook_pages;

  /// No description provided for @time_remaining.
  ///
  /// In en, this message translates to:
  /// **'Time remaining for  prayer: '**
  String time_remaining(Object prayer, Object time);

  /// No description provided for @no_upcoming_prayer.
  ///
  /// In en, this message translates to:
  /// **'No upcoming prayer for today.'**
  String get no_upcoming_prayer;

  /// No description provided for @prayer_fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get prayer_fajr;

  /// No description provided for @prayer_sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get prayer_sunrise;

  /// No description provided for @prayer_dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get prayer_dhuhr;

  /// No description provided for @prayer_asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get prayer_asr;

  /// No description provided for @prayer_maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get prayer_maghrib;

  /// No description provided for @prayer_isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get prayer_isha;

  /// No description provided for @change_Language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_Language;

  /// No description provided for @prayer.
  ///
  /// In en, this message translates to:
  /// **'prayer'**
  String get prayer;

  /// No description provided for @celsius.
  ///
  /// In en, this message translates to:
  /// **'Celsius'**
  String get celsius;

  /// No description provided for @list_note.
  ///
  /// In en, this message translates to:
  /// **'Hijri Day'**
  String get list_note;

  /// No description provided for @time_speech.
  ///
  /// In en, this message translates to:
  /// **'Time Speech'**
  String get time_speech;

  /// No description provided for @weather_condition.
  ///
  /// In en, this message translates to:
  /// **'Weather Condition '**
  String get weather_condition;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr', 'ja', 'tr', 'de', 'ku', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'ja': return AppLocalizationsJa();
    case 'tr': return AppLocalizationsTr();
    case 'de': return AppLocalizationsDe();
    case 'ku': return AppLocalizationsKu();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
