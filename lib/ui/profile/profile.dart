import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../../CustomShapeClipper.dart';
import 'profile_model.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
  fontFamily: 'Oxygen'
);

Future<ProfileModel> getProfile() async {
  String profileUrl = "https://my-json-server.typicode.com/meirusfandi/api-json/profile";
  final response = await http.get(profileUrl);
  try {
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      return ProfileModel.fromJSON(json);
    } else {
      throw Exception('error code: ${response.statusCode}');
    }
  } catch (e) {
    print(e.toString());
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileScreenTopPart(),
              SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.0,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        showToast('Edit Profile selected. Menu Unavailable!', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      leading: Icon(
                        Icons.person,
                        color: firstColor,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 4.0,
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: firstColor, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: firstColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.0,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        showToast('My Wallets Menu Not Available now !', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      leading: Icon(
                        Icons.account_balance_wallet,
                        color: firstColor,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 4.0,
                        ),
                        child: Text(
                          'My Wallets',
                          style: TextStyle(
                            color: firstColor, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: firstColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.0,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        showToast('Terms of Use Menu Not Available now !', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      leading: Icon(
                        Icons.assessment,
                        color: firstColor,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 4.0,
                        ),
                        child: Text(
                          'Terms of Use',
                          style: TextStyle(
                            color: firstColor, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: firstColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.0,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        showToast('FAQ Menu Not Available now !', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      leading: Icon(
                        Icons.help,
                        color: firstColor,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 4.0,
                        ),
                        child: Text(
                          'FAQ',
                          style: TextStyle(
                            color: firstColor, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: firstColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.0,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        showToast('Rate Menu Not Available now !', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      leading: Icon(
                        Icons.star,
                        color: firstColor,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 4.0,
                        ),
                        child: Text(
                          'Rate on Play Store',
                          style: TextStyle(
                            color: firstColor, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: firstColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.0,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        showToast('Privacy Policy Menu Not Available now !', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      leading: Icon(
                        Icons.security,
                        color: firstColor,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 4.0,
                        ),
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: firstColor, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: firstColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.0,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        showToast('About Apps Menu Not Available now !', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      leading: Icon(
                        Icons.info,
                        color: firstColor,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 4.0,
                        ),
                        child: Text(
                          'About Apps',
                          style: TextStyle(
                            color: firstColor, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: firstColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2.0,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        showToast('Logout Menu Not Available now !', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      leading: Icon(
                        Icons.power_settings_new,
                        color: firstColor,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 4.0,
                        ),
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            color: firstColor, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32,)
                ],
              ),
            ]
          ),
        ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}

class ProfileScreenTopPart extends StatefulWidget {
  @override
  _ProfileScreenTopPartState createState() => _ProfileScreenTopPartState();
}

const TextStyle dropDownLabelStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle dropDownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 16.0);

class _ProfileScreenTopPartState extends State<ProfileScreenTopPart> {

  var defaultSeletedCity = 0;
  var isFlightSelected = true;
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
            child: FutureBuilder<ProfileModel>(
              future: getProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ProfileModel data = snapshot.data;
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.white
                            ),
                            Text(
                              ' Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              child: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              onTap: () {
                                showToast('Setting Menu Not Available now !', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(data.photo)
                          )
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data.name,
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ChoiceChip(icon: Icons.email, text: data.email),
                          // SizedBox(width: 10.0),
                          ChoiceChip(icon: Icons.phone_android, text: data.phone),
                        ],
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.white
                            ),
                            Text(
                              ' Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              child: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              onTap: () {
                                showToast('Setting Menu Not Available now !', duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("https://i.ytimg.com/vi/yt0CE-bN--g/hqdefault.jpg")
                          )
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Name of User',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ChoiceChip(icon: Icons.email, text: 'sample@gmail.com'),
                          ChoiceChip(icon: Icons.phone_android, text: '08228XXXXXX'),
                        ],
                      )
                    ],
                  );
                }
              },
            )
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
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20.0,
            color: Colors.white
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0
            )
          )
        ],
      ),
    );
  }
}
