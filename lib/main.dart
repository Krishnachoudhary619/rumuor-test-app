import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'firebase/firebase_options_dev.dart' as firebase_dev;

import 'app.dart';
import 'core/constants/flavor.dart';
import 'data/source/local/shar_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: platform);
  final securePref = await SharedPreferences.getInstance();
  final pref = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        secureSharedPrefProvider.overrideWithValue(securePref),
      ],
      child: const App(),
    ),
  );
}

FirebaseOptions get platform {
  final flavor = Flavor.values.firstWhere(
    (element) => element.name == const String.fromEnvironment('FLAVOR'),
  );
  return switch (flavor) {
    Flavor.development => firebase_dev.DefaultFirebaseOptions.currentPlatform,
    Flavor.staging => throw UnimplementedError(),
    Flavor.production => throw UnimplementedError(),
  };
}
