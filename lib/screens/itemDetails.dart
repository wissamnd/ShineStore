import 'package:flutter/material.dart';
import 'package:flutter_shop/logic/storeState.dart';
import 'package:flutter_shop/screens/cart.dart';

class ItemDetials extends StatefulWidget {
  final String productName;
  final double productPrice;
  final listofItemImages;
  final listofItemDescriptions;
  final listItemSpecifications;
  final productId;

  const ItemDetials(
      {Key key,
      this.productName,
      this.productPrice,
      this.listofItemImages,
      this.listofItemDescriptions,
      this.listItemSpecifications,
      this.productId})
      : super(key: key);
  @override
  _ItemDetialsState createState() => _ItemDetialsState();
}

class _ItemDetialsState extends State<ItemDetials> {
  bool isFavorite;
  int currentImage = 1;
  @override
  void initState() {
    isFavorite = StoreState.isFavorite(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: new Builder(
          builder: (BuildContext context) {
            return FloatingActionButton.extended(
              label: Row(
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  Text("ADD TO CART")
                ],
              ),
              onPressed: () {
                StoreState.addToCart(widget.productId);
                final snackBar = SnackBar(
                  backgroundColor: Colors.white,
                  content: Text(
                    'Item is added to cart!',
                    style: TextStyle(color: Colors.black),
                  ),
                  action: SnackBarAction(
                    label: 'Go to cart',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                  ),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              },
            );
          },
        ),
        body: ListView(
          children: <Widget>[
            TopBar(
              isFavorite: isFavorite,
              productID: widget.productId,
            ),
            Container(
              color: Colors.blueGrey[50],
              height: 350,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: ClipOval(
                      child: Container(
                        color: Colors.white,
                        height: 250.0, // height of the button
                        width: 250.0, // width of the button
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: GestureDetector(
                        onTap: () {
                          if (currentImage <
                              (widget.listofItemImages.length) - 1) {
                            setState(() {
                              currentImage++;
                            });
                          } else {
                            setState(() {
                              currentImage = 0;
                            });
                          }
                        },
                        child:
                            Image.asset(widget.listofItemImages[currentImage])),
                    width: 250,
                    height: 250,
                  ),
                  Positioned(
                    bottom: 30,
                    child: Row(
                      children: <Widget>[
                        ClipOval(
                          child: Container(
                            color: (currentImage == 0)
                                ? Colors.black
                                : Colors.black12,
                            height: (currentImage == 0)
                                ? 6.0
                                : 5.0, // height of the button
                            width: (currentImage == 0)
                                ? 6.0
                                : 5.0, // width of the button
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        ClipOval(
                          child: Container(
                            color: (currentImage == 1)
                                ? Colors.black
                                : Colors.black12,
                            height: (currentImage == 1)
                                ? 6.0
                                : 5.0, // height of the button
                            width: (currentImage == 1)
                                ? 6.0
                                : 5.0, // width of the button
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        ClipOval(
                          child: Container(
                            color: (currentImage == 2)
                                ? Colors.black
                                : Colors.black12,
                            height: (currentImage == 2)
                                ? 6.0
                                : 5.0, // height of the button
                            width: (currentImage == 2)
                                ? 6.0
                                : 5.0, // width of the button
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.productName, style: TextStyle(fontSize: 20)),
                  Text("\$" + widget.productPrice.toString(),
                      style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            Column(
              children:
                  List.generate(widget.listofItemDescriptions.length, (index) {
                return _description(
                    heading: widget.listofItemDescriptions[index][0],
                    description: widget.listofItemDescriptions[index][1]);
              }),
            ),
            ExpansionTile(
              title: Text(
                "Technical specifications",
                style: TextStyle(fontSize: 20),
              ),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(widget.listItemSpecifications.length,
                      (index) {
                    return _specifications(
                        title: widget.listItemSpecifications[index][0],
                        desc: widget.listItemSpecifications[index][1]);
                  }),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30),
            ),
          ],
        ));
  }
}

Widget _description({heading, description}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Text(
          heading,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Text(
          description,
          style: TextStyle(color: Colors.black54),
        ),
      ),
    ],
  );
}

Widget _specifications({title, desc}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title),
            Text(desc, style: TextStyle(fontSize: 10))
          ],
        ),
      ),
    ],
  );
}

class TopBar extends StatefulWidget {
  final bool isFavorite;
  final productID;
  const TopBar({Key key, this.isFavorite, this.productID}) : super(key: key);
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  bool isFavorite = false;
  @override
  void initState() {
    setState(() {
      isFavorite = widget.isFavorite;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 40,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Text(
              "Overview",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            IconButton(
              icon: (isFavorite)
                  ? Icon(
                      Icons.favorite,
                      size: 25,
                      color: Theme.of(context).accentColor,
                    )
                  : Icon(
                      Icons.favorite_border,
                      size: 25,
                    ),
              onPressed: () {
                setState(() {
                  if (isFavorite == true) {
                    StoreState.removeFromFavrites(widget.productID);
                    setState(() {
                      isFavorite = false;
                    });
                  } else {
                    StoreState.addToFavorites(widget.productID);
                    setState(() {
                      isFavorite = true;
                    });
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
