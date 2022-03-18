import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/model/contact_list.dart';
import 'package:untitled/pages/beneficiary_page.dart';
import 'package:untitled/pages/recipients_page.dart';
import 'package:untitled/service/hive.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveService.HIVE_BOX);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          RecipientsPage.recipients_name : (context) => const RecipientsPage(),
        },
        home: const BeneficialPage(),
      ),
    );
  }
}
