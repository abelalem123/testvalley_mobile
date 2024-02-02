import 'package:flutter/material.dart';
import 'package:testvalleychatapp/homepage.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SendbirdChat.init(appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
