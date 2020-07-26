import 'package:flutter/material.dart';
import 'package:flutter_shop/logic/storeState.dart';
import 'package:flutter_shop/logic/constants.dart';
import 'package:flutter_shop/logic/cartCalculator.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map cartItems;
  @override
  void initState() {
    cartItems = StoreState.getCart();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: (cartItems.isEmpty)?null:FloatingActionButton.extended(        
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,),
          child: Text("Checkout".toUpperCase()),
        ),
        icon: Icon(Icons.check_circle_outline),
        onPressed: (){         
        },
      ),
      body: ListView(
       children: <Widget>[
         Padding(padding: EdgeInsets.all(8.0),),
         Row(
           children: <Widget>[
             IconButton(
               icon: Icon(Icons.close,size: 20,),
               onPressed: (){
                 Navigator.of(context).pop();
               },
             ),
             Text("CART",style: Theme.of(context).textTheme.subtitle,),
             Padding(padding: EdgeInsets.all(8.0),),
             Text((cartItems.keys.toList().length).toString()+" ITEMS")
           ],
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
           child: Column(
             children: List.generate(cartItems.keys.toList().length, (index){
               var productID = cartItems.keys.toList()[index];
               return Column(
                 children: <Widget>[
                   Row(
                 
                 children: <Widget>[
                   IconButton(
                     icon: Icon(Icons.remove_circle_outline),
                     onPressed: (){
                       setState(() {
                         StoreState.decreaseItemCount(productID);
                       });
                     },
                   ),
                   Spacer(flex: 1,),
                   Image.asset( 
                    PRODUCTS[productID][2],width: 120,height: 120,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Text("Quantity: "+cartItems[productID].toString(),style: Theme.of(context).textTheme.caption,),
                        ],),
                        Text("x \$"+PRODUCTS[productID][1],style: Theme.of(context).textTheme.caption,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(PRODUCTS[productID][0]),
                        )
                      ],
                    ),
                    Spacer(flex: 1,),
                    
                 ],          
               ),
               Padding(padding: EdgeInsets.all(2),),
               Container(
                      color: Colors.blueGrey[50],  
                      height: 1,
                    )
                ],
               );
             }),
           ),
         ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text("TOTAL"),
                Text("\$"+CartCalculator.calculateTotal(cartItems).toStringAsFixed(2),style: Theme.of(context).textTheme.display1,),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text("Subtotal"),
                Text("\$"+CartCalculator.calculateSubtotal(cartItems).toStringAsFixed(2)),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text("Shipping"),
                Text("\$"+CartCalculator.calculateShipping(cartItems).toStringAsFixed(2)),
              ],),
            ),
            Padding(padding: EdgeInsets.all(55),)
          ],
        )
       ],
      ),
    );
  }
}