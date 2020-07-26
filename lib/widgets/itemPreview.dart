import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_shop/screens/itemDetails.dart';
import 'package:flutter_shop/logic/constants.dart';
import 'package:flutter_shop/logic/storeState.dart';
class ItemPreview extends StatefulWidget {
  final String productId;

  const ItemPreview({Key key, this.productId}) : super(key: key);
  @override
  _ItemPreviewState createState() => _ItemPreviewState();
}

class _ItemPreviewState extends State<ItemPreview> {
  bool isMarkedAsFavorite;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    isMarkedAsFavorite = StoreState.isFavorite(widget.productId);
    return GestureDetector(
      onTap: (){
        var itemDetials = ItemDetials(
          productName:PRODUCTS[widget.productId][0],
          productPrice: double.parse(PRODUCTS[widget.productId][1]),
          listItemSpecifications: PRODUCTS[widget.productId][4],
          listofItemDescriptions: PRODUCTS[widget.productId][3],
          listofItemImages: PRODUCTS[widget.productId][5],
          productId: widget.productId,
          );
        Navigator.push(context, SlideRightRoute(page: itemDetials));
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey[50],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  tooltip: "Add to favorites",
                  icon: (!isMarkedAsFavorite)?Icon(Icons.favorite_border):Icon(Icons.favorite,color: Colors.red,),
                  onPressed: () {
                    setState(() {
                      if(isMarkedAsFavorite==true){
                        StoreState.removeFromFavrites(widget.productId);
                        setState(() {
                          isMarkedAsFavorite =false;
                        });
                      }else{
                        StoreState.addToFavorites(widget.productId);
                        setState(() {
                          isMarkedAsFavorite = true;
                        });
                      }
                    });
                  },
                ),
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        color: Colors.transparent,
                      ),
                      Positioned(
                        top: 1,
                        child: ClipOval(
                          child: Container(
                            color: Colors.white,
                            height: 120.0, // height of the button
                            width: 120.0, // width of the button
                          ),
                        ),
                      ),
                      Positioned(
                        child: Image.asset( PRODUCTS[widget.productId][2]),width: 120,height: 120,),
                    ],
                  ),
                ),
                Center(child: Text( PRODUCTS[widget.productId][0])),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                Center(child: Text("\$"+ PRODUCTS[widget.productId][1])),
              ],
            ),
          )),
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
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}