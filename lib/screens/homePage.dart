import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shop/screens/profile.dart';
import 'package:flutter_shop/widgets/itemPreview.dart';
import 'package:flutter_shop/logic/constants.dart';
import 'package:flutter_shop/screens/cart.dart';
import 'package:flutter_shop/logic/storeState.dart';
import 'package:flutter_shop/appAnimation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAllPressed = true;
  bool isProductPressed = false;
  bool iscartEmpty;
  bool isCategoryPressed = false;
  bool isSortPressed = false;
  List<String> _products;

  Widget _selector() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isAllPressed = true;
                    isProductPressed = false;
                    isCategoryPressed = false;
                    if(isSortPressed){
                      _products = StoreState.sortPriceFromLowtoHigh(PRODUCTS.keys.toList());
                    }else{
                      _products = StoreState.shuffleProducts(PRODUCTS.keys.toList());
                    }
                  });
                },
                child: Text(
                  "All",
                  style: Theme.of(context).textTheme.display1.apply(
                      color: (isAllPressed) ? Colors.black87 : Colors.black12),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      isProductPressed = true;
                      isAllPressed = false;
                      isCategoryPressed = false;
                      _products = StoreState.sortPriceFromLowtoHigh(PRODUCTS.keys.toList());
                    });
                  },
                  child: Text(
                    "Products",
                    style: Theme.of(context).textTheme.display1.apply(
                        color: (isProductPressed)
                            ? Colors.black87
                            : Colors.black12),
                  )),
            ],
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.blueGrey[50],
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new ListTile(
                            trailing:(isSortPressed)?Icon(Icons.check):Text(""),
                            leading: Icon(Icons.attach_money),
                            title: Text('From low to high'),
                            onTap: () {
                              if (isSortPressed) {
                                setState(() {
                                  isSortPressed = false;
                                  _products = StoreState.shuffleProducts(_products);
                                });
                              } else {
                                setState(() {
                                  isSortPressed = true;
                                  _products = StoreState.sortPriceFromLowtoHigh(_products);
                                });
                              }
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  context: context);
            },
            child: Column(
              children: <Widget>[
                Text("Sort Items"),
                Padding(
                  padding: EdgeInsets.all(3.0),
                ),
                Container(
                  width: 60,
                  height: 1,
                  color: Colors.black,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listOfItems(list) {
    int second = (list.length) - (list.length / 2).floor();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            children: List.generate((list.length / 2).round(), (index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: ItemPreview(
                  productId: list[index],
                ),
              );
            }),
          ),
        ),
        Expanded(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
            ),
            Column(
              children: List.generate((list.length / 2).floor(), (index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ItemPreview(
                    productId: list[index + second],
                  ),
                );
              }),
            ),
          ],
        )),
      ],
    );
  }

  @override
  void initState() {
    _products = StoreState.shuffleProducts(PRODUCTS.keys.toList());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    iscartEmpty = StoreState.getCart().isEmpty;
    return Scaffold(
        body: ListView(
      children: <Widget>[
        TopBar(
          isCartEmpty: iscartEmpty,
        ),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        _selector(),
        (isAllPressed|| isCategoryPressed)?_listOfItems(_products):Container(),
        (isProductPressed && !isCategoryPressed)?productCategories():Container(),
        Padding(
          padding: EdgeInsets.all(10),
        )
      ],
    ));
  }

  Widget productCategories(){
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.smartphone),
          title: Text("Phones"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            setState(() {
              isCategoryPressed = true;
              _products = StoreState.getPhones(_products,'Phones');
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.tablet),
          title: Text("Tablets"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            setState(() {
              isCategoryPressed = true;
              _products = StoreState.getPhones(_products,'Tablets');
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.laptop),
          title: Text("Laptops"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            setState(() {
              isCategoryPressed = true;
              _products = StoreState.getPhones(_products,'Laptops');
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.watch),
          title: Text("Smartwatches"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            setState(() {
              isCategoryPressed = true;
              _products = StoreState.getPhones(_products,'Smartwatches');
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Connected Home"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            setState(() {
              isCategoryPressed = true;
              _products = StoreState.getPhones(_products,'Connected Home');
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.headset),
          title: Text("Accessories"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
             setState(() {
              isCategoryPressed = true;
              _products = StoreState.getPhones(_products,'Accessories');
            });
          },
        ),
        

      ],);
  }
}



class TopBar extends StatefulWidget {
  final isCartEmpty;

  const TopBar({Key key, @required this.isCartEmpty}) : super(key: key);
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.blueGrey[50],
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              color: Colors.indigo,
                            ),
                            title: Text('Account'),
                            onTap: () {
                              Navigator.push(
                                  context, SlideUpRoute(page: Profile()));
                            },
                          ),
                          new ListTile(
                            leading: Icon(
                              Icons.local_shipping,
                              color: Colors.green,
                            ),
                            title: Text('Shipments'),
                          ),
                        ],
                      ),
                    );
                  },
                  context: context);
            },
            child: CircleAvatar(
              radius: 20.0,
              child: ClipOval(
                  child: Image.network(
                      "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover)),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            "Shine Stores",
            style: Theme.of(context).textTheme.title,
          ),
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context, SlideRightRoute(page: Cart()));
                },
              ),
              (!widget.isCartEmpty)
                  ? ClipOval(
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        height: 10.0, // height of the button
                        width: 10.0, // width of the button
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, -0.05),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}

