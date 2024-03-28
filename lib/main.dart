import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sheoapp/controller/favourite_list_provider.dart';
import 'package:sheoapp/controller/main_page_provider.dart';
import 'package:sheoapp/controller/product_page_provider.dart';
import 'package:sheoapp/views/ui/mainScreen/main_screen.dart';

import 'firebase_options.dart';
import 'views/shared/snake_bar.dart';
import 'views/ui/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox("Cart_box");
  await Hive.openBox("Fav_box");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MainPageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductPageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => FavouriteListProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (snapshot.hasError) {
            return showSnackBar(context, "Something went wrong");
          } else if (snapshot.hasData) {
            return const MainScreen();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
