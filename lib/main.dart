import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'package:tech_test_atto/injection.dart' as di;
import 'package:tech_test_atto/presentation/pages/page1_page.dart';
import 'package:tech_test_atto/presentation/provider/page1_notifier.dart';
import 'package:tech_test_atto/presentation/provider/page2_notifier.dart';
import 'package:tech_test_atto/router.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('env');
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<Page1Notifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<Page2Notifier>(),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        initialRoute: Page1.routeName,
        onGenerateRoute: router.Router.onGenerateRoute,
      ),
    );
  }
}
