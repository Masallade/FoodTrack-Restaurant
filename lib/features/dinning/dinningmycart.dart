import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor_restaurant/common/models/config_model.dart';
import 'package:stackfood_multivendor_restaurant/common/widgets/custom_snackbar_widget.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/dinningcontroller.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/proceed_to_checkout.dart';
import 'package:stackfood_multivendor_restaurant/features/profile/controllers/profile_controller.dart';
import 'package:stackfood_multivendor_restaurant/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor_restaurant/features/restaurant/domain/models/product_model.dart';
import 'package:stackfood_multivendor_restaurant/features/splash/controllers/splash_controller.dart';

class DinningMyCart extends StatefulWidget {
  const DinningMyCart({super.key});

  @override
  State<DinningMyCart> createState() => _DinningMyCartState();
}

class _DinningMyCartState extends State<DinningMyCart> {
  DinningController _dinningController=Get.find<DinningController>();
  BaseUrls? baseUrls = Get.find<SplashController>().configModel!.baseUrls;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(bottom: Get.height*0.1),
            child: Obx(()=>
                ListView.builder(
                  itemCount: _dinningController.cartItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shadowColor: Colors.grey,
                      surfaceTintColor: Color(0xFFA0A4A8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20,left: 10,top: 10,bottom: 10),
                            child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(image: NetworkImage('${baseUrls!.productImageUrl}/${_dinningController.cartItems[index]['image']}')))
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(_dinningController.cartItems[index]['name'])),
                                const SizedBox(height: 4.0),
                                const Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.grey),
                                    Icon(Icons.star, color: Colors.grey),
                                    Icon(Icons.star, color: Colors.grey),
                                    Icon(Icons.star, color: Colors.grey),
                                    Icon(Icons.star, color: Colors.grey),
                                  ],
                                ),
                                const SizedBox(height: 4.0),
                                Text('£ ${_dinningController.cartItems[index]['price']}', style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete,color: Colors.red,),
                                onPressed: () {
                                  _dinningController.deleteOrder(index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(CupertinoIcons.minus_circle,color: Color(0xFFEF7822),),
                                onPressed: () {
                                  _dinningController.decreaseQuantity(index);
                                },
                              ),

                              Obx(() => Text('${_dinningController.cartItems[index]['quantity']}')),
                              IconButton(
                                icon: const Icon(CupertinoIcons.add_circled,color: Color(0xFFEF7822),),
                                onPressed: () {
                                  _dinningController.increaseQuantity(index);

                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
            ),
          ),
          const Positioned(
            bottom: 1,
              child:ProceedTOCheckout(),
          ),
        ],
      )
    );
  }
}
