import 'package:flutter_shop/logic/constants.dart';

class CartCalculator{
  static calculateTotal(Map<String,int>cart){
    return calculateSubtotal(cart)+calculateShipping(cart);
  }
  static double calculateSubtotal(Map<String,int>cart){
    double total = 0;
    cart.keys.forEach((item){
      total = total + (cart[item]*double.parse(PRODUCTS[item][1]));
    });
    return total;
  }
  static double calculateShipping(Map<String,int>cart){
    double total = 0;
    cart.keys.forEach((item){
      total = total + (cart[item]*double.parse(PRODUCTS[item][1]));
    });
    if(total >= 50.00 || total == 0){
      return 0.0;
    }else{
      return 8.0;
    }
  }
}