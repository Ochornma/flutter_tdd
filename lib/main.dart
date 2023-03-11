import 'package:clean_architecure_course/feature/number_trival/presentation/pages/number_trivial_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;


void main() async {
  //we are using await the di is a future but if not it should be
  // di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl.allReady();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.green.shade500, // Your accent color
          primary: Colors.green.shade800
        ),
      ),
      home: NumberTriviaPage(),
    );
  }
}



