

import 'package:flutter/material.dart';
import 'package:flutter_shop/logic/userState.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close,size: 25,color: Colors.black,),
          onPressed: (){
            Navigator.of(context).pop();
          },),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          MaterialButton(
            child: Text("SAVE"),
            onPressed: (){
              if(_firstNameController.text.length!=0){
                UserState.setFirstName(_firstNameController.text);
              }
              if(_lastNameController.text.length!=0){
                UserState.setLastName(_lastNameController.text);
              }
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 60),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    helperText: "Change your firstname",
                    border: OutlineInputBorder(),
                    labelText: UserState.getFirstName,
                  ),
              controller: _firstNameController,
                ),
                Padding(padding: EdgeInsets.all(20),),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    helperText: "Change your lastName",
                    border: OutlineInputBorder(),
                    labelText: UserState.getLastName,
                  ),
            
                ),
              ],
              
            )
          )
        ],
      ),
      
    );
  }
}