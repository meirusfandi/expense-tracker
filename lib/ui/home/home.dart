import 'package:flutter/material.dart';
import 'package:money_tracker/core/database_helper.dart';
import 'package:money_tracker/core/model_db.dart';
import 'package:money_tracker/ui/dashboard/dashboard.dart';
import 'package:money_tracker/ui/history/history.dart';
import 'package:money_tracker/ui/planning/planning.dart';
import 'package:money_tracker/ui/profile/profile.dart';
import 'package:money_tracker/ui/transaction/transaction.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
  fontFamily: 'Oxygen'
);

class _HomeScreenState extends State<HomeScreen> {

   // set properties
  int _currentIndex = 0;
  final List<Widget> _children = [
        DashboardScreen(),
        HistoryScreen(),
        PlanningScreen(),
        ProfileScreen()
  ];

  void openTransaction([int position, ModelDB model]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TransactionScreen(
          position: position,
          model: model,
        );
      },
    ).then((_) {
      DatabaseHelper.getAll();
    });
  }
  
  // set default / active tab
  Widget _currentScreen = DashboardScreen();
  final PageStorageBucket _bucket = PageStorageBucket();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: PageStorage(
        bucket: _bucket,
        child: _currentScreen,
      ),

      // floating action bar
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.repeat,
          color: firstColor,
          size: 32,
        ),
        backgroundColor: Colors.white,
        onPressed: (){
          openTransaction(0);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    _currentScreen = DashboardScreen();
                    _currentIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home, 
                      color: _currentIndex == 0 ? appTheme.primaryColor : Colors.grey,
                    ),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: _currentIndex == 0 ? appTheme.primaryColor : Colors.grey,
                      ) 
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    _currentScreen = HistoryScreen();
                    _currentIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.history, 
                      color: _currentIndex == 1 ? appTheme.primaryColor : Colors.grey,
                    ),
                    Text(
                      'History',
                      style: TextStyle(
                        color: _currentIndex == 1 ? appTheme.primaryColor : Colors.grey,
                      ) 
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    _currentScreen = PlanningScreen();
                    _currentIndex = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.event,
                      color: _currentIndex == 2 ? appTheme.primaryColor : Colors.grey,
                      size: 32,
                    ),
                    Text(
                      'Planning',
                      style: TextStyle(
                        color: _currentIndex == 2 ? appTheme.primaryColor : Colors.grey,
                      ) 
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    _currentScreen = ProfileScreen();
                    _currentIndex = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person, 
                      color: _currentIndex == 3 ? appTheme.primaryColor : Colors.grey,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: _currentIndex == 3 ? appTheme.primaryColor : Colors.grey,
                      ) 
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}