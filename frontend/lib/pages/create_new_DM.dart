import 'package:chat_app_project/models/Sending_login_credentials_to_API.dart';
import 'package:chat_app_project/pages/Groups_Page.dart';
import 'package:chat_app_project/pages/User_dashboard.dart';
import 'package:chat_app_project/pages/create_account_page.dart';
import 'package:chat_app_project/repeated_colors/repeated_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global_variables.dart';

class create_new_account_DM extends StatefulWidget {
  @override
  _create_new_account_DM createState() => _create_new_account_DM();
}

class _create_new_account_DM extends State<create_new_account_DM> {
  final Group_name_controller = TextEditingController();
  final Password_controller = TextEditingController();
  bool _rememberMe = false;

  void _showDialog_for_create_new_group_failure(BuildContext context,String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!"),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCreateNewDMTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: Group_name_controller,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.group,
                color: Colors.white,
              ),
              hintText: 'Enter User Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildCreateAccountBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          //final List<String> reponse_from_API_for_login = await sendData((Group_name_controller.text).toString(),(Password_controller.text).toString());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Group_Page()));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'CREATE',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFB71C1C),
                      Color(0xFFC62828),
                      Color(0xFFD32F2F),
                      Color(0xFFE53935),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Start new HERMES Direct Message',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildCreateNewDMTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildCreateAccountBtn(),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
