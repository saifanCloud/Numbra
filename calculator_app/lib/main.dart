import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/local/shared_preferences_datasource.dart';
import 'data/repositories/calculation_repository.dart';
import 'domain/repositories/i_calculation_repository.dart';
import 'domain/usecases/add_calculation_usecase.dart';
import 'domain/usecases/get_calculation_history_usecase.dart';
import 'domain/usecases/clear_calculation_history_usecase.dart';
import 'presentation/controllers/calculator_controller.dart';
import 'presentation/pages/calculator_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  final datasource = SharedPreferencesDatasource(sharedPreferences);
  final repository = CalculationRepository(datasource) as ICalculationRepository;
  
  final addCalculationUseCase = AddCalculationUseCase(repository);
  final getHistoryUseCase = GetCalculationHistoryUseCase(repository);
  final clearHistoryUseCase = ClearCalculationHistoryUseCase(repository);
  
  final controller = CalculatorController(
    addCalculationUseCase: addCalculationUseCase,
    getHistoryUseCase: getHistoryUseCase,
    clearHistoryUseCase: clearHistoryUseCase,
  );
  
  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {
  final CalculatorController controller;
  
  const MyApp({
    super.key,
    required this.controller,
  });
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: CalculatorPage(controller: controller),
    );
  }
}