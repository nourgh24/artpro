// import 'package:untitled5/App/app_localizations.dart';
// import 'package:untitled5/Bloc/profile_bloc/profile_bloc.dart';
// import 'package:untitled5/Core/Constants/app_colors.dart';
// import 'package:untitled5/Screens/Account/Widgets/avatar_info_widget.dart';
// import 'package:untitled5/Util/GeneralRoute.dart';
// import 'package:untitled5/Util/SharedPreferences/SharedPreferencesHelper.dart';
// import 'package:untitled5/Widgets/address_drop_down_widget.dart';
// import 'package:untitled5/Widgets/app_bar_widget.dart';
// import 'package:untitled5/Widgets/custom_button.dart';
// import 'package:untitled5/Widgets/custom_text_falid.dart';
// import 'package:untitled5/Widgets/loading_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:sizer/sizer.dart';

// class EditProfileScreen extends StatelessWidget {
//   EditProfileScreen({super.key});

//   final GlobalKey<FormState> formKey = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: appBarWidget(context, title: "Basic Info".tr(context)),
//         body: Form(
//           key: formKey,
//           child: BlocConsumer<ProfileBloc, ProfileState>(
//             listener: (context, state) {
//               // if (state is SetPersonalPhotoErrorState) {
//               //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               //     backgroundColor: AppColors.redColor,
//               //     duration: const Duration(seconds: 5),
//               //     content: Text(
//               //       state.message,
//               //     ),
//               //   ));
//               // }
//               // if (state is SetPersonalPhotoSuccesfulState) {
//               //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               //     backgroundColor: AppColors.greanColor,
//               //     duration: const Duration(seconds: 5),
//               //     content: Text(
//               //       "Succesfully".tr(context),
//               //     ),
//               //   ));
//               //   BlocProvider.of<ProfileBloc>(context)
//               //       .add(GetProfileEvent());
//               // }
//               if (state is EditProfileErrorState) {
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   backgroundColor: AppColors.redColor,
//                   duration: const Duration(seconds: 5),
//                   content: Text(
//                     state.message,
//                   ),
//                 ));
//               }
//               if (state is EditProfileSuccesfulState) {
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   backgroundColor: AppColors.greanColor,
//                   duration: const Duration(seconds: 5),
//                   content: Text(
//                     "Edit Profile Succesfully".tr(context),
//                   ),
//                 ));
//                 BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
//               }
//             },
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView(
//                       physics: const BouncingScrollPhysics(
//                           parent: AlwaysScrollableScrollPhysics()),
//                       shrinkWrap: true,
//                       children: [
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         AvatarInfoWidget(
//                           profileBloc: BlocProvider.of<ProfileBloc>(context),
//                           editButton: true,
//                           fileImage:
//                               BlocProvider.of<ProfileBloc>(context).fileImage,
//                           selectNewImage: (newImage) {
//                             BlocProvider.of<ProfileBloc>(context).fileImage =
//                                 newImage;
//                           },
//                         ),
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         if (state is GetProfileLoadingState) ...[
//                           const LoadingWidget()
//                         ] else if (state is GetProfileErrorState) ...[
//                           const SizedBox()
//                         ] else ...[
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 3.w),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: CustomTextField(
//                                     controller:
//                                         BlocProvider.of<ProfileBloc>(context)
//                                             .fisrtNameController,
//                                     textInputType: TextInputType.name,
//                                     hintText: "First Name".tr(context),
//                                     validator: (input) {
//                                       if (input!.isEmpty) {
//                                         return "Please Enter Your First Name"
//                                             .tr(context);
//                                       }

//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 2.w,
//                                 ),
//                                 Expanded(
//                                   child: CustomTextField(
//                                     controller:
//                                         BlocProvider.of<ProfileBloc>(context)
//                                             .lastNameController,
//                                     textInputType: TextInputType.name,
//                                     hintText: "Last Name".tr(context),
//                                     validator: (input) {
//                                       if (input!.isEmpty) {
//                                         return "Please Enter Your Last Name"
//                                             .tr(context);
//                                       }

//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 3.w),
//                             child: GestureDetector(
//                                 child: CustomTextField(
//                                   enabled: false,
//                                   controller:
//                                       BlocProvider.of<ProfileBloc>(context)
//                                           .birthDayController,
//                                   textInputType: TextInputType.datetime,
//                                   hintText: "Birthday".tr(context),
//                                   validator: (input) {
//                                     if (input!.isEmpty) {
//                                       return "Please Enter Your Birthday"
//                                           .tr(context);
//                                     }

//                                     return null;
//                                   },
//                                 ),
//                                 onTap: () async {
//                                   final datePick = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(1900),
//                                       lastDate: DateTime(2100));

//                                   if (context.mounted) {
//                                     if (datePick != null &&
//                                         datePick !=
//                                             BlocProvider.of<ProfileBloc>(
//                                                     context)
//                                                 .birthDate) {
//                                       BlocProvider.of<ProfileBloc>(context)
//                                           .birthDate = datePick;

//                                       BlocProvider.of<ProfileBloc>(context)
//                                               .birthDayController
//                                               .text =
//                                           "${BlocProvider.of<ProfileBloc>(context).birthDate!.month}/${BlocProvider.of<ProfileBloc>(context).birthDate!.day}/${BlocProvider.of<ProfileBloc>(context).birthDate!.year}";
//                                     }
//                                   }
//                                 }),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 3.w),
//                             child: CustomTextField(
//                               textDirection: TextDirection.ltr,
//                               textAlign: AppSharedPreferences.hasArLang
//                                   ? TextAlign.end
//                                   : TextAlign.start,
//                               controller: BlocProvider.of<ProfileBloc>(context)
//                                   .phoneController,
//                               textInputType: TextInputType.phone,
//                               hintText: "Phone".tr(context),
//                               validator: (input) {
//                                 if (input!.isEmpty) {
//                                   return "Please Enter Your Phone".tr(context);
//                                 }

//                                 return null;
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 3.w),
//                             child: CustomTextField(
//                               controller: BlocProvider.of<ProfileBloc>(context)
//                                   .emailController,
//                               textInputType: TextInputType.emailAddress,
//                               hintText: "Email".tr(context),
//                               validator: (input) {
//                                 if (input!.isEmpty) {
//                                   return "Please Enter Your Email".tr(context);
//                                 }

//                                 return null;
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 3.w),
//                             child: AddressDropDownWidget(
//                               addressController:
//                                   BlocProvider.of<ProfileBloc>(context)
//                                       .addressController,
//                             ),
//                           ),
//                         ]
//                       ],
//                     ),
//                   ),
//                   const Divider(
//                     color: AppColors.greyColor,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 2.w),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: CustomButton(
//                             textColor: AppColors.primaryColor,
//                             buttonColor: AppColors.whiteColor,
//                             onPressed: () {
//                               GeneralRoute.navigatorPobWithContext(context);
//                             },
//                             buttonText: "Cancel".tr(context),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 2.w,
//                         ),
//                         Expanded(
//                           child: state is EditProfileLoadingState
//                               ? Center(
//                                   child: SizedBox(
//                                       height: 8.h,
//                                       width: 16.w,
//                                       child: const LoadingWidget()),
//                                 )
//                               : CustomButton(
//                                 onPressed: () {
//                                   if (formKey.currentState!.validate()) {
//                                     BlocProvider.of<ProfileBloc>(context)
//                                         .add(EditProfileEvent());
//                                   }
//                                 },
//                                 buttonText: "Save".tr(context),
//                               ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 1.h,
//                   )
//                 ],
//               );
//             },
//           ),
//         ));
//   }
// }
