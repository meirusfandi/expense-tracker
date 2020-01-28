import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/core/database_helper.dart';
import 'package:money_tracker/core/model_db.dart';

class TransactionScreen extends StatefulWidget {

  final int position;
  final ModelDB model;

  TransactionScreen({this.position, this.model});
  
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

const TextStyle dropDownLabelStyle = TextStyle(color: Colors.black, fontSize: 16.0);
const TextStyle dropDownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 16.0);

class _TransactionScreenState extends State<TransactionScreen> {

  String pageTitle;
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerMount = TextEditingController();
  List<String> transactions = ['income', 'expense', 'planning'];

  int defaultSeletedTransaction = 0; 
  
  void insertData() async {
    DateTime now = DateTime.now();
    String formatDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    if (_controllerTitle.text.isNotEmpty && _controllerDescription.text.isNotEmpty && _controllerMount.text.isNotEmpty) {
      ModelDB model = ModelDB(
        title: _controllerTitle.text,
        typeTransaction: transactions[defaultSeletedTransaction],
        description: _controllerDescription.text,
        totalMount: int.parse(_controllerMount.text),
        createdAt: formatDate
      );
      await DatabaseHelper.insertData(model);
      Navigator.pop(context);
    }
  }

  void updateData() async {
    if (_controllerTitle.text.isNotEmpty && _controllerDescription.text.isNotEmpty && _controllerMount.text.isNotEmpty) {
      ModelDB model = ModelDB(
        transactionId: widget.model.transactionId,
        typeTransaction: transactions[defaultSeletedTransaction],
        title: _controllerTitle.text,
        description: _controllerDescription.text,
        totalMount: int.parse(_controllerMount.text)
      );
      await DatabaseHelper.update(model);
      Navigator.pop(context);
    }
  }

  void deleteData() async {
    await DatabaseHelper.delete(widget.model.transactionId);
    Navigator.pop(context);
  }

  void cancel() async {
    Navigator.pop(context);
  }

  @override
  void initState() {
    if (widget.position != defaultSeletedTransaction) {
      defaultSeletedTransaction = widget.position;
    }

    if (widget.model != null) {
      _controllerTitle.text = widget.model.title;
      _controllerDescription.text = widget.model.description;
      _controllerMount.text = widget.model.totalMount.toString();
      pageTitle = "UPDATE OR DELETE DATA";
    } else {
      pageTitle = "SAVE NEW DATA";
    }
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: AlertDialog(
        title: Text(pageTitle),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              PopupMenuButton(
                onSelected: (index) {
                  setState(() {
                    defaultSeletedTransaction = index;
                  });
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 1,
                        spreadRadius: 1
                      )
                    ]
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        transactions[defaultSeletedTransaction], 
                        style: dropDownLabelStyle
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black
                      )
                    ],
                  ),
                ),
                itemBuilder: (context) => <PopupMenuItem<int>> [
                  PopupMenuItem(
                    child: Text(
                      transactions[0],
                      style: dropDownMenuItemStyle,
                    ),
                    value: 0
                  ),
                  PopupMenuItem(
                    child: Text(
                      transactions[1],
                      style: dropDownMenuItemStyle
                    ),
                    value: 1
                  ),
                  PopupMenuItem(
                    child: Text(
                      transactions[2],
                      style: dropDownMenuItemStyle
                    ),
                    value: 2
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _controllerTitle,
                decoration: InputDecoration(
                  labelText: "Enter title",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 4.0,),
              TextFormField(
                controller: _controllerDescription,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter description"
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 4.0,),
              TextFormField(
                controller: _controllerMount,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Mount"
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: actionButton(),
      ),
    );
  }

  List<Widget> actionButton() {
    if (widget.model != null) {
      return [
        FlatButton(child: Text("Update"), onPressed: updateData,),
        FlatButton(child: Text("Delete"), onPressed: deleteData,),
        FlatButton(child: Text("Back"), onPressed: cancel,)
      ];
    } else {
      return [
        FlatButton(child: Text("Save"), onPressed: insertData,),
        FlatButton(child: Text("Back"), onPressed: cancel,)
      ];
    }
  }
}