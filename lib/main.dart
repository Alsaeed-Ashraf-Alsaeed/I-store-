import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/methods.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const IStore());
}

class IStore extends StatelessWidget {
  const IStore({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 800),
        builder: (context, widget) {
          return  MaterialApp(
            theme: ThemeData(
              textTheme: TextTheme()
            ),
            debugShowCheckedModeBanner: false,
            title: 'SidesShop',
            onGenerateRoute: MyRouter.onRouteGenerate,
          );
        });
  }
}
