import 'package:flutter/material.dart';
import './ui/utils/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import './app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(Casanova());
}
