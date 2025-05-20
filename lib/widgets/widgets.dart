library nrep_widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

export './setting_item.dart';
export './show_tips.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.message,
    this.style,
    this.height,
    this.width,
    this.circle,
  });

  final Text? message;
  final TextStyle? style;
  final double? height;
  final double? width;
  final CircularProgressIndicator? circle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: height ?? 18,
          width: width ?? 18,
          child: circle ?? const CircularProgressIndicator(),
        ),
        const SizedBox(width: 20),
        message ??
            Text(
              'LOADING...',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(color: theme.primaryColor),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(
                  duration: 1500.ms,
                  delay: 1000.ms,
                  color: theme.colorScheme.surface,
                ),
      ],
    );
  }
}

class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
    this.initialValue,
    this.prefixIcon,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onSaved,
    this.labelText,
    this.onFieldSubmitted,
    this.controller,
    this.maxLines,
    this.minLines,
  });

  final String? initialValue;
  final Icon? prefixIcon;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // final FocusScopeNode focusScope = FocusScope.of(context);
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      initialValue: initialValue,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelStyle: theme.textTheme.titleMedium,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: theme.primaryColor.withOpacity(0.0),
            width: 10,
          ),
        ),
      ),
      textInputAction: TextInputAction.next,
      // focusScope.focusedChild?.nextFocus() ?? false
      //     ? TextInputAction.next
      //     : TextInputAction.done,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}

class NormalField extends StatelessWidget {
  const NormalField({
    super.key,
    this.initialValue,
    this.prefixIcon,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onSaved,
    this.labelText,
    this.onFieldSubmitted,
    this.controller,
    this.enabled,
    this.suffixIcon,
  });

  final String? initialValue;
  final Icon? prefixIcon;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final bool? enabled;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // final FocusScopeNode focusScope = FocusScope.of(context);
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      enabled: enabled,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelStyle: theme.textTheme.titleMedium,
        border: const UnderlineInputBorder(
            // borderRadius: BorderRadius.circular(12),
            ),
        errorBorder: UnderlineInputBorder(
          // borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        focusedBorder: UnderlineInputBorder(
          // borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: theme.primaryColor),
        ),
      ),
      textInputAction: TextInputAction.next,
      // focusScope.focusedChild?.nextFocus() ?? false
      //     ? TextInputAction.next
      //     : TextInputAction.done,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.initialValue,
    this.prefixIcon,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onSaved,
    this.labelText,
    this.onFieldSubmitted,
    this.controller,
  });

  final String? initialValue;
  final Icon? prefixIcon;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // final FocusScopeNode focusScope = FocusScope.of(context);
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        labelStyle: theme.textTheme.titleMedium,
        suffixIcon: IconButton(
          style: IconButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: () => setState(() => isHidden = !isHidden),
          icon: isHidden
              ? const Icon(Icons.visibility_off_outlined)
              : const Icon(Icons.visibility_outlined),
        ),
        border: const UnderlineInputBorder(
            // borderRadius: BorderRadius.circular(12),
            ),
        errorBorder: UnderlineInputBorder(
          // borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        focusedBorder: UnderlineInputBorder(
          // borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: theme.primaryColor),
        ),
      ),
      obscureText: isHidden,
      textInputAction: TextInputAction.done,
      // focusScope.focusedChild?.nextFocus() ?? false
      //     ? TextInputAction.next
      //     : TextInputAction.done,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}

// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../helpers/constants.dart';
// import '../providers/auth_provider.dart';
//
// class BeekeeperForm extends StatefulWidget {
//   const BeekeeperForm({super.key});
//
//   static const routeName = '/form';
//
//   @override
//   State<BeekeeperForm> createState() => _BeekeeperFormState();
// }
//
// class _BeekeeperFormState extends State<BeekeeperForm> {
//   int currentStep = 0;
//   var _isLoading = false;
//
//   bool get isFirstStep => currentStep == 0;
//
//   bool get isLastStep => currentStep == steps().length - 1;
//   final String title = 'Know Your Customer Steps';
//   final String subTitle = 'Complete these steps to start working with us';
//   Map<String, dynamic>? chosenCountry;
//   File? _cardIDFront;
//   File? _cardIDBack;
//   File? _cardIDUser;
//   DateTime? _selectedDate;
//   bool canSkip = false;
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   final Map<String, String?> _kycData = {
//     'fullName': null,
//     'email': null,
//     'birthDay': null,
//     'phone': null,
//     'country': null,
//     'province': null,
//     'city': null,
//     'commune': null,
//     'quarter': null,
//     'homeNumber': null,
//   };
//   List<Map<String, dynamic>> countryList = [
//     {
//       'name': 'DRC',
//       'code': '+243',
//       'provinces': [
//         'Bas-Uele',
//         'Equateur',
//         'Heaut-Katanga',
//         'Haut-Lomami',
//         'Haut-Uele',
//         'Ituri',
//         'Kasai',
//         'Kasai-Central',
//         'Kasai-Oriental',
//         'Kinshasa',
//         'Kongo-central',
//         'Kwango',
//         'Kwilu',
//         'Lomami',
//         'Lualaba',
//         'Mai-Ndombe',
//         'Maniema',
//         'Mongala',
//         'Nord-Kivu',
//         'Nord-Ubangi',
//         'Sankuru',
//         'Sud-Kivu',
//         'Sud-Ubangi',
//         'Tanganyika',
//         'Tshopo',
//         'Tshuapa',
//       ],
//     },
//     {
//       'name': 'Rwanda',
//       'code': '+250',
//       'provinces': [
//         'Kigali',
//         'Southern',
//         'Western',
//         'Northern',
//         'Eastern',
//       ],
//     },
//   ];
//
//   void _resetLocation() {
//     _kycData['province'] = null;
//     _kycData['city'] = null;
//     _kycData['commune'] = null;
//     _kycData['quarter'] = null;
//     _kycData['homeNumber'] = null;
//   }
//
//   Future<void> _takePicture(
//       {required bool isFrontImage,
//       required bool useGallery,
//       required bool idWithUser}) async {
//     final picker = ImagePicker();
//     final imageFile = await picker.pickImage(
//       imageQuality: 100,
//       source: useGallery ? ImageSource.gallery : ImageSource.camera,
//       maxWidth: 300,
//       maxHeight: 300,
//     );
//     if (imageFile == null) {
//       return;
//     }
//     setState(() {
//       if (isFrontImage && !idWithUser) {
//         _cardIDFront = File(imageFile.path);
//       } else if (!isFrontImage && !idWithUser) {
//         _cardIDBack = File(imageFile.path);
//       } else if (idWithUser) {
//         _cardIDUser = File(imageFile.path);
//       }
//     });
//   }
//
//   void _birthDayPicker() {
//     showDatePicker(
//       context: context,
//       firstDate: DateTime(1990),
//       initialDate: DateTime.now(),
//       lastDate: DateTime.now(),
//     ).then((pickedDate) {
//       if (pickedDate == null) {
//         return;
//       }
//       if (pickedDate.isAfter(DateTime(DateTime.now().year - 10))) {
//         showToast(message: Text('Minimum 10 years old'), context: context);
//         return;
//       }
//       _kycData['birthDay'] = (_selectedDate ?? DateTime.now()) as String?;
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     });
//   }
//
//   List<Step> steps() {
//     final ThemeData theme = Theme.of(context);
//     final Size deviceSize = MediaQuery.of(context).size;
//     return [
//       Step(
//         state: currentStep > 0 ? StepState.complete : StepState.indexed,
//         isActive: currentStep >= 0,
//         title: Text(
//           'Complete the profile',
//           style: theme.textTheme.titleMedium,
//         ),
//         subtitle: Text(
//           'These information are taken from your ID card',
//           style: theme.textTheme.labelSmall,
//         ),
//         content: Column(
//           children: [
//             TextFormField(
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.red.shade900),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.person),
//                 hintText: 'Enter full names',
//               ),
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.text,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Can\'t be empty';
//                 }
//                 return null;
//               },
//               onFieldSubmitted: (value) {
//                 // focusScope.nextFocus();
//                 _kycData['fullName'] = value.trim();
//               },
//               onSaved: (value) => _kycData['fullName'] = value!.trim(),
//             ),
//             // InkWell(
//             //   onTap: _birthDayPicker,
//             //   child: Card(
//             //     color: theme.colorScheme.secondary.withOpacity(0.6),
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(50),
//             //       side: BorderSide(
//             //         color: theme.primaryColor,
//             //         width: 1,
//             //       ),
//             //     ),
//             //     margin: const EdgeInsets.all(10),
//             //     child: SizedBox(
//             //       height: 50,
//             //       child: Padding(
//             //         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//             //         child: Row(
//             //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //           children: [
//             //             Text(
//             //               _selectedDate == null
//             //                   ? 'Your BirthDay'
//             //                   : '${_selectedDate?.toLocal()}',
//             //               style: theme.textTheme.titleMedium,
//             //             ),
//             //             const Icon(Icons.calendar_month),
//             //           ],
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             TextFormField(
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.red.shade900),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.person),
//                 hintText: 'Email',
//               ),
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.emailAddress,
//               validator: (value) {
//                 if (value!.isEmpty ||
//                     !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                         .hasMatch(value)) {
//                   return 'Invalid email!';
//                 }
//                 return null;
//               },
//               onFieldSubmitted: (value) {
//                 // _birthDayPicker();
//                 _kycData['email'] = value.trim();
//               },
//               onSaved: (value) => _kycData['email'] = value!.trim(),
//             ),
//             // PopupMenuButton(
//             //   elevation: 5,
//             //   shape: RoundedRectangleBorder(
//             //     borderRadius: BorderRadius.circular(20),
//             //   ),
//             //   color: theme.primaryColorLight,
//             //   child: Card(
//             //     color: theme.colorScheme.secondary.withOpacity(0.6),
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(50),
//             //       side: BorderSide(
//             //         color: theme.primaryColor,
//             //         width: 1,
//             //       ),
//             //     ),
//             //     margin: const EdgeInsets.all(10),
//             //     child: SizedBox(
//             //       height: 50,
//             //       child: Padding(
//             //         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//             //         child: Row(
//             //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //           children: [
//             //             Text(
//             //               chosenCountry?['code'] ?? 'Your Country',
//             //               style: theme.textTheme.titleMedium,
//             //             ),
//             //             Text(
//             //               chosenCountry?['name'] ?? '',
//             //               style: theme.textTheme.titleMedium,
//             //             ),
//             //             const Icon(Icons.expand_more),
//             //           ],
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             //   itemBuilder: (BuildContext context) {
//             //     return countryList
//             //         .map(
//             //           (country) => PopupMenuItem(
//             //             onTap: () => setState(() {
//             //               chosenCountry = country;
//             //               _kycData['country'] = country['name'];
//             //               _resetLocation();
//             //             }),
//             //             child: ListTile(
//             //               title: Text(
//             //                 country['name'],
//             //                 style: TextStyle(
//             //                   color: theme.primaryColor,
//             //                   fontWeight: FontWeight.bold,
//             //                 ),
//             //                 maxLines: 2,
//             //                 overflow: TextOverflow.ellipsis,
//             //               ),
//             //             ),
//             //           ),
//             //         )
//             //         .toList();
//             //   },
//             // ),
//             TextFormField(
//               key: const ValueKey('phone'),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.red.shade900),
//               decoration: InputDecoration(
//                 prefix: Text(
//                   chosenCountry?['code'] ?? '',
//                   style: TextStyle(
//                     color: Colors.red.shade900,
//                     fontSize: 16,
//                   ),
//                 ),
//                 prefixIcon: const Icon(CupertinoIcons.phone),
//                 hintText: 'Enter your phone number :',
//               ),
//               textInputAction: TextInputAction.done,
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value!.length != 9 && value != '') {
//                   return 'Consider your number without a 0 at the beginning.Too short or too long';
//                 } else if (value.isEmpty) {
//                   return 'Can\'t be empty';
//                 }
//                 return null;
//               },
//               onFieldSubmitted: (value) => _kycData['phone'] = value.trim(),
//               onSaved: (value) => _kycData['phone'] = value!.trim(),
//             ),
//           ],
//         ),
//       ),
//       Step(
//         state: currentStep > 1 ? StepState.complete : StepState.indexed,
//         isActive: currentStep >= 1,
//         title: Text(
//           'Physical location',
//           style: theme.textTheme.titleMedium,
//         ),
//         subtitle: Text(
//           'Complete your actual location',
//           style: theme.textTheme.labelSmall,
//         ),
//         content: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // PopupMenuButton(
//             //   elevation: 5,
//             //   shape: RoundedRectangleBorder(
//             //     borderRadius: BorderRadius.circular(20),
//             //   ),
//             //   color: theme.primaryColorLight,
//             //   child: Card(
//             //     color: theme.colorScheme.secondary.withOpacity(0.6),
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(50),
//             //       side: BorderSide(
//             //         color: theme.primaryColor,
//             //         width: 1,
//             //       ),
//             //     ),
//             //     margin: const EdgeInsets.all(10),
//             //     child: SizedBox(
//             //       height: 50,
//             //       child: Padding(
//             //         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//             //         child: Row(
//             //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //           children: [
//             //             Text(
//             //               _kycData['province'] ?? 'Your province',
//             //               style: theme.textTheme.titleMedium,
//             //             ),
//             //             const Icon(Icons.expand_more),
//             //           ],
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             //   itemBuilder: (BuildContext context) {
//             //     List provincesList = chosenCountry?['provinces'] ?? [];
//             //     return provincesList
//             //         .map(
//             //           (province) => PopupMenuItem(
//             //             onTap: () =>
//             //                 setState(() => _kycData['province'] = province),
//             //             child: ListTile(
//             //               title: Text(
//             //                 province,
//             //                 style: TextStyle(
//             //                   color: theme.primaryColor,
//             //                   fontWeight: FontWeight.bold,
//             //                 ),
//             //                 maxLines: 2,
//             //                 overflow: TextOverflow.ellipsis,
//             //               ),
//             //             ),
//             //           ),
//             //         )
//             //         .toList();
//             //   },
//             // ),
//             TextFormField(
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.red.shade900),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.map),
//                 hintText: 'Town / city',
//               ),
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.text,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Can\'t be empty';
//                 }
//                 return null;
//               },
//               onFieldSubmitted: (value) => _kycData['city'] = value.trim(),
//               onSaved: (value) => _kycData['city'] = value!.trim(),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.red.shade900),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.map_outlined),
//                 hintText: 'Commune',
//               ),
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.text,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Can\'t be empty';
//                 }
//                 return null;
//               },
//               onFieldSubmitted: (value) => _kycData['commune'] = value.trim(),
//               onSaved: (value) => _kycData['commune'] = value!.trim(),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.red.shade900),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.location_on_outlined),
//                 hintText: 'Neighborhood',
//               ),
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.text,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Can\'t be empty';
//                 }
//                 return null;
//               },
//               onFieldSubmitted: (value) => _kycData['quarter'] = value.trim(),
//               onSaved: (value) => _kycData['quarter'] = value!.trim(),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.red.shade900),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.maps_home_work),
//                 hintText: 'Home Number',
//               ),
//               textInputAction: TextInputAction.done,
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Can\'t be empty';
//                 }
//                 return null;
//               },
//               onFieldSubmitted: (value) =>
//                   _kycData['homeNumber'] = value.trim(),
//               onSaved: (value) => _kycData['homeNumber'] = value!.trim(),
//             ),
//           ],
//         ),
//       ),
//       Step(
//         state: currentStep > 2 ? StepState.complete : StepState.indexed,
//         isActive: currentStep >= 2,
//         title: Text(
//           'Identity card',
//           style: theme.textTheme.titleMedium,
//         ),
//         subtitle: Text(
//           'Provide the picture of your ID card',
//           style: theme.textTheme.labelSmall,
//         ),
//         content: Column(
//           children: [
//             InkWell(
//               onTap: () => _takePicture(
//                 isFrontImage: true,
//                 useGallery: false,
//                 idWithUser: false,
//               ),
//               borderRadius: BorderRadius.circular(17),
//               child: Container(
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2,
//                     color: theme.primaryColor,
//                   ),
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     SizedBox(
//                       width: deviceSize.width * 0.7,
//                       height: deviceSize.width * 0.4,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(17),
//                         child: _cardIDFront == null
//                             ? Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Icon(
//                                     Icons.add_photo_alternate_outlined,
//                                     color: theme.primaryColor,
//                                     size: 60,
//                                   ),
//                                   SizedBox(height: deviceSize.height * 0.01),
//                                   Text(
//                                     'Tap to add front ID Card picture',
//                                     style: TextStyle(
//                                       color: theme.primaryColor,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ],
//                               )
//                             : Image.file(
//                                 _cardIDFront!,
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 5.0),
//                       child: ElevatedButton.icon(
//                         icon: const Icon(Icons.image_outlined),
//                         onPressed: () => _takePicture(
//                           isFrontImage: true,
//                           useGallery: true,
//                           idWithUser: false,
//                         ),
//                         label: Text('Use Gallery'
//                             // AppLocalizations.of(context)!.useGallery,
//                             ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () => _takePicture(
//                 isFrontImage: false,
//                 useGallery: false,
//                 idWithUser: false,
//               ),
//               borderRadius: BorderRadius.circular(17),
//               child: Container(
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2,
//                     color: theme.primaryColor,
//                   ),
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     SizedBox(
//                       width: deviceSize.width * 0.7,
//                       height: deviceSize.width * 0.4,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(17),
//                         child: _cardIDBack == null
//                             ? Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Icon(
//                                     Icons.add_photo_alternate_outlined,
//                                     color: theme.primaryColor,
//                                     size: 60,
//                                   ),
//                                   SizedBox(height: deviceSize.height * 0.01),
//                                   Text(
//                                     'Tap to add back ID Card picture',
//                                     style: TextStyle(
//                                       color: theme.primaryColor,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ],
//                               )
//                             : Image.file(
//                                 _cardIDBack!,
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 5.0),
//                       child: ElevatedButton.icon(
//                         icon: const Icon(Icons.image_outlined),
//                         onPressed: () => _takePicture(
//                           isFrontImage: false,
//                           useGallery: true,
//                           idWithUser: false,
//                         ),
//                         label: Text('Use Gallery'
//                             // AppLocalizations.of(context)!.useGallery,
//                             ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       Step(
//         state: currentStep > 2 ? StepState.complete : StepState.indexed,
//         isActive: currentStep >= 2,
//         title: Text(
//           'Identity card proof',
//           style: theme.textTheme.titleMedium,
//         ),
//         subtitle: Text(
//           'Provide the picture of your ID card in your hand around your face',
//           style: theme.textTheme.labelSmall,
//         ),
//         content: Column(
//           children: [
//             InkWell(
//               onTap: () => _takePicture(
//                 isFrontImage: false,
//                 useGallery: false,
//                 idWithUser: true,
//               ),
//               borderRadius: BorderRadius.circular(17),
//               child: Container(
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2,
//                     color: theme.primaryColor,
//                   ),
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     SizedBox(
//                       width: deviceSize.width * 0.5,
//                       height: deviceSize.width * 0.7,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(17),
//                         child: _cardIDUser == null
//                             ? Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Icon(
//                                     Icons.add_photo_alternate_outlined,
//                                     color: theme.primaryColor,
//                                     size: 60,
//                                   ),
//                                   SizedBox(height: deviceSize.height * 0.01),
//                                   Text(
//                                     'ID Card picture around your face',
//                                     style: TextStyle(
//                                       color: theme.primaryColor,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ],
//                               )
//                             : Image.file(
//                                 _cardIDUser!,
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 5.0),
//                       child: ElevatedButton.icon(
//                         icon: const Icon(Icons.image_outlined),
//                         onPressed: () => _takePicture(
//                           isFrontImage: false,
//                           useGallery: true,
//                           idWithUser: true,
//                         ),
//                         label: Text('Use Gallery'
//                             // AppLocalizations.of(context)!.useGallery,
//                             ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       Step(
//         state: currentStep > 3 ? StepState.complete : StepState.indexed,
//         isActive: currentStep >= 3,
//         title: Text(
//           'Submission',
//           style: theme.textTheme.titleMedium,
//         ),
//         subtitle: Text(
//           'Last  verification of provided information',
//           style: theme.textTheme.labelSmall,
//         ),
//         content: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Full names : ${_kycData['fullName']}',
//               style: theme.textTheme.titleMedium,
//             ),
//             Text(
//               'Email : ${_kycData['email']}',
//               style: theme.textTheme.titleMedium,
//             ),
//             Text(
//               'Birth Day : ${_kycData['birthDay']}',
//               style: theme.textTheme.titleMedium,
//             ),
//             Text(
//               'Phone number : 0${_kycData['phone']}',
//               style: theme.textTheme.titleMedium,
//             ),
//             Text(
//               'Country : ${_kycData['country']}',
//               style: theme.textTheme.titleMedium,
//             ),
//             Text(
//               'Province : ${_kycData['province']}',
//               style: theme.textTheme.titleMedium,
//             ),
//             Text(
//               'City : ${_kycData['city']}',
//               style: theme.textTheme.titleMedium,
//             ),
//             Text(
//               'Commune : ${_kycData['commune']}',
//               style: theme.textTheme.titleMedium,
//             ),
//             Text(
//               'Neighborhood : ${_kycData['quarter']}',
//               style: theme.textTheme.titleMedium,
//             ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //   children: [
//             //     Text(
//             //       'Front ID Card',
//             //       style: theme.textTheme.titleMedium,
//             //     ),
//             //     Icon(
//             //       _cardIDFront == null
//             //           ? Icons.check_circle_outline
//             //           : Icons.check_circle,
//             //       color: theme.primaryColor,
//             //     ),
//             //     Text(
//             //       'Back ID Card',
//             //       style: theme.textTheme.titleMedium,
//             //     ),
//             //     Icon(
//             //       _cardIDBack == null
//             //           ? Icons.check_circle_outline
//             //           : Icons.check_circle,
//             //       color: theme.primaryColor,
//             //     ),
//             //   ],
//             // ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //   children: [
//             //     Text(
//             //       'Front Card & user\'s face',
//             //       style: theme.textTheme.titleMedium,
//             //     ),
//             //     Icon(
//             //       _cardIDUser == null
//             //           ? Icons.check_circle_outline
//             //           : Icons.check_circle,
//             //       color: theme.primaryColor,
//             //     ),
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final userData = Provider.of<Auth>(context, listen: false);
//     final FocusScopeNode focusScope = FocusScope.of(context);
//     final Map<String, dynamic>? routeParams =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//     if (routeParams != null) {
//       canSkip = routeParams['canSkip'] ?? canSkip;
//     }
//     Future<void> updateKyc() async {
//       focusScope.unfocus();
//       if (!_formKey.currentState!.validate()) {
//         return;
//       }
//       _formKey.currentState?.save();
//       setState(() {
//         _isLoading = true;
//       });
//       try {
//         // await userData.verifyKyc(
//         //   fullName: _kycData['fullName'].toString(),
//         //   birthDay: _kycData['birthDay'].toString(),
//         //   email: _kycData['email'].toString(),
//         //   country: _kycData['country'].toString(),
//         //   phone: _kycData['phone'].toString(),
//         //   province: _kycData['province'].toString(),
//         //   city: _kycData['city'].toString(),
//         //   commune: _kycData['commune'].toString(),
//         //   quarter: _kycData['quarter'].toString(),
//         //   homeNumber: _kycData['homeNumber'].toString(),
//         //   frontCard: _cardIDFront,
//         //   backCard: _cardIDBack,
//         //   userWithCard: _cardIDUser,
//         //   context: context,
//         // );
//       } catch (error) {
//         print('error ============== $error');
//       }
//       // setState(() {
//       // _isLoading = false;
//       // });
//     }
//
//     void nextForm() {
//       _formKey.currentState?.save();
//       if ((currentStep == 0) &&
//           (_kycData['fullName'] == null ||
//               _kycData['birthDay'] == null ||
//               _kycData['email'] == null ||
//               _kycData['country'] == null ||
//               _kycData['phone'] == null)) {
//         showToast(message: Text('Complete all the field'), context: context);
//         // return;
//       } else if ((currentStep == 1) &&
//           (_kycData['province'] == null ||
//               _kycData['city'] == null ||
//               _kycData['commune'] == null ||
//               _kycData['quarter'] == null ||
//               _kycData['homeNumber'] == null)) {
//         showToast(message: Text('Complete all the field'), context: context);
//         // return;
//       } else if ((currentStep == 2) &&
//           (_cardIDFront == null || _cardIDBack == null)) {
//         showToast(message: Text('Complete all the images'), context: context);
//         // return;
//       } else if ((currentStep == 3) && (_cardIDUser == null)) {
//         showToast(message: Text('Provide this image'), context: context);
//         // return;
//       }
//
//       if (isLastStep) {
//         updateKyc();
//       } else {
//         setState(() => currentStep += 1);
//       }
//     }
//
//     void prevForm() {
//       if (!isFirstStep) {
//         setState(() => currentStep -= 1);
//       }
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('KYC'),
//         actions: [
//           if (_isLoading)
//             const SizedBox(
//               width: 18,
//               height: 18,
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//               ),
//             ),
//           if (!_isLoading && canSkip)
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text(
//                 'Skip',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//             ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: theme.textTheme.headlineSmall,
//               textAlign: TextAlign.start,
//             ).animate().slideY(duration: 800.ms),
//             const SizedBox(height: 7),
//             Text(
//               subTitle,
//               style: theme.textTheme.titleMedium
//                   ?.copyWith(fontWeight: FontWeight.normal),
//               textAlign: TextAlign.start,
//             ).animate().slideY(duration: 600.ms),
//             const SizedBox(height: 7),
//             Form(
//               key: _formKey,
//               child: Stepper(
//                 steps: steps(),
//                 currentStep: currentStep,
//                 // type: StepperType.horizontal,
//                 controlsBuilder: (context, details) => Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: !_isLoading
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             if (!isFirstStep)
//                               TextButton(
//                                 onPressed: details.onStepCancel,
//                                 child: const Text('Back'),
//                               ),
//                             ElevatedButton.icon(
//                               icon: Icon(isLastStep ? Icons.send : Icons.check),
//                               onPressed: details.onStepContinue,
//                               label:
//                                   Text(isLastStep ? 'Send KYC' : 'Next Step'),
//                             )
//                           ],
//                         )
//                       : null,
//                 ),
//                 onStepContinue: nextForm,
//                 onStepCancel: prevForm,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
