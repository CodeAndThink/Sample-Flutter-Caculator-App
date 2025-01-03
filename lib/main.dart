import 'package:caculator_app/manager/data_manager.dart';
import 'package:caculator_app/manager/setting_manager.dart';
import 'package:caculator_app/theme/theme.dart';
import 'package:caculator_app/views/home_screen.dart';
import 'package:caculator_app/views/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            HomeViewModel(SettingManager.shared, DataManager.shared),
        builder: (context, child) {
          return MaterialApp(
            theme: context.watch<HomeViewModel>().isDarkMode
                ? AppTheme.darkTheme
                : AppTheme.lightTheme,
            home: const Scaffold(
              body: Center(
                child: HomeScreen(),
              ),
            ),
          );
        });
  }
}
