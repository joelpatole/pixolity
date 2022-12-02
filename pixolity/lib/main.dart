import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixolity/providers/user_provider.dart';
import 'package:pixolity/responsive/mobile_screen_layout.dart';
import 'package:pixolity/responsive/responsive_layout_screen.dart';
import 'package:pixolity/responsive/web_screen_layout.dart';
import 'package:pixolity/screens/login_screen.dart';
import 'package:pixolity/screens/signup_screen.dart';
import 'package:pixolity/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyAP-n4sydygDab3ehCAbHK-2B7C_yEEFU0',
      appId: "1:249694803504:web:349fadc2b3e30840cdbff5",
      messagingSenderId: "249694803504",
      projectId: "instagram-tut-a3ba7",
      storageBucket: "instagram-tut-a3ba7.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'pixolity',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        //home: const ResponsiveLayout(
        //  mobileScreenLayout: MobileScreenLayout(),
        //  webScreenLayout: WebScreenLayout(),
        //),

        // FirebaseAuth.instance.idTokenChanges() => every user has a unique token that firebase gives , so when this token changes this method will run
        // FirebaseAuth.instance.userChanges() => when user wants to change its email or password
        // FirebaseAuth.instance.authStateChanges() =>
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          }),
        ),
      ),
    );
  }
}
