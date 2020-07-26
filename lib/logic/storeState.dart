import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_shop/logic/constants.dart';
class StoreState{
  static Map<String,int> _cart = {};
  static List<String> _favorites = [];
  


  static  initialize() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites')??[];
    List<String> cartItems = prefs.getStringList('cartItems')??[];
    List<String> cartCount = prefs.getStringList('cartCount')??[];
    for(int i= 0; i < cartItems.length;i++){
      _cart[cartItems[i]] = int.parse(cartCount[i]);
    }
  }

  static _saveCart() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cartItems', _cart.keys.toList());
    List<String> listofStrings = [];
    _cart.values.toList().forEach((item){
      listofStrings.add(item.toString());
    });
    prefs.setStringList('cartCount', listofStrings);
  }

  static _savefavorite() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites);
  }

  static addToCart(String id) async {
    if(_cart.keys.contains(id)){
      int numberOfitem = _cart[id];
      _cart[id] = numberOfitem + 1;
    }else{
      _cart[id]= 1;
    }
    await _saveCart();
    
  }
  static Map<String,int> getCart(){
    return _cart;
  }
  static increaseItemCount(id){
    addToCart(id);
    _saveCart();
  }
  static decreaseItemCount(id){
    if(_cart.keys.contains(id)&&(_cart[id]>1)){
      int numberOfitem = _cart[id];
      _cart[id] = numberOfitem - 1;
    }else if(_cart[id]==1){
      removeFromCart(id);
    }
    _saveCart();
  }
  static removeFromCart(String id){
    if(_cart.keys.contains(id)){
      _cart.remove(id);
      _saveCart();
    }else{
      print("Item is not found in cart");
    }
  }
  static addToFavorites(String id){
    if(_favorites.contains(id)){
      print("Already added");
    }else{
      _favorites.add(id);
      _savefavorite();
    }
  }
  static isFavorite(String id){
    return _favorites.contains(id);
  }
  static removeFromFavrites(String id){
    _favorites.remove(id);
    _savefavorite();
  }

  static List<String> favorites(){
    return _favorites;
  }

  static sortPriceFromLowtoHigh(List<String> products){
    products.sort((a,b){
      var num1 = double.parse(PRODUCTS[a][1]);
      var num2 = double.parse(PRODUCTS[b][1]);
      return num1.compareTo(num2);
    });
    return products;
  }
  static sortPriceFromHightoLow(Map<String,dynamic> productsMap){
    var products = productsMap.keys.toList();
    products.sort((a,b){
      var num1 = double.parse(productsMap[a][1]);
      var num2 = double.parse(productsMap[b][1]);
      return num2.compareTo(num1);
    });
    return products;
  }

  static shuffleProducts(List<String> products){
    products.shuffle();
    return products;
  }

  static getPhones(List<String> products, String category){
    List<String> filtered = [];
    products.forEach((p){
      if(PRODUCTS[p][6] == category){
        filtered.add(p);
      }
    });
    return filtered;
  }
}