import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/compomnt/custom_text_field.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('          Payment Details'),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(25),
                  child: const Text(
                    'ecash',
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(25),
                  child: const Text(
                    'fatora',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 90),
          CustomTextField(
            lableName: 'Card Number',
            hight: 50,
            width: double.infinity,
            hitText: '1234 5678 1234 5678',
            onChange: (s) {},
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              CustomTextField(
                lableName: 'Name',
                hight: 50,
                width: 100,
                hitText: 'same lois',
                onChange: (s) {},
              ),
              CustomTextField(
                lableName: 'card ID',
                hight: 50,
                width: 100,
                hitText: 'Master Card',
                onChange: (s) {},
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              CustomTextField(
                lableName: 'Expiration Date',
                hight: 50,
                width: 100,
                hitText: '07/29',
                onChange: (s) {},
              ),
              const SizedBox(
                width: 40,
              ),
              CustomTextField(
                lableName: 'CVV',
                hight: 50,
                width: 100,
                hitText: '412',
                onChange: (s) {},
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.all(18),
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange[300],
            ),
            child: const Center(
              child: Text(
                'Complete Payment',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
