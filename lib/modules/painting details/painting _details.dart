import 'package:cached_network_image/cached_network_image.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/modules/article%20comments/article_comments.dart';
import 'package:untitled5/modules/checkout_payment/checkout_payment.dart';
import 'package:untitled5/modules/painting%20details/painting_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/modules/painting%20details/painting_details_service.dart';

class PaintingDetails extends StatefulWidget {
  final AddPaintingComplaint? paintingcomplaint;
  final int paintingId;
  PaintingDetails({required this.paintingId,required this.paintingcomplaint, super.key});
  final complaintDescriptionController = TextEditingController();

  @override
  State<PaintingDetails> createState() => _PaintingDetailsState();

}

class _PaintingDetailsState extends State<PaintingDetails> {
  final PaintingDetailsController _controller =
      Get.put(PaintingDetailsController());

  List<bool> selected = [false, false];

  static const favoritedKey = 'favorited_Key';
  static const likedKey = 'likedKey';
  static const dislikedKey = 'dislikedKey';
  late bool Favorited = false;
  late bool Liked = false;
  late bool DisLiked = false;
  double rating = 0; 
  int Like_count = 0;
  int DisLike_count = 0;
  final int commentsCount = 15;
  final int interactionsCount = 20;
  @override
  void initState() {
    super.initState();
     if (widget.paintingcomplaint != null) {
      widget.complaintDescriptionController.text = widget.paintingcomplaint!.Description;
    }
    _controller.getPaintingDetails(paintingId: widget.paintingId);
    _favorited();
    _liked();
    _disliked();
  }

  void _favorited() async {
    var preferences = await SharedPreferences.getInstance();
    var Favorited = preferences.getBool(favoritedKey);
    setState(() => this.Favorited = Favorited!);
  }

  void _favoritedPreference() async {
    setState(() {
      Favorited = !Favorited;
    });
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool(favoritedKey, Favorited);
  }

  void _liked() async {
    var preferences = await SharedPreferences.getInstance();
    var Liked = preferences.getBool(likedKey);
    setState(() => this.Liked = Liked!);
  }

  void _likedPreference() async {
    setState(() {
      if (Liked) {
        Like_count -= 1;
        Liked = false;
      } else {
        Like_count += 1;
        Liked = true;
      }
      // Liked=!Liked;
    });
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool(likedKey, Liked);
  }

  void _disliked() async {
    var preferences = await SharedPreferences.getInstance();
    var DisLiked = preferences.getBool(dislikedKey);
    setState(() => this.DisLiked = DisLiked!);
  }

