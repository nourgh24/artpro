import 'dart:io';

import 'package:untitled5/modules/Painting%20list/painging_avatar_widget.dart';
import 'package:untitled5/modules/Painting%20list/painting_list.dart';
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              painting == null ? Colors.orange[200] : Colors.orange[200],
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_outlined, color: Colors.white,),
          ),
          title: Text(
            painting == null ? 'Add Painting' : 'Edit Painting',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
      
          actions: [
        Obx(() {
      if (imageController.deletePaintingState.value == DeletePaintingState.loading) {
        return CircularProgressIndicator();
      }
      
      if (painting != null) {
        return TextButton(
          onPressed: () async {
            await imageController.deletePainting(
              paintingId: imageController.paintinglistmodel!.Paintings![index!].id!,
      
            ); 
      
            if (imageController.deletePaintingState.value  == DeletePaintingState.succsesful) {
              Get.snackbar(
                'Success',
                'Painting deleted successfully',
                backgroundColor: Color.fromARGB(255, 202, 238, 203),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.to(PaintingList(artistId:imageController.paintinglistmodel!.Paintings![index!].id! ,)); // Go to article list screen
            } else {
              Get.snackbar(
                'Error',
                'Failed to delete painting',
                backgroundColor: Color.fromARGB(255, 241, 191, 187),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
            
          },
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.blueGrey),
          ),
        );
      } else {
        return SizedBox.shrink();
      }
        }),
      ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              height: screenheight * 1.1,
              width: screenwidth * 0.95,
              child: Column(
                children: [
                   Text(
                  "Add Painting Price ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                SizedBox(height: screenheight*0.02,),
                 
                  Container(
                    color: Colors.black12,
                    height: screenheight * 0.26,
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
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenheight*0.02,),
                  Row(
                    children:[ 
                      SizedBox(width: screenwidth*0.05,),
                     
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
                    ],
                  ),
                  SizedBox(height: screenheight * 0.03),
                  
                  Text(
                  "Add Painting Title ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenwidth * 0.05,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Title',
                          border: OutlineInputBorder(),
                          ),
                          controller: PaintingTitleController,
                        ),
                      ),
                    ],

                  ),
                   SizedBox(height: screenheight * 0.03),
                  Text(
                  "Add Painting Description ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenwidth * 0.05,
                      ),
                       
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Description',
                          border: OutlineInputBorder(),
                          ),
                        controller: PaintingDescriptionController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight * 0.03),
                  Text(
                  "Add Painting Size ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenwidth * 0.05,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Size',
                          border: OutlineInputBorder(),
                          ),
                          controller: PaintingSizeController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight * 0.03),
                   Text(
                  "Add Painting Price ",
                  style: TextStyle(
                    fontSize: 15,
                    backgroundColor: Colors.orange[50],
                  ),
                ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenwidth * 0.05,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Price',
                          border: OutlineInputBorder(),
                          ),
                          controller: PaintingPriceController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight * 0.07),
                  Center(
                    child: Obx((){
                  if (imageController.paintinglistState.value == DeletePaintingState.loading ){
           
                     return CircularProgressIndicator();
                     }
                   if (imageController.updatepaintingState.value == updatePaintingState.loading) {
                     return CircularProgressIndicator();
                   }
      
                     return ElevatedButton(
                    onPressed: () {
                       String PaintingType =determineSearchType(dropdownType);
                      final newPainting = Addpainting(
                        paintingTiltle: PaintingTitleController.text,
                        paintingDescription: PaintingDescriptionController.text,
                        paintingSize: PaintingSizeController.text,
                        paintingPrice: PaintingPriceController.text,
                        paintingType: PaintingType ,
                        paintingImage: imageController.immage!,
                      );
                      if (index == null) {
                        imageController.addPainting(addpainting: newPainting).then((_){
                           Get.snackbar(
                'Success',
                'Article added successfully',
                backgroundColor: Color.fromARGB(255, 194, 236, 196),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.offAll(PaintingList(artistId:imageController.paintinglistmodel!.Paintings![index!].artist!.id! ,)); 
                        }).catchError((error) {
            /*  Get.snackbar(
                'Error',
                'Failed to add article: $error',
                backgroundColor: Color.fromARGB(255, 229, 185, 181),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );*/
            });
                      } else {
                        imageController.UpdatePainting(paintingId: imageController.paintinglistmodel!.Paintings![index!].id!,
                      updatePainting:   Addpainting(
                          paintingDescription: PaintingDescriptionController.text,
                          paintingImage:imageController.immage! ,
                          paintingPrice: PaintingPriceController.text ,
                          paintingSize:  PaintingSizeController.text ,
                          paintingTiltle: PaintingTitleController.text  ,
                          paintingType:   PaintingTypeController.text,
                          )
                         ).then((_) {
                          Get.snackbar(
                           'Success',
                         'Painting updated successfully',
                          backgroundColor: Color.fromARGB(255, 194, 236, 196),
                          colorText: Colors.white,
                           snackPosition: SnackPosition.BOTTOM,
                            );
                          Get.offAll(PaintingList(artistId:imageController.paintinglistmodel!.Paintings![index!].id! ,)); // Replace with your article list screen
                         }).catchError((error) {
                         Get.snackbar(
                           'Error',
                            'Failed to update painting: $error',
                      backgroundColor: Color.fromARGB(255, 229, 185, 181),
                      colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
              );
            });
                      }
                      Get.back();
                    },
                    child: Text(
                      painting == null ? 'Add' : 'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                   style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[200],
                          padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                        ),
                  );
               
                       
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}

  
String determineSearchType(String dropdownType) {
  switch (dropdownType) {
    case 's':
      return '1'; 

    case 'Graphic_Design':
      return '2'; 

    case 'Photography':
      return '3'; 

      case 'Sculpture':
      return '4'; 

    case 'printing_Art':
      return '5'; 

      case 'Mural_Art':
      return '6'; 

    case 'Mosaic':
      return '7'; 
    default:
      return '1';
  }
}
}