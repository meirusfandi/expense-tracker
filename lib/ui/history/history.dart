import 'package:flutter/material.dart';
import 'package:money_tracker/core/database_helper.dart';
import 'package:money_tracker/core/model_db.dart';
import 'package:money_tracker/ui/transaction/transaction.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
  fontFamily: 'Oxygen'
);

class _HistoryScreenState extends State<HistoryScreen> {

  List<ModelDB> listTransaction = List();

  void getAll() async{
    List<ModelDB> models = await DatabaseHelper.getAll();
    setState(() {
      if (models != null) {
        listTransaction = models;
      } else {
        listTransaction = List();
      }
    });
  }

  void get([ModelDB model]) {
    showDialog(
      context: context,
      builder: (context) {
        return TransactionScreen(
          model: model,
        );
      },
    ).then((_){
      getAll();
    });
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  void openDetail([int position, ModelDB model]) {
    showDialog(
      context: context,
      builder: (context) {
        return TransactionScreen(
          position: position,
          model: model,
        );
      }
    ).then((_) {
      DatabaseHelper.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: ListView.separated(
        itemCount: listTransaction.length,
        itemBuilder: (context, index) {
          var icon;
          var color;
          var position;
          if (listTransaction[index].typeTransaction == "income") {
            color = Colors.green;
            icon = Icons.account_balance_wallet;
            position = 0;
          } else if (listTransaction[index].typeTransaction == "expense") {
            color = Colors.red;
            icon = Icons.store;
            position = 1;
          }
          return ListTile(
            onTap: () {
              openDetail(position, listTransaction[index]);
            },
            leading: Icon(
              icon,
              color: color,
            ),
            trailing: Text("Rp ${listTransaction[index].totalMount}"),
            title: Text(
              listTransaction[index].title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold
              ),
              maxLines: 1,
            ),
            subtitle: Text(
              listTransaction[index].description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.normal
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      )
    );
  }
}
