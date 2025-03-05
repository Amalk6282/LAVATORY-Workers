import 'package:flutter/material.dart';
import 'package:lacatory_workers/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0eGRqbnZibW9obmhzdnBsaGZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI4NTczNTUsImV4cCI6MjA0ODQzMzM1NX0.DJoD6XNa-GIyeVmDcMbgoxXL4OeNtozBUIpnf185mTg',
    url: 'https://wtxdjnvbmohnhsvplhft.supabase.co',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: LoginPage(),
    );
  }
}
