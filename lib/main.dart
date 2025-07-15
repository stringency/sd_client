import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sd_client/const.dart';
import 'package:sd_client/root_page.dart';
import 'package:sd_client/login_page.dart'; // 引入登录页

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.isGranted; // 确保权限插件初始化
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');

  runApp(MyApp(isLoggedIn: token != null));
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..findProxy = (uri) {
//         return "PROXY 10.105.164.201:7897;";
//       }
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI生图',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: BarThemeColor,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      home: isLoggedIn ? const RootPage() : const LoginPage(),
      routes: {
        '/login': (context) => LoginPage(), // 确保这里有一个 LoginPage 组件
      },
    );
  }
}
