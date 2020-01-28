import 'package:flutter/material.dart';
import 'package:money_tracker/core/database_helper.dart';
import 'package:money_tracker/core/model_db.dart';
import 'package:money_tracker/ui/transaction/transaction.dart';

class PlanningScreen extends StatefulWidget {
  PlanningScreen({Key key}) : super(key: key);

  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
  fontFamily: 'Oxygen'
);

class _PlanningScreenState extends State<PlanningScreen> {

  List<ModelDB> listTransaction = List();

  void getAll() async{
    List<ModelDB> models = await DatabaseHelper.getPlanning();
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
      builder: (BuildContext context) {
        return TransactionScreen(
          position: position,
          model: model,
        );
      },
    ).then((_) {
      DatabaseHelper.getPlanning();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List planning"),
      ),
      body: ListView.separated(
        itemCount: listTransaction.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              openDetail(2, listTransaction[index]);
            },
            leading: Icon(
              Icons.event,
              color: Colors.black,
            ),
            trailing: Text(
              "Rp ${listTransaction[index].totalMount}"
            ),
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
      ),
    );
  }
}