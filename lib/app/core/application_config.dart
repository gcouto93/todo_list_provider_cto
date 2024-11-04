import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../../firebase_options.dart';

class ApplicationConfig {
  Future<void> configureApp()async{
    WidgetsFlutterBinding.ensureInitialized();
    await _firebaseCoreConfig();
  }

  Future<void> _firebaseCoreConfig() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}