import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'gallery3d_controller.dart';

class Gallery3d extends StatelessWidget {
  final Gallery3dController _controller = Get.put(Gallery3dController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Art Gallery'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ديكور الجدار
            Container(
          height: 1000,
          color: Colors.grey[300], // لون الجدار
          // يمكنك إضافة أي ديكور آخر للجدار هنا

          child: Stack(
        children: [

            SizedBox(height: 40),
            // عرض اللوحات الفنية
            Obx(
                  () => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // عدد الأعمدة في الشبكة
                  mainAxisSpacing: 10, // التباعد الرأسي بين العناصر
                  crossAxisSpacing: 10, //// التباعد الأفقي بين العناصر
                  childAspectRatio: 0.8, // نسبة عرض العنصر إلى ارتفاعه
                ),
                itemCount: _controller.artworks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final artwork = _controller.artworks[index];
                  return GestureDetector(
                    onTap: () {
                      // يمكنك تنفيذ إجراء عند النقر على اللوحة الفنية هنا
                    },
                    child: Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // عرض الصورة
                          Image.asset(
                            artwork.imageUrl,
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                          // اسم اللوحة
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              artwork.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    ),
    ],
      ),
      ),
    );
  }
}
/*
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import 'gallery3d_controller.dart';
import 'package:get/get.dart';
class PhotoViewerScreen extends GetWidget<PhotoViewerController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey,
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 16, top: 13, right: 16, bottom: 13),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                          svgPath: "images/4.jpg",
                          height: getSize(24),
                          width: getSize(24),
                          onTap: () {
                            onTapImgArrowleft();
                          }),
                      Container(
                          height: getVerticalSize(732),
                          width: getHorizontalSize(396),
                          margin: getMargin(top: 37, bottom: 5),
                          child: Stack(alignment: Alignment.center, children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                      svgPath: "images/6.jpg",
                                      height: getSize(24),
                                      width: getSize(24)),
                                  CustomImageView(
                                      svgPath:"images/7.jpg",
                                      height: getSize(24),
                                      width: getSize(24),
                                      margin: getMargin(top: 24))
                                ],),),
                            Align(
                                alignment: Alignment.center,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                              height: getVerticalSize(429),
                                              width: getHorizontalSize(332),
                                              child: Stack(
                                                  alignment:
                                                  Alignment.topCenter,
                                                  children: [
                                                    Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .min,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              CustomImageView(
                                                                  imagePath:
                                                                  "images/9.jpg",
                                                                  height:
                                                                  getVerticalSize(
                                                                      129),
                                                                  width:
                                                                  getHorizontalSize(
                                                                      332)),
                                                              Padding(
                                                                  padding:
                                                                  getPadding(
                                                                      top:
                                                                      6),
                                                                  child: Text(
                                                                      "lbl_360"
                                                                          .tr,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style: AppStyle
                                                                          .txtGilroyMedium16))
                                                            ])),
                                                    CustomImageView(
                                                        imagePath: "images/8.jpg",
                                                        height: getVerticalSize(
                                                            346),
                                                        width:
                                                        getHorizontalSize(
                                                            283),
                                                        alignment:
                                                        Alignment.topCenter)
                                                  ]))),
                                      Padding(
                                          padding: getPadding(top: 34),
                                          child: Row(children: [
                                            Text("lbl_furniture_chair".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtGilroySemiBold24),
                                            Spacer(),
                                            CustomImageView(
                                                svgPath:"images/4.jpg",
                                                height: getSize(24),
                                                width: getSize(24),
                                                radius: BorderRadius.circular(
                                                    getHorizontalSize(1)),
                                                margin: getMargin(
                                                    top: 2, bottom: 2)),
                                            Padding(
                                                padding: getPadding(
                                                    left: 4, top: 3, bottom: 3),
                                                child: Text("lbl_4_5".tr,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtGilroyBold18))
                                          ])),
                                      Container(
                                          width: getHorizontalSize(375),
                                          margin: getMargin(top: 31, right: 20),
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mattis sit tortor nibh diam velit tempor, mi. Risus non facilisis pellentesque a."
                                                        .tr,
                                                    style: TextStyle(
                                                        color: Colors.indigoAccent,
                                                        fontSize:
                                                        getFontSize(16),
                                                        fontFamily: 'Gilroy',
                                                        fontWeight:
                                                        FontWeight.w400)),
                                                TextSpan(
                                                    text:
                                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                                                        .tr,
                                                    style: TextStyle(
                                                        color: Colors.indigoAccent,
                                                        fontSize:
                                                        getFontSize(16),
                                                        fontFamily: 'Gilroy',
                                                        fontWeight:
                                                        FontWeight.w400))
                                              ]),
                                              textAlign: TextAlign.left)),
                                      Padding(
                                          padding: getPadding(top: 27),
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Text("lbl_mrp".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                          TextAlign.left,
                                                          style: AppStyle
                                                              .txtGilroyMedium16Black900),
                                                      Padding(
                                                          padding: getPadding(
                                                              top: 12),
                                                          child: Text(
                                                              "lbl_90_50".tr,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              textAlign:
                                                              TextAlign
                                                                  .left,
                                                              style: AppStyle
                                                                  .txtGilroyBold24))
                                                    ]),
                                                CustomButton(
                                                    height: getVerticalSize(57),
                                                    width:
                                                    getHorizontalSize(230),
                                                    text: "lbl_add_to_cart".tr,
                                                    margin: getMargin(
                                                        top: 3, bottom: 1))
                                              ]))
                                    ]))
                          ]))
                    ]))));
  }

  onTapImgArrowleft() {
    Get.back();
  }
}




/////////////////////////////////////////////////////

// ignore_for_file: must_be_immutable


class CustomImageView extends StatelessWidget {
  ///[url] is required parameter for fetching network image
  String? url;

  ///[imagePath] is required parameter for showing png,jpg,etc image
  String? imagePath;

  ///[svgPath] is required parameter for showing svg image
  String? svgPath;

  ///[file] is required parameter for fetching image file
  File? file;

  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageView({
    Key? key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment!,
      child: _buildWidget(),
    )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          svgPath!,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          color: color,
        ),
      );
    } else if (file != null && file!.path.isNotEmpty) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    } else if (url != null && url!.isNotEmpty) {
      return  CachedNetworkImage(
        height: height,
        width: width,
        fit: fit,
        imageUrl: url!,
        color: color,
        placeholder: (context, url) => SizedBox(
          height: 30,
          width: 30,
          child: LinearProgressIndicator(
            color: Colors.grey.shade200,
            backgroundColor: Colors.grey.shade100,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          placeHolder,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
        ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    }
    return const SizedBox();
  }
}

// This is where the magic happens.
// This functions are responsible to make UI responsive across all the mobile devices.

Size size = WidgetsBinding.instance.window.physicalSize /
    WidgetsBinding.instance.window.devicePixelRatio;

// Caution! If you think these are static values and are used to build a static UI,  you mustn’t.
// These are the Viewport values of your Figma Design.
// These are used in the code as a reference to create your UI Responsively.
const num FIGMA_DESIGN_WIDTH = 428;
const num FIGMA_DESIGN_HEIGHT = 926;
const num FIGMA_DESIGN_STATUS_BAR = 47;

///This method is used to get device viewport width.
get width {
  return size.width;
}

///This method is used to get device viewport height.
get height {
  num statusBar =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.top;
  num bottomBar = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
      .viewPadding
      .bottom;
  num screenHeight = size.height - statusBar - bottomBar;
  return screenHeight;
}

///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
double getHorizontalSize(double px) {
  return ((px * width) / FIGMA_DESIGN_WIDTH);
}

///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
double getVerticalSize(double px) {
  return ((px * height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR));
}

///This method is used to set smallest px in image height and width
double getSize(double px) {
  var height = getVerticalSize(px);
  var width = getHorizontalSize(px);
  if (height < width) {
    return height.toInt().toDouble();
  } else {
    return width.toInt().toDouble();
  }
}

///This method is used to set text font size according to Viewport
double getFontSize(double px) {
  return getSize(px);
}

///This method is used to set padding responsively
EdgeInsetsGeometry getPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  return getMarginOrPadding(
    all: all,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}

///This method is used to set margin responsively
EdgeInsetsGeometry getMargin({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  return getMarginOrPadding(
    all: all,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}

///This method is used to get padding or margin responsively
EdgeInsetsGeometry getMarginOrPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  if (all != null) {
    left = all;
    top = all;
    right = all;
    bottom = all;
  }
  return EdgeInsets.only(
    left: getHorizontalSize(
      left ?? 0,
    ),
    top: getVerticalSize(
      top ?? 0,
    ),
    right: getHorizontalSize(
      right ?? 0,
    ),
    bottom: getVerticalSize(
      bottom ?? 0,
    ),
  );
}


////////////////////////////////////////

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.shape,
        this.padding,
        this.variant,
        this.fontStyle,
        this.alignment,
        this.margin,
        this.onTap,
        this.width,
        this.height,
        this.text,
        this.prefixWidget,
        this.suffixWidget});

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  String? text;

  Widget? prefixWidget;

  Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment!,
      child: _buildButtonWidget(),
    )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? SizedBox(),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: _setFontStyle(),
          ),
          suffixWidget ?? SizedBox(),
        ],
      );
    } else {
      return Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: _setFontStyle(),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        width ?? double.maxFinite,
        height ?? getVerticalSize(40),
      ),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setPadding() {
    switch (padding) {
      default:
        return getPadding(
          all: 17,
        );
    }
  }

  _setColor() {
    switch (variant) {
      default:
        return Colors.blue;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            6.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      default:
        return TextStyle(
          color: Colors.white,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w500,
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder6,
}

enum ButtonPadding {
  PaddingAll17,
}

enum ButtonVariant {
  FillBlueA700,
}

enum ButtonFontStyle {
  GilroyMedium18,
}
//////////////////////////////////


class AppStyle {
  static TextStyle txtGilroySemiBold24 = TextStyle(
    color: Colors.black,
    fontSize: getFontSize(
      24,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w600,
  );

  static TextStyle txtGilroyBold18 = TextStyle(
    color: Colors.black,
    fontSize: getFontSize(
      18,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w700,
  );

  static TextStyle txtGilroyMedium16Black900 = TextStyle(
    color: Colors.black,
    fontSize: getFontSize(
      16,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w500,
  );

  static TextStyle txtPoppinsRegular14Bluegray400 = TextStyle(
    color: Colors.blue,
    fontSize: getFontSize(
      14,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtGilroyBold24 = TextStyle(
    color: Colors.blue,
    fontSize: getFontSize(
      24,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w700,
  );

  static TextStyle txtGilroyMedium14 = TextStyle(
    color: Colors.black,
    fontSize: getFontSize(
      14,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w500,
  );

  static TextStyle txtGilroyRegular12 = TextStyle(
    color: Colors.black,
    fontSize: getFontSize(
      12,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtGilroySemiBold18 = TextStyle(
    color: Colors.blue,
    fontSize: getFontSize(
      18,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w600,
  );

  static TextStyle txtPoppinsRegular14 = TextStyle(
    color: Colors.blueGrey,
    fontSize: getFontSize(
      14,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtGilroyRegular16 = TextStyle(
    color: Colors.blueGrey,
    fontSize: getFontSize(
      16,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtGilroyMedium16 = TextStyle(
    color: Colors.blueGrey,
    fontSize: getFontSize(
      16,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w500,
  );

  static TextStyle txtGilroyRegular14 = TextStyle(
    color: Colors.blueGrey,
    fontSize: getFontSize(
      14,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtGilroyMedium14Bluegray400 = TextStyle(
    color: Colors.blueGrey,
    fontSize: getFontSize(
      14,
    ),
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.w500,
  );

  static TextStyle txtRobotoRegular16 = TextStyle(
    color: Colors.blueGrey,
    fontSize: getFontSize(
      16,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtRobotoRegular20 = TextStyle(
    color: Colors.black,
    fontSize: getFontSize(
      20,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );
}*/
