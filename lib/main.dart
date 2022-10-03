import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_hive_flutter/data/model/note_entity.dart';
import 'package:note_app_hive_flutter/presentation/view/note_list_screen.dart';
import 'package:note_app_hive_flutter/presentation/viewmodel/note_viewmodel.dart';
import 'package:provider/provider.dart';

import 'common/constants/string_constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteEntityAdapter());
  await Hive.openBox<NoteEntity>('note_entity');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NoteViewModel())],
      child: MaterialApp(
        title: noteAppCleanArch,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NoteListScreen(),
      ),
    );
  }
}
