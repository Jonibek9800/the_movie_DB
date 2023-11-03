import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widgets/app/my_app.dart';
import 'package:themoviedb/widgets/app/my_app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appModel = MyAppModel();
  appModel.checkAuth();
  final app = MultiProvider(providers: [
    ChangeNotifierProvider<MyAppModel>.value(
        value: MyAppModel())
  ], child: const MyApp());
  runApp(app);
}


