import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/dinning_restaurant_screen.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/dinningcontroller.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/dinningmycart.dart';

class DinningMainScreen extends StatefulWidget {
  const DinningMainScreen({super.key});

  @override
  State<DinningMainScreen> createState() => _DinningMainScreenState();
}

class _DinningMainScreenState extends State<DinningMainScreen> {
  DinningController _dinningController=Get.find<DinningController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
           Obx(() => Padding(
             padding: EdgeInsets.only(
               bottom: _dinningController.cartItems.length>0?80:0,
             ),
             child: DinningRestaurantScreen(),
           ),),
          Obx(() => Positioned(
            bottom: 1,
            child:_dinningController.cartItems.length>0? Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    spreadRadius: 0.5,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              height: 80,
              width: Get.width, // Changed to Get.width for proper width
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Text('Item:',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black)),
                          Obx(() => Text('${_dinningController.totalItems}',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black)),)
                        ]),
                         Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(children: [
                            Text('Total: ',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFEF7822))),
                            Text('£${_dinningController.totalPrice}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFEF7822)),
                            )]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.35,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const DinningMyCart());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF7822),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      height: 50,
                      width: 150,
                      child: const Center(
                        child: Text(
                          'View Cart',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ):SizedBox(),
          ),)
        ],
      ),
    );
  }
}
