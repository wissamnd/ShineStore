import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import '../logic/storeState.dart';
import 'package:flutter_shop/widgets/addressPreview.dart';
import '../widgets/itemPreview.dart';
import 'package:flutter_shop/logic/userState.dart';
import 'package:flutter_shop/screens/editProfileInfo.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  child: Text("EDIT"),
                )
              ],
              primary: true,
              elevation: 0,
              expandedHeight: 400.0,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(UserState.getfullName(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10, left: 8),
              child: _heading(context: context, text: "Contact Information"),
            ),
            _profilePreview(context,
                "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80"),
            (StoreState.favorites().length == 0)
                ? Container()
                : Padding(
                    child: _heading(context: context, text: "Favorites"),
                    padding:
                        const EdgeInsets.only(bottom: 20, top: 60, left: 8),
                  ),
            _favoritesHorizontalListView(
                context, StoreState.favorites().length == 0),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 60, left: 8),
              child: _heading(context: context, text: "Address Information"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AddressPreview(
                icon: Icons.local_shipping,
                iconText: "Shipping Address",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddressPreview(
                icon: Icons.payment,
                iconText: "Billing Address",
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            )
          ],
        ),
      ),
    );
  }

  Widget _profilePreview(BuildContext context, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        ListTile(
          leading: Icon(Icons.mail),
          title: Text("caroline@mail.com"),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text("+961 03 555 444"),
        ),
      ],
    );
  }

  Widget _heading({BuildContext context, String text}) {
    return Text(
      text,
      style: TextStyle(fontSize: 20),
    );
  }

  Widget _favoritesHorizontalListView(context, bool isListempty) {
    return (isListempty)
        ? Container()
        : Container(
            height: 250,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: StoreState.favorites().length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var productId = StoreState.favorites()[index];
                  return Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Container(
                          width: 190,
                          child: ItemPreview(
                            productId: productId,
                          )),
                      Padding(
                        padding: EdgeInsets.all(4),
                      )
                    ],
                  );
                },
              ),
            ),
          );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
