import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadster/screens/login_screens/email_verify.dart';
import 'package:roadster/screens/login_screens/login.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  canvasColor: Colors.transparent,
  chipTheme: const ChipThemeData(
    showCheckmark: false,
  ),
  textTheme: TextTheme(
    headlineMedium: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18),
    headlineSmall: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
    bodyLarge: GoogleFonts.montserrat(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.montserrat(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.montserrat(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: messengerKey,
        theme: theme,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Verify();
              } else {
                return Login();
              } //login
            },
          ),
        )),
  ));
}
