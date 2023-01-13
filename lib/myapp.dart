import 'package:flutter/material.dart';
import 'package:trainee_links_apk/page/home_page.dart';
import 'package:trainee_links_apk/page/link_add_edit_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trainee Links',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Trainee Links'),
        '/add-link': (context) => const LinkAddEditPage(title: 'Add Links'),
        '/edit-link': (context) => const LinkAddEditPage(title: 'Update Links'),
      },
    );
  }
}
