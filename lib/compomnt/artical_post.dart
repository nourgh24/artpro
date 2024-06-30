import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticalPost extends StatelessWidget {
  const ArticalPost({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offNamed('/ArtistProfile');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: const Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/d.jpeg'),
                  radius: 20,
                  child: SizedBox(
                    width: 10,
                    height: 10,
                  ),
                ),
              ),
              Text(
                'Artist name',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('10  month ago'),
              ),
            ],
          ),
          SizedBox(
              height: 60,
              width: 340,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  'Impressive! Though it seems the drag feature could be improved. But overall it looks incredible. You’ve nailed the design and theresponsiveness at various breakpoints works really well.! Though it seems the drag feature could be improved. But overall it looks incredible! Though it seems the drag feature could be improved. But overall it looks incredible',
                  maxLines: 6,
                  // overflow: TextOverflow.ellipsis,
                ),
              ))
        ],
      ),
    ));
  }
}
