import 'package:sizer/sizer.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:untitled5/compomnt/artical_post.dart';
import 'package:untitled5/getx_bindings/artistPersonalAccountBinding.dart';
import 'package:untitled5/getx_bindings/profile_binding.dart';
import 'package:untitled5/modules/artist_personal_account/artist_personal_account.dart';
import 'package:untitled5/modules/checkout_payment/checkout_payment.dart';
import 'package:untitled5/modules/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' ;
import 'package:provider/provider.dart';
import 'package:untitled5/modules/gallery/gallery_display_view_controller.dart';
import 'package:untitled5/modules/payment_details/payment_details.dart';
import 'package:untitled5/modules/profile/profile_view.dart';
import 'modules/Painting list/add_new_painting.dart';
import 'modules/Painting list/painting_list.dart';
import 'modules/add photo/add_photo.dart';
import 'modules/article comments/article_comments.dart';
import 'modules/articles list/add_article.dart';
import 'modules/articles list/articles_list.dart';
import 'modules/articles/articles.dart';
import 'modules/articles_details/articles_details.dart';
import 'modules/certificate of reliability/certificate.dart';
import 'modules/choose role/choose_role.dart';
import 'modules/confrim code/confrim_code.dart';
import 'modules/gallery/add_gallery_details.dart';
import 'modules/gallery/gallery_display_view.dart';
import 'modules/gallery/page_view_holder.dart';
import 'modules/gallery3d/gallery3d.dart';
import 'modules/login/forget_password.dart';
import 'modules/login/loginn.dart';
import 'modules/navpar/navpar.dart';
import 'modules/painting details/painting _details.dart';
import 'modules/painting_home_page/page_home.dart';
import 'modules/register/registerr.dart';
import 'modules/welcome/welcome.dart';
import 'modules/welcome/welcome_controller.dart';
import 'package:email_otp/email_otp.dart';
void main() async {

GalleryDisplayViewController galleryController = GalleryDisplayViewController();
  Get.put(galleryController);

  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  print("what is the token ${AppSharedPreferences.getToken}");
   print("what is the role ${AppSharedPreferences.getRole}");
   print("what is the id ${AppSharedPreferences.getId}");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageViewHolder(value: 2.0)),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Sizer(
      builder: (context, orientation, deviceType)=>
       GetMaterialApp(
          initialRoute: '/Welcome/',
          // home: ConfrimCode(email: "nourghanem756@gmail.com"),
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.leftToRightWithFade,
          getPages: [
            // GetPage(name: '/Loginn/', page: () => Loginn()),
            // GetPage(name: '/Registerr/', page: () => Registerr()),
            GetPage(name: '/Filter/', page: () => Filter()),
            GetPage(name: '/Welcome/', page: () => Welcome()),
            // GetPage(name: '/PaintingDetails/', page: () => PaintingDetails()),
            //GetPage(name: '/Navpar/', page: () => Navpar()),
            // GetPage(name: '/ConfrimCode/', page: () =>ConfrimCode(myauth: EmailOTP(),)),
            GetPage(name: '/AddPhoto/', page: () => AddPhoto()),
            GetPage(name: '/ForgetPassword/', page: () => ForgetPassword()),
            GetPage(name: '/PhotoViewerScreen/', page: () => Gallery3d()),
            GetPage(name: '/Articles/', page: () => Articles()),
            //GetPage(name: '/ArticlesDetails', page: () => ArticlesDetails()),
            // GetPage(name: '/CommentView', page: () => CommentView()),
            GetPage(name: '/ChooseRole', page: () => ChooseRole()),
            GetPage(name: '/HomePage', page: () => HomePage()),
            //GetPage(name: '/PaintingList', page: () => PaintingList()),
            GetPage(name: '/AddGalleryDetails', page: () => AddGalleryDetails()),
            GetPage(name: '/GalleryDisplayView', page: () => GalleryDisplayView()),
            GetPage(name: '/AddNewPainting', page: () => AddNewPainting()),
          //  GetPage(name: '/ArticlesList', page: () => ArticlesList()),
            GetPage(name: '/AddArticle', page: () => AddArticle()),
            //GetPage(name: '/ArtistView', page: () => ArtistView()),

            //GetPage(name: '/MessagesScreen', page: () =>MessagesScreen()),

            GetPage( name: '/Profile', page: () => ProfileView(),binding: ProfileBinding()),
            GetPage(name: '/ArtistPersonalAccount',page: () => const ArtistPersonalAccount(),binding: ArtistPersonalAccountBinding()),
            GetPage(name: '/CheckoutPayment',page: () => const CheckoutPayment(),),
            GetPage(name: '/PaymentDetails',page: () => const PaymentDetails(),),
            GetPage(name: '/ArticalPost', page: () => const ArticalPost(),),
           //GetPage(name: '/View', page: () =>  View(),),

            
          ]),
    );
  }
}
