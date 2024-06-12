import 'package:untitled5/modules/Painting%20list/painging_avatar_widget.dart';
import 'package:untitled5/modules/Painting%20list/painting_list_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'painting_list_controller.dart';

class AddNewPainting extends StatelessWidget {
  final PaintingListController imageController =
      Get.find<PaintingListController>();
  final int? index;
  final Addpainting? painting;
  String dropdownType = 'Art';

  AddNewPainting({this.index, this.painting});

  final PaintingTitleController = TextEditingController();
  final PaintingDescriptionController = TextEditingController();
  final PaintingSizeController = TextEditingController();
  final PaintingPriceController = TextEditingController();
  final PaintingTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    if (painting != null) {
      PaintingTitleController.text = painting!.paintingTiltle;
      PaintingDescriptionController.text = painting!.paintingDescription;
      PaintingSizeController.text = painting!.paintingSize;
      PaintingPriceController.text = painting!.paintingPrice;
      PaintingTypeController.text = painting!.paintingType;
      imageController.immage = painting!.paintingImage;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            painting == null ? Colors.orange[300] : Colors.orange[200],
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        title: Center(
          child: Text(
            painting == null ? 'Add Painting' : 'Edit Painting',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: screenheight * 1.1,
            width: screenwidth * 0.95,
            child: Column(
              children: [
                Container(
                  height: screenheight * 0.3,
                  width: screenwidth * 0.9,
                  child: Center(
                    child: Stack(
                      children: [
                        if (imageController.immage != null)
                          Positioned.fill(
                              child: PaingingAvatarWidget(
                            fileImage: imageController.immage!,
                          )),
                        Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              imageController.pickImage().then((_) {
                                imageController.update();
                              });
                            },
                            icon: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                    isExpanded: true,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 15,
                    ),
                    value: dropdownType,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownType = newValue!;
                      });
                    },
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'Art',
                        child: Text('Art'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Graphic_Design',
                        child: Text('Graphic_Design'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Photography',
                        child: Text('Photography'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Visual_Art',
                        child: Text('Visual_Art'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Sculpture',
                        child: Text('Sculpture'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'printing_Art',
                        child: Text('printing_Art'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Mural_Art',
                        child: Text('Mural_Art'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Mosaic',
                        child: Text('Mosaic'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenheight * 0.02),
                Row(
                  children: [
                    SizedBox(
                      width: screenwidth * 0.05,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Description'),
                        controller: PaintingDescriptionController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenheight * 0.02),
                SizedBox(height: screenheight * 0.02),
                Row(
                  children: [
                    SizedBox(
                      width: screenwidth * 0.05,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: PaintingTitleController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenheight * 0.02),
                Row(
                  children: [
                    SizedBox(
                      width: screenwidth * 0.05,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Size'),
                        controller: PaintingSizeController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenheight * 0.02),
                Row(
                  children: [
                    SizedBox(
                      width: screenwidth * 0.05,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Price'),
                        controller: PaintingPriceController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenheight * 0.07),
                ElevatedButton(
                  onPressed: () {
                    final newPainting = Addpainting(
                      paintingTiltle: PaintingTitleController.text,
                      paintingDescription: PaintingDescriptionController.text,
                      paintingSize: PaintingSizeController.text,
                      paintingPrice: PaintingPriceController.text,
                      paintingType: dropdownType ?? '',
                      paintingImage: imageController.immage!,
                    );
                    if (index == null) {
                      imageController.addPainting(addpainting: newPainting);
                    } else {
                      // imageController.updatePainting(index!, newPainting);
                    }
                    Get.back();
                  },
                  child: Text(
                    painting == null ? 'Add' : 'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: painting == null
                        ? Colors.orange[300]
                        : Colors.orange[200],
                    padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
