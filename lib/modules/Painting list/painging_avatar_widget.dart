import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';

class PaingingAvatarWidget extends StatefulWidget {
  final Function(File)? selectNewImage;
  final File? fileImage;
  final String? stringImage;
  final bool editButton;

  const PaingingAvatarWidget(
      {this.stringImage,
      this.fileImage,
      super.key,
      this.selectNewImage,
      this.editButton = true});

  @override
  State<PaingingAvatarWidget> createState() => _PaingingAvatarWidgetState();
}

class _PaingingAvatarWidgetState extends State<PaingingAvatarWidget> {
  String? selctedImage;
  String? currantImage;

  @override
  void initState() {
    super.initState();

    currantImage = widget.stringImage;

    if (widget.fileImage != null) {
      selctedImage = widget.fileImage!.path;
    }
  }

  Widget imageTypeWidget() {
    if (currantImage != null) {
      return CachedNetworkImage(
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.5),
          highlightColor: Colors.grey,
          child: Container(
            height: 20.h,
            width: double.infinity,
            decoration: BoxDecoration(
              // border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(4.w),
                       color: Colors.grey,
            ),
          ),
        ),
        imageBuilder: (context, imageProvider) => Container(
            height: 20.h,
            width: double.infinity,
            decoration: BoxDecoration(
                         color: Colors.grey,
                // border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(4.w),
                image: DecorationImage(
                    image: imageProvider, fit: BoxFit.cover))),
        fadeInDuration: const Duration(milliseconds: 4),
        fadeOutDuration: const Duration(milliseconds: 4),
        imageUrl: currantImage!,
        errorWidget: (context, url, error) => Container(
          height: 20.h,
          width: double.infinity,
          decoration: BoxDecoration(
               color: Colors.grey,
              // border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(4.w)),
          child: const  Icon(
        Icons.add_photo_alternate_outlined,
        size: 40,
        ),
        ),
        fit: BoxFit.cover,
      );
    }
    if (selctedImage != null) {
      return Container(
          height: 25.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
              borderRadius: BorderRadius.circular(2.w),
              // border: Border.all(color: AppColors.primaryColor),
              image: DecorationImage(
                  image: FileImage(File(
                    selctedImage!,
                  )),
                  fit: BoxFit.cover)));
    } else {
      return Container(
        height: 20.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey,
          borderRadius: BorderRadius.circular(4.w),
          // border: Border.all(color: AppColors.primaryColor),
        ),
        child:const  Icon(
        Icons.add_photo_alternate_outlined,
        size: 30,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: imageTypeWidget(),
        ),
        if (widget.editButton)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            child: Card(
              child: IconButton(
                onPressed: () {
                  showImageDialog(context);
                },
                icon: Icon(Icons.edit,size: 20,)
              ),
            ),
          ),
      ],
    );
  }

  Future showImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
              "Choose the image",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                      fontSize: 16.sp,
                         fontWeight: FontWeight.bold,
                ),
             
              ),
              content: SizedBox(
                height: 20.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                final file = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (file != null) {
                                  widget.selectNewImage!(File(file.path));
                                  setState(() {
                                    currantImage = null;
                                    selctedImage = file.path;
                                  });
                                }

                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo,
                                    size: 25.w,
                                  
                                  ),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                    
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                final file = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (file != null) {
                                  widget.selectNewImage!(File(file.path));
                                  setState(() {
                                    currantImage = null;
                                    selctedImage = file.path;
                                  });
                                }
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera,
                                    size: 25.w,
                                  
                                  ),
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                       
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  // photoSelect(BuildContext context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       barrierColor: Colors.transparent,
  //       backgroundColor: Colors.transparent,
  //       builder: (context) {
  //         return PickImage(onImagePicked: (imagePath) {
  //           widget.function(File(imagePath));
  //           setState(() {
  //             selctedImage = imagePath;
  //           });
  //         });
  //       });
  // }
}