  void _dislikedPreference() async {
    setState(() {
      if (DisLiked) {
        DisLike_count -= 1;
        DisLiked = false;
      } else {
        DisLike_count += 1;
        DisLiked = true;
      }
      //DisLiked=!DisLiked;
    });
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool(dislikedKey, DisLiked);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
              width: screenwidth,
              height: screenheight * 1.4,
              child: Obx(() {

                if (_controller.paintingDetailsState.value ==
                    PaintingDetailsState.loading) {
                  return Center(child: CircularProgressIndicator());
                }
      
                if (_controller.paintingDetailsState.value ==
                    PaintingDetailsState.error) {
                  return SizedBox();
                }
      
                return Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.5),
                            highlightColor: Colors.grey,
                            child: Container(
                              width: double.maxFinite,
                              height: screenheight * 0.5,
                              color: Colors.grey,
                            )),
                        imageBuilder: (context, imageProvider) => Container(
                          width: double.maxFinite,
                          height: screenheight * 0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        fadeInDuration: const Duration(milliseconds: 4),
                        fadeOutDuration: const Duration(milliseconds: 4),
                        imageUrl:UrlsApi.baseimageUrl+ _controller.paintingsModel!.painting!.url! ??"",
                        errorWidget: (context, url, error) => Container(
                          width: double.maxFinite,
                          height: screenheight * 0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('${_controller.imageUrl.value}'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 30,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 30,
                      right: 20,
                      child: IconButton(
                        onPressed: () {
                          _favoritedPreference();
                        },
                        icon: Icon(
                          Favorited ? Icons.favorite : Icons.favorite_border,
                          //  Favorited?Icons.favorite:Icons.favorite_border,
                          color: Favorited ? Colors.red : Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 330,
                      child: SingleChildScrollView(
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 20, right: 20, top: 40),
                          width: screenwidth,
                          height: screenheight * 1.5,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: screenheight*0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Image Details',
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenheight * 0.01,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Positioned(
                                        top: 460,
                                        left: 30,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                            child: Shimmer.fromColors(
                                              baseColor:
                                                  Colors.grey.withOpacity(0.5),
                                              highlightColor: Colors.grey,
                                              child: const CircleAvatar(
                                                radius: 25,
                                              ),
                                            ),
                                          ),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                            radius: 25,
                                            backgroundImage: imageProvider,
                                          ),
                                          fadeInDuration:
                                              const Duration(milliseconds: 4),
                                          fadeOutDuration:
                                              const Duration(milliseconds: 4),
                                          imageUrl: _controller.paintingsModel!
                                                  .painting!.artist!.image ??
                                              "",
                                          errorWidget: (context, url, error) =>
                                              CircleAvatar(
                                            radius: 25,
                                            backgroundImage: AssetImage(
                                                '${_controller.authorImageUrl.value}'),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Positioned(
                                            top: 500,
                                            left: 100,
                                            child: TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                '${_controller.paintingsModel!.painting!.artist!.name}',
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                         
                                           Positioned(
                                        top: 510,
                                        left: 60,
                                        child: Text(
                                          '${_controller.paintingsModel!.painting!.formattedCreationDate}',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 8,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                        ],
                                      ),
                                     
                         SizedBox(width:screenwidth *0.12),
                      TextButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              backgroundColor: Colors.orange[50],
                              title: Text(
                                'Reason for reporting',
                                style: TextStyle(color: Colors.black54, fontSize: 15),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    maxLines: 7,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Reason here...',
                                    ),
                                   controller: widget.complaintDescriptionController,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                               final newcomplaint = AddPaintingComplaint(
                               Description:widget.complaintDescriptionController.text,
                               ); 
                                     _controller.addPComplaint(
                                      addpaintingcopmlaint: newcomplaint,
                                      paintingId: widget.paintingId,
                                      );
                                       // _controller.submitReport();
                                        Get.back();
                                  },
                                  child: Text('Save', style: TextStyle(color: Colors.black45)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('Cancel', style: TextStyle(color: Colors.black45)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'Report the painting',
                          style: TextStyle(
                            color: Colors.orange[200],
                          ),
                        ),
                      ),
                                      
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenheight * 0.04,
                                  ),
                                  Text(
                                    'Title:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                      backgroundColor: Colors.black12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenheight * 0.01,
                                  ),
                                  Text(
                                    '${_controller.paintingsModel!.painting!.title}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenheight * 0.02,
                                  ),
                                  Text(
                                    'Type:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                      backgroundColor: Colors.black12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenheight * 0.01,
                                  ),
                                  Text(
                                    ' ${_controller.paintingsModel!.painting!.type!.typeName}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenheight * 0.02,
                                  ),
                                  if (_controller
                                          .paintingsModel!.painting!.size !=
                                      null) ...[
                                    Text(
                                      'Size:',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        backgroundColor: Colors.black12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenheight * 0.01,
                                    ),
                                    Text(
                                      ' ${_controller.paintingsModel!.painting!.size}',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                  SizedBox(
                                    height: screenheight * 0.02,
                                  ),
                                  if (_controller
                                          .paintingsModel!.painting!.price !=
                                      null) ...[
                                    Text(
                                      'Price:',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        backgroundColor: Colors.black12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenheight * 0.01,
                                    ),
                                    Text(
                                      ' ${_controller.paintingsModel!.painting!.price}',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                  SizedBox(
                                    height: screenheight * 0.02,
                                  ),
                                  Text(
                                    'Description:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                      backgroundColor: Colors.black12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Center(
                                        child: Container(
                                          height: screenheight * 0.1,
                                          width: screenwidth * 0.9,
                                          child: Text(
                                            ' ${_controller.paintingsModel!.painting!.description}',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenheight * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Rate:',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                          backgroundColor: Colors.black12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenwidth * 0.01,
                                      ),
                                      RatingBar.builder(
                                        initialRating:
                                            rating, // التقييم الابتدائي
                                        minRating: 1, // الحد الأدنى للتقييم
                                        direction:
                                            Axis.horizontal, // اتجاه التقييم
                                        allowHalfRating:
                                            true, // السماح بتقييم نصف نجمة
                                        itemCount: 5, // عدد النجوم
                                        itemSize: 20, // حجم النجوم
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                4.0), // المسافة بين النجوم
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (newRating) {
                                          setState(() {
                                            rating =
                                                newRating; 
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenheight * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Total Rate:',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                          backgroundColor: Colors.black12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenwidth * 0.02,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      Text(
                                        '${_controller.paintingsModel!.painting!.ratesNumber}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: screenwidth * 0.1,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                         // Get.offNamed(CheckoutPayment());
                                          Get.toNamed('/CheckoutPayment');
                                        },
                                        child: Text(
                                          'Buy Now',
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orangeAccent,
                                          padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                              top: 15,
                                              bottom: 15),
                                          elevation: 5,
                                          textStyle: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenwidth * 0.02,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          //Get.offNamed(PageHome());//Get.toNamed('/ChooseRole');
                                        },
                                       child:  Icon(
                                            Icons.shopping_bag,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orangeAccent,
                                          padding: const EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 5,
                                              bottom: 2),
                                          elevation: 5,
                                          textStyle: TextStyle(
                                            fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenheight * 0.03,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: screenwidth * 0.44,
                                        height: screenheight * 0.06,
                                        color: Colors.black12,
                                        child: TextButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Add a Comment',
                                                  style: TextStyle(
                                                    color: Colors.orange[200],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenwidth * 0.03,
                                                ),
                                                Text(
                                                  '(${_controller.paintingsModel!.painting!.commentsNumber})',
                                                  style: TextStyle(
                                                    color: Colors.orange[200],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Get.to(CommentView(
                                                id: _controller.paintingsModel!.painting!.id!,
                                                  apiUrl: UrlsApi
                                                      .paintingsCommentsApi
                                                      ));
                                            }),
                                      ),
                                      IconButton(
                                        onPressed: () async{
                                          AddPaintingLike likedetails = AddPaintingLike(Like: "like");
                                         await _controller.addLike_Painting(likedetails: likedetails, paintingId: _controller.paintingsModel!.painting!.id!);
                                         // _likedPreference();
                                        setState(() {
                                           Liked = !Liked;
                                           if (Liked) {
                                              DisLiked = false;
                                        }} );
                                        },
                                        icon: Icon(
                                          Liked
                                              ? Icons.thumb_up
                                              : Icons.thumb_up_alt_outlined,
                                          color:
                                              Liked ? Colors.blue : Colors.grey,
                                          size: 25,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: 
                                        () async{
                                          AddPaintingDisLike dislikedetails = AddPaintingDisLike(DisLike: "dislike");
                                         await _controller.addDisLike_Painting(dislikedetails: dislikedetails, paintingId: _controller.paintingsModel!.painting!.id!);
                                         // _dislikedPreference();
                                        setState(() {
                                           DisLiked = !DisLiked;
                                           if (DisLiked) {
                                              Liked = false;
                                        }
                                                   } );
                                        },
                                        
                                        icon: Icon(
                                          DisLiked
                                              ? Icons.thumb_down_alt
                                              : Icons.thumb_down_alt_outlined,
                                          //  Favorited?Icons.favorite:Icons.favorite_border,
                                          color: DisLiked
                                              ? Colors.blue
                                              : Colors.grey,
                                          size: 25,
                                        ),
                                      ),
                                      
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          '(${_controller.paintingsModel!.painting!.interactionsNumber})',
                                          style: TextStyle(
                                            color: const Color.fromARGB(255, 62, 31, 31),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })),
        ),
      ),
    );
  }

String determineSearchType(String PaintingType) {
  switch (_controller.paintingsModel!.painting!.typeId) {
    case '1':
      return 'Drawing art'; 

    case '2':
      return 'Graphic_Design'; 

    case '3':
      return 'Photography'; 

      case '4':
      return 'Sculpture'; 

    case '5':
      return 'printing_Art'; 

      case '6':
      return 'Mural_Art'; 

    case '7':
      return 'Mosaic'; 
    default:
      return 'Art';
  }
}
  
}
