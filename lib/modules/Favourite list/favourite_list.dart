/*import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Favourite%20list/favourity_list_controller.dart';

class FavouriteList extends StatefulWidget{
  const FavouriteList({Key? key,}) : super(key: key);

  
  @override
  State<FavouriteList> createState() => _FavouriteListState();

}
class _FavouriteListState extends State<FavouriteList> {
  final FavourityListController favourityController = Get.put(FavourityListController());
      
      
@override
  void initState() {
    super.initState();
     print("AppSharedPreferences.getId: ${AppSharedPreferences.getId}");
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text('Favority List',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: Obx((){
        if (favourityController.getfavourityState.value ==
                      getFavourityState.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (favourityController.getfavourityState.value == getFavourityState.error) {
                    return MaterialButton(
                      onPressed: () {
                     favourityController.getListFavourity(); 
                      },
                      child: Center(child: Container(
                        color: Colors.orange[100],
                        child: Text("Try agein"))),
                    );
                  }
                  if (favourityController.favourityListModel == null || 
                  favourityController.favourityListModel!.favourites == null||
                favourityController.favourityListModel!.favourites!.isEmpty
                  ) {
          return Center(child: Text('No Favourity available.'));
        }
        return ListView.builder(
          itemCount: favourityController.favourityListModel!.favourites!.length,

          itemBuilder: (context, index) {
            final favourity = favourityController.favourityListModel!.favourites![index];
            return Column(
               children: [
                Container(
                  height: screenheight,
                  child: Card(
                   // key:ValueKey(article.id),
                    child: ListTile(
                      leading: 
                      Container(
                        width: screenwidth*0.2,
                          height: screenheight*0.23,
                        child:  Positioned.fill(
                          child:  CachedNetworkImage(
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
                              imageUrl: UrlsApi.baseimageUrl+ favourity.painting!.url! ,
                              errorWidget: (context, url, error) => Container(
                                width: double.maxFinite,
                                height: screenheight * 0.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage(''),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                        ),
                    ),
                    
                      title: Text(favourity.painting!.title!),
                      //subtitle: Text(article.description!),
                      trailing: 
                      IconButton(onPressed: (){},
                      icon: Icon(Icons.favorite_border_outlined),
                      ),
                     //onTap: () => ,
                    ),
                  ),
                ),
                SizedBox(height: screenheight*0.01,),
              ],
            );
          }
          );
      }),
    );
  }
}*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled5/Services/Network/urls_api.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/modules/Favourite%20list/favourity_list_controller.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({Key? key}) : super(key: key);

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  // استخدام Get.put لربط الـ controller
  final FavourityListController favourityController = Get.put(FavourityListController());

  @override
  void initState() {
    super.initState();
    print("AppSharedPreferences.getId: ${AppSharedPreferences.getId}");
    favourityController.getListFavourity(); // جلب البيانات عند تحميل الصفحة
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text(
          'Favourite List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Obx(() {
        // حالة التحميل
        if (favourityController.getfavourityState.value == getFavourityState.loading) {
          return Center(child: CircularProgressIndicator());
        }
        // حالة الخطأ
        if (favourityController.getfavourityState.value == getFavourityState.error) {
          return Center(
            child: MaterialButton(
              onPressed: () {
                favourityController.getListFavourity(); // إعادة المحاولة
              },
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.orange[100],
                child: Text("Try Again"),
              ),
            ),
          );
        }
        // حالة عدم وجود بيانات
        if (favourityController.favourityListModel == null ||
            favourityController.favourityListModel!.favourites == null ||
            favourityController.favourityListModel!.favourites!.isEmpty) {
          return Center(child: Text('No Favourites available.'));
        }
        // حالة عرض البيانات
        return ListView.builder(
          itemCount: favourityController.favourityListModel!.favourites!.length,
          itemBuilder: (context, index) {
            final favourity = favourityController.favourityListModel!.favourites![index];
            return Column(
              children: [
                Container(
                  height: screenheight * 0.3, // تحديد ارتفاع مناسب لكل عنصر
                  child: Card(
                    child: ListTile(
                      leading:
                      
                       Container(
                        width: screenwidth * 0.2,
                        height: screenheight * 0.23,
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.5),
                            highlightColor: Colors.grey,
                            child: Container(
                              width: double.maxFinite,
                              height: screenheight * 0.23,
                              color: Colors.grey,
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: double.maxFinite,
                            height: screenheight * 0.23,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          fadeInDuration: const Duration(milliseconds: 400),
                          fadeOutDuration: const Duration(milliseconds: 400),
                          
                          imageUrl: favourity.painting?.url != null 
                          ? UrlsApi.baseimageUrl + favourity.painting!.url! 
                         : 'images/4.jpg',

                          errorWidget: (context, url, error) => Container(
                            width: double.maxFinite,
                            height: screenheight * 0.23,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/4.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    title: Text(favourity.painting?.title ?? "No Title Available"),
                      trailing: IconButton(
                        onPressed: () {
                          // منطق لإزالة أو تعديل المفضلة
                        },
                        icon: Icon(Icons.favorite_border_outlined),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenheight * 0.01),
              ],
            );
          },
        );
      }),
    );
  }
}
