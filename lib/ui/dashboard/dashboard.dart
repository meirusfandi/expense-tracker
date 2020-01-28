import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/CustomShapeClipper.dart';
import 'package:money_tracker/core/database_helper.dart';
import 'package:money_tracker/core/model_db.dart';
import 'package:money_tracker/ui/dashboard/city_service.dart';
import 'package:money_tracker/ui/transaction/transaction.dart';
import 'package:toast/toast.dart';

import 'article_service.dart';

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
  fontFamily: 'Oxygen'
);

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DashboardScreenTopPart(),
            dashboardScreenBottomPart
          ],
        ),
      )
    );
  }
}

class DashboardScreenTopPart extends StatefulWidget {
  @override
  _DashboardScreenTopPartState createState() => _DashboardScreenTopPartState();
}

const TextStyle dropDownLabelStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle dropDownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 16.0);

class _DashboardScreenTopPartState extends State<DashboardScreenTopPart> {

  void openDetail([ModelDB model]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TransactionScreen(
          model: model,
        );
      },
    ).then((_) {
      DatabaseHelper.getPlanning();
    });
  }

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

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerMount = TextEditingController();
  
  void insertData() async {
    DateTime now = DateTime.now();
    String formatDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
    if (_controllerTitle.text.isNotEmpty && _controllerDescription.text.isNotEmpty && _controllerMount.text.isNotEmpty) {
      ModelDB model = ModelDB(
        typeTransaction: "planning",
        title: _controllerTitle.text,
        description: _controllerDescription.text,
        totalMount: int.parse(_controllerMount.text),
        createdAt: formatDate
      );
      await DatabaseHelper.insertData(model);
      Navigator.pop(context);
    }
  }
  var defaultSeletedCity = 0;
  var isFlightSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400, 
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [firstColor, secondColor]
              )
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Welcome back ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Mei Rusfandi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  height: 200,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)
                            ),
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 1
                            )],
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Balance",
                                    style: TextStyle(
                                      color: firstColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.more_vert,
                                    color: firstColor,
                                  )
                                ],
                              ),
                              ChoiceChip(icon: Icons.account_balance_wallet, text: 'Rp 1.000.000'),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)
                            ),
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 1
                            )],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  openTransaction(0);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      height: 64,
                                      width: 64,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        boxShadow: [BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 1,
                                          blurRadius: 1
                                        )],
                                      ),
                                      child: Icon(
                                        Icons.account_balance_wallet,
                                        color: Colors.green,
                                        size: 32,
                                      ),
                                    ),
                                    Text(
                                      'Income',
                                      style: TextStyle(
                                        color: firstColor,
                                        fontSize: 21.0
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  openTransaction(1);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      height: 64,
                                      width: 64,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        boxShadow: [BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 1,
                                          blurRadius: 1
                                        )],
                                      ),
                                      child: Icon(
                                        Icons.store,
                                        color: Colors.red,
                                        size: 32,
                                      ),
                                    ),
                                    Text(
                                      'Expense',
                                      style: TextStyle(
                                        color: firstColor,
                                        fontSize: 21.0
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              
                              InkWell(
                                onTap: () {
                                  openTransaction(2);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      height: 64,
                                      width: 64,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        boxShadow: [BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 1,
                                          blurRadius: 1
                                        )],
                                      ),
                                      child: Icon(
                                        Icons.event,
                                        color: Colors.yellow,
                                        size: 32,
                                      ),
                                    ),
                                    Text(
                                      'Planning',
                                      style: TextStyle(
                                        color: firstColor,
                                        fontSize: 21.0
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}

class ChoiceChip extends StatefulWidget {

  final IconData icon;
  final String text;

  ChoiceChip({this.icon, this.text});

  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20.0,
            color: Colors.orange
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 16.0
            )
          )
        ],
      ),
    );
  }
}

// Progress indicator widget to show loading.
  Widget loadingView() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Loading...'),
        )
      ],
    )
  );

  // View to empty data message
  Widget noDataView(String msg) => Center(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            msg,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8.0,),
          InkWell(
            child: Icon(Icons.refresh, color: Colors.orange,),
            
          )
        ],
      )
    )
  );

var viewAll = TextStyle(color: appTheme.primaryColor, fontSize: 14.0);

var dashboardScreenBottomPart = Column(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Article of the weeks", style: dropDownMenuItemStyle,),
          Spacer(),
          Text("View All", style: viewAll,),
        ],
      ),
    ),
    Container(
      height: 210,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: FutureBuilder(
        future: ArticleService.getArticles(),
        builder: (context, snapshot) {
          final articles = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: {
              return loadingView();
            }
            case ConnectionState.active: {
              break;
            }
            case ConnectionState.none: {
              return noDataView("No connection found.");
            }
            case ConnectionState.done: {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ArticleSection(
                      id: articles[index]["id"],
                      title: articles[index]["title"],
                      content: articles[index]["content"],
                      background: articles[index]["background"],
                      createdAt: articles[index]["createdAt"],
                    );
                  },
                );
              } else {
                return noDataView("No data found.");
              }
            }
          }
        },
      )
    ),
    SizedBox(height: 16,),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Favorite Cities", style: dropDownMenuItemStyle,),
          Spacer(),
          Text("View All", style: viewAll,),
        ],
      ),
    ),
    Container(
      height: 210,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: FutureBuilder(
        future: CityService.getCities(),
        builder: (context, snapshot) {
          final cities = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: {
              return loadingView();
            }
            case ConnectionState.active: {
              break;
            }
            case ConnectionState.none: {
              return noDataView("No connection found.");
            }
            case ConnectionState.done: {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CitySection(
                      id: cities[index]["id"],
                      city: cities[index]["cityName"],
                      images: cities[index]["cityImage"],
                      price: cities[index]["price"]
                    );
                  },
                );
              } else {
                return noDataView("No data found.");
              }
            }
          }
        },
      )
    ),
    SizedBox(height: 24),
  ],
);

class ArticleSection extends StatelessWidget {
  final int id;
  final String title, content, background, createdAt;

  ArticleSection({this.id, this.title, this.content, this.background, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Stack(
          children: <Widget>[
            Container(
              height: 210,
              width: 120,
              child: Image.network(background, fit: BoxFit.cover,),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              width: 160,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black, Colors.black.withOpacity(0.1)
                    ]
                  )
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 10.0,
              right: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.0), maxLines: 1,),
                  Text(createdAt, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 10.0), maxLines: 1,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class CitySection extends StatelessWidget {
  final int id, price;
  final String city, images;

  CitySection({this.id, this.city, this.images, this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Stack(
          children: <Widget>[
            Container(
              height: 210,
              width: 120,
              child: Image.network(images, fit: BoxFit.cover,),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              width: 160,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black, Colors.black.withOpacity(0.1)
                    ]
                  )
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 10.0,
              right: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(city, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.0), maxLines: 1,),
                  Text("Rp ${price.toString()}", style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 10.0), maxLines: 1,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}