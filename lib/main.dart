import 'package:colomer_dental/src/pages/addEvent.dart';
import 'package:colomer_dental/src/pages/homePage.dart';
import 'package:colomer_dental/src/pages/login.dart';
import 'package:colomer_dental/src/pages/userPage.dart';
import 'package:colomer_dental/src/providers/providerPage.dart';
import 'package:colomer_dental/src/sharedPreferences/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final pref = PreferenciasUsuario();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await pref.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderPage(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Colomer dental',
        initialRoute: pref.pagePral,
        routes: {
          '/news': (BuildContext context) => HomePage(),
          '/bottom': (BuildContext context) => ButtomAppBarNab(),
          '/login': (BuildContext cntext) => LoginPage(),
          '/add': (BuildContext cntext) => AddEventPage(),
        },
      ),
    );
  }
}

class ButtomAppBarNab extends StatefulWidget {
  ButtomAppBarNab({Key key}) : super(key: key);

  @override
  _ButtomAppBarNabState createState() => _ButtomAppBarNabState();
}

class _ButtomAppBarNabState extends State<ButtomAppBarNab> {
  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<ProviderPage>(context);
    List<Widget> paginas = [HomePage(), UserPage()];
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.calendar_today),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageProvider.page,
            onTap: (value) => pageProvider.page = value,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.new_releases), title: Text("Noticias")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text("Usuario"))
            ]),
        body: paginas[pageProvider.page]);
  }
}
