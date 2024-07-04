import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/checkout.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/dinningcontroller.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/firebasecontroller/firebasecontroller.dart';

class ConfromOrder extends StatefulWidget {
  const ConfromOrder({super.key});

  @override
  State<ConfromOrder> createState() => _ConfromOrderState();
}

class _ConfromOrderState extends State<ConfromOrder> {
  DinningController _dinningController=Get.find<DinningController>();
  FirebaseController _firebaseController=FirebaseController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Checkout(),
          ),
          Positioned(
              bottom: 1,
              child: Container(
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
                      },
                      child: InkWell(
                        onTap: (){
                          _firebaseController.addData(_dinningController.cartItems);
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
                              'conform order',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
