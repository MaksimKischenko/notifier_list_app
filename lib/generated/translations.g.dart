
/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 40 (20.0 per locale)
 *
 * Built on 2022-06-28 at 08:49 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.ru;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.ru) // set locale
/// - Locale locale = AppLocale.ru.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.ru) // locale check
enum AppLocale {
	ru, // 'ru' (base locale, fallback)
	en, // 'en'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
_TranslationsRu _t = _currLocale.translations;
_TranslationsRu get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
class Translations {
	Translations._(); // no constructor

	static _TranslationsRu of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale useDeviceLocale() {
		final locale = AppLocaleUtils.findDeviceLocale();
		return setLocale(locale);
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_t = _currLocale.translations;

		// force rebuild if TranslationProvider is used
		_translationProviderKey.currentState?.setLocale(_currLocale);

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String rawLocale) {
		final locale = AppLocaleUtils.parse(rawLocale);
		return setLocale(locale);
	}

	/// Gets current locale.
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
	AppLocaleUtils._(); // no constructor

	/// Returns the locale of the device as the enum type.
	/// Fallbacks to base locale.
	static AppLocale findDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			final typedLocale = _selectLocale(deviceLocale);
			if (typedLocale != null) {
				return typedLocale;
			}
		}
		return _baseLocale;
	}

	/// Returns the enum type of the raw locale.
	/// Fallbacks to base locale.
	static AppLocale parse(String rawLocale) {
		return _selectLocale(rawLocale) ?? _baseLocale;
	}
}

// context enums

enum GenderContext {
	male,
	female,
}

// interfaces generated as mixins

mixin PageData2 {
	String get title;
	String? get content => null;
}

// translation instances

late _TranslationsRu _translationsRu = _TranslationsRu.build();
late _TranslationsEn _translationsEn = _TranslationsEn.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {

	/// Gets the translation instance managed by this library.
	/// [TranslationProvider] is using this instance.
	/// The plural resolvers are set via [LocaleSettings].
	_TranslationsRu get translations {
		switch (this) {
			case AppLocale.ru: return _translationsRu;
			case AppLocale.en: return _translationsEn;
		}
	}

	/// Gets a new translation instance.
	/// [LocaleSettings] has no effect here.
	/// Suitable for dependency injection and unit tests.
	///
	/// Usage:
	/// final t = AppLocale.ru.build(); // build
	/// String a = t.my.path; // access
	_TranslationsRu build() {
		switch (this) {
			case AppLocale.ru: return _TranslationsRu.build();
			case AppLocale.en: return _TranslationsEn.build();
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.ru: return 'ru';
			case AppLocale.en: return 'en';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.ru: return const Locale.fromSubtags(languageCode: 'ru');
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'ru': return AppLocale.ru;
			case 'en': return AppLocale.en;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _TranslationsRu translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

// Path: <root>
class _TranslationsRu {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsRu.build();

	late final _TranslationsRu _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsScreensRu screens = _TranslationsScreensRu._(_root);
}

// Path: screens
class _TranslationsScreensRu {
	_TranslationsScreensRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsScreensHomeRu home = _TranslationsScreensHomeRu._(_root);
	late final _TranslationsScreensMessageRu message = _TranslationsScreensMessageRu._(_root);
}

// Path: screens.home
class _TranslationsScreensHomeRu {
	_TranslationsScreensHomeRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	late final _TranslationsScreensHomeHeaderRu header = _TranslationsScreensHomeHeaderRu._(_root);
	late final _TranslationsScreensHomeDrawerRu drawer = _TranslationsScreensHomeDrawerRu._(_root);
	late final _TranslationsScreensHomeAppBarHeadersRu appBarHeaders = _TranslationsScreensHomeAppBarHeadersRu._(_root);
}

// Path: screens.message
class _TranslationsScreensMessageRu {
	_TranslationsScreensMessageRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get add => 'Заметка добавлена';
	String get delete => 'Удалить заметку';
	String get favorites => 'Добавить заметку в избранные';
	late final _TranslationsScreensMessageInfoRu info = _TranslationsScreensMessageInfoRu._(_root);
}

// Path: screens.home.header
class _TranslationsScreensHomeHeaderRu {
	_TranslationsScreensHomeHeaderRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get title => 'Все заметки';
	String get count1 => 'заметка';
	String get count2 => 'заметки';
	String get count3 => 'заметок';
}

// Path: screens.home.drawer
class _TranslationsScreensHomeDrawerRu {
	_TranslationsScreensHomeDrawerRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get element1 => 'Язык';
	String get element2 => 'Все заметки';
	String get element3 => 'Избранное';
}

// Path: screens.home.appBarHeaders
class _TranslationsScreensHomeAppBarHeadersRu {
	_TranslationsScreensHomeAppBarHeadersRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get header1 => 'Поиск';
	String get header2 => 'Избранное';
	String get header3 => 'Название';
}

// Path: screens.message.info
class _TranslationsScreensMessageInfoRu {
	_TranslationsScreensMessageInfoRu._(this._root);

	final _TranslationsRu _root; // ignore: unused_field

	// Translations
	String get count1 => 'символ';
	String get count2 => 'символа';
	String get count3 => 'символов';
	String get actionTrue => 'Да';
	String get creationDate => 'Дата создания';
	String get editedDate => 'Дата редактирования';
	String get notificationDate => 'Дата последнего оповещения';
}

// Path: <root>
class _TranslationsEn extends _TranslationsRu {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEn.build()
		: super.build();

	@override late final _TranslationsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsScreensEn screens = _TranslationsScreensEn._(_root);
}

// Path: screens
class _TranslationsScreensEn extends _TranslationsScreensRu {
	_TranslationsScreensEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsScreensHomeEn home = _TranslationsScreensHomeEn._(_root);
	@override late final _TranslationsScreensMessageEn message = _TranslationsScreensMessageEn._(_root);
}

// Path: screens.home
class _TranslationsScreensHomeEn extends _TranslationsScreensHomeRu {
	_TranslationsScreensHomeEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsScreensHomeHeaderEn header = _TranslationsScreensHomeHeaderEn._(_root);
	@override late final _TranslationsScreensHomeDrawerEn drawer = _TranslationsScreensHomeDrawerEn._(_root);
	@override late final _TranslationsScreensHomeAppBarHeadersEn appBarHeaders = _TranslationsScreensHomeAppBarHeadersEn._(_root);
}

// Path: screens.message
class _TranslationsScreensMessageEn extends _TranslationsScreensMessageRu {
	_TranslationsScreensMessageEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get add => 'Note added';
	@override String get delete => 'Delete note';
	@override String get favorites => 'Add note to favorites';
	@override late final _TranslationsScreensMessageInfoEn info = _TranslationsScreensMessageInfoEn._(_root);
}

// Path: screens.home.header
class _TranslationsScreensHomeHeaderEn extends _TranslationsScreensHomeHeaderRu {
	_TranslationsScreensHomeHeaderEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'All notes';
	@override String get count1 => 'note';
	@override String get count2 => 'notes';
	@override String get count3 => 'notes';
}

// Path: screens.home.drawer
class _TranslationsScreensHomeDrawerEn extends _TranslationsScreensHomeDrawerRu {
	_TranslationsScreensHomeDrawerEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get element1 => 'Language';
	@override String get element2 => 'All notes';
	@override String get element3 => 'Favorites';
}

// Path: screens.home.appBarHeaders
class _TranslationsScreensHomeAppBarHeadersEn extends _TranslationsScreensHomeAppBarHeadersRu {
	_TranslationsScreensHomeAppBarHeadersEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get header1 => 'Search';
	@override String get header2 => 'Favorites';
	@override String get header3 => 'Name';
}

// Path: screens.message.info
class _TranslationsScreensMessageInfoEn extends _TranslationsScreensMessageInfoRu {
	_TranslationsScreensMessageInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get count1 => 'symbol';
	@override String get count2 => 'symbols';
	@override String get count3 => 'symbols';
	@override String get actionTrue => 'Yes';
	@override String get creationDate => 'Date of creation';
	@override String get editedDate => 'Date edited';
	@override String get notificationDate => 'Last notification date';
}
