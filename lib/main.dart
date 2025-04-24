import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:themealdb/core/theme/app_theme.dart';
import 'package:themealdb/features/recipes/presentation/pages/home_page.dart';
import 'package:themealdb/core/utils/app_localizations.dart';
import 'package:themealdb/features/recipes/presentation/bloc/home_bloc.dart';
import 'package:themealdb/features/recipes/presentation/bloc/home_event.dart';
import 'package:themealdb/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Recetas',
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('es', 'MX'),
        ],
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.orange),
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            titleMedium: TextStyle(fontSize: 18),
            bodyMedium: TextStyle(fontSize: 16),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode ||
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: BlocProvider(
          create: (_) => di.sl<HomeBloc>()..add(const FetchMeals()),
          child: const HomePage(),
        ),
      );
    });
  }
}
