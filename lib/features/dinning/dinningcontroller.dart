import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:stackfood_multivendor_restaurant/features/restaurant/domain/models/product_model.dart';

class DinningController extends GetxController{

RxList<RxMap<String,dynamic>> cartItems=<RxMap<String,dynamic>>[].obs;
RxDouble totalPrice=0.0.obs;
RxInt totalItems=0.obs;
RxBool paymentSelection=false.obs;

String addElementToCart(Product? productModel){
  if(productModel == null) {
    return 'null';
  }
  for(int i=0;i<cartItems.length;i++){
    if(cartItems[i]['id']==productModel.id){
      cartItems[i]['quantity']=cartItems[i]['quantity'] +1;
      print('//////////////////////cart///////////////////');
      print(cartItems);
      print('//////////////////////cartdo///////////////////');
      totalElements();
      totalPriceElement();
      return 'quantity';
    }
  }
  RxMap<String, dynamic> newItem = {
    'id': productModel.id,
    'name': productModel.name,
    'price': productModel.price,
    'image': productModel.image,
    'quantity': 1,
  }.obs; // Convert to RxMap
  cartItems.add(newItem);
  print('//////////////////////cart///////////////////');
  print(cartItems);
  print('//////////////////////cartdo///////////////////');
  totalElements();
  totalPriceElement();
  return'123';

}

void increaseQuantity(int listindex){
  print('//////before   increaseQuantity');
  print(cartItems[listindex]['quantity']);
cartItems[listindex]['quantity']=cartItems[listindex]['quantity']+1;
  print('//////after   increaseQuantity');
  print(cartItems[listindex]['quantity']);
  totalElements();
  totalPriceElement();
}

void decreaseQuantity(int listindex) {
  if (cartItems[listindex]['quantity'] >0) {
    print('//////before   decreaseQuantity');
    print(cartItems[listindex]['quantity']);
    cartItems[listindex]['quantity'] = cartItems[listindex]['quantity'] - 1;
    print('//////after   decreaseQuantity');
    print(cartItems[listindex]['quantity']);
    totalElements();
    totalPriceElement();
  }
}

void totalElements(){
  int total=0;
  for(int i=0;i<cartItems.length;i++){
    print(cartItems[i]['quantity']);
    total+=cartItems[i]['quantity'] as int;

  }
  print('****************totalelement****************');
  totalItems.value=total;
  print(totalItems.value);

}

void totalPriceElement() {
  double price=0.0;
  for(int i=0;i<cartItems.length;i++){
    price+=cartItems[i]['price'] * cartItems[i]['quantity'];
  }
  totalPrice.value=(price *100).round() / 100;
}

void deleteOrder(int index){
  cartItems.removeAt(index);
  totalElements();
  totalPriceElement();

}

String totalPriceOfEachItem(double price,int quantity){
 double totalPriceOfItem= price*quantity;
 return totalPriceOfItem.toString();
}


}