// import 'package:flutter/material.dart';
// import 'package:my_daily_wash/provider/product_services_prov.dart/address/address_prov.dart';
// import 'package:my_daily_wash/provider/product_services_prov.dart/address/address_textfields_controllers.dart';
// import 'package:my_daily_wash/ui/commons/sizes.dart';
// import 'package:my_daily_wash/ui/views/widgets/button.dart';
// import 'package:my_daily_wash/ui/views/widgets/text_field_wid.dart';
// import 'package:my_daily_wash/view_models/theme_model.dart';
// import 'package:provider/provider.dart';

// class EditAddress extends StatefulWidget {
//   final String addressId;

//   const EditAddress({Key key, this.addressId}) : super(key: key);
//   @override
//   _EditAddressState createState() => _EditAddressState();
// }

// class _EditAddressState extends State<EditAddress> {
//   bool _isSelectHomeAddress = true;
//   bool _isSelectOfficeAddress = false;
//   String _pickedAddress = 'Home Address';

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Address'),
//       ),
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 color: lightOrange,
//                 height: 50,
//                 width: screenSize.width,
//                 padding: paddingAll16,
//                 child: Text('EDIT ADDRESS'),
//               ),
//               Expanded(
//                 flex: 10,
//                 child: _textFields(context),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   ListView _textFields(BuildContext context) {
//     return ListView(
//       padding: paddingAll16,
//       children: [
//         // DropDownWidget(
//         //   isExpand: true,
//         //   btn1SelectedVal: _btn1SelectedVal,
//         //   dropDownMenuItems: _dropdownContryItem,
//         // ),

//         _isSelectOfficeAddress
//             ? TextFieldWidRounded(
//                 title: 'Road',
//                 controller: AddressTextfeild.roadOrStreet,
//                 keyboardType: TextInputType.streetAddress,
//                 // removeIcon: true,
//               )
//             : TextFieldWidRounded(
//                 title: 'Street',
//                 controller: AddressTextfeild.roadOrStreet,
//                 keyboardType: TextInputType.streetAddress,

//                 // removeIcon: true,
//               ),
//         TextFieldWidRounded(
//           title: 'State',
//           controller: AddressTextfeild.state,
//           keyboardType: TextInputType.streetAddress,

//           // removeIcon: true,
//         ),
//         TextFieldWidRounded(
//           title: 'Accurate Address',
//           controller: AddressTextfeild.accurateAddress,
//           keyboardType: TextInputType.streetAddress,

//           // removeIcon: true,
//         ),
//         TextFieldWidRounded(
//           title: 'Phone',
//           controller: AddressTextfeild.phone,
//           keyboardType: TextInputType.phone,

//           // removeIcon: true,
//         ),
//         sizedBoxWidth20,
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               InputChip(
//                 label: Text('Home Address'),
//                 selected: _isSelectHomeAddress,
//                 selectedColor: primaryColor,
//                 onSelected: (v) {
//                   if (v == true) {
//                     setState(() {
//                       _pickedAddress = 'Home Address';
//                     });
//                   } else {
//                     setState(() {
//                       _pickedAddress = '';
//                     });
//                   }
//                   setState(() {
//                     _isSelectHomeAddress = v;
//                     _isSelectOfficeAddress = false;
//                   });
//                 },
//               ),
//               InputChip(
//                 label: Text('Office Address'),
//                 selected: _isSelectOfficeAddress,
//                 selectedColor: primaryColor,
//                 onSelected: (v) {
//                   if (v == true) {
//                     setState(() {
//                       _pickedAddress = 'Office Address';
//                     });
//                   } else {
//                     setState(() {
//                       _pickedAddress = '';
//                     });
//                   }
//                   setState(() {
//                     _isSelectOfficeAddress = v;
//                     _isSelectHomeAddress = false;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Consumer<AddressProv>(builder: (context, addressProv, child) {
//             return raisedButtonAcrossApp(
//               context,
//               title: 'ADD',
//               onTap: _pickedAddress.isEmpty
//                   ? null
//                   : () async {
//                       print(AddressTextfeild.phone.text);
//                       print(_pickedAddress);
//                       await addressProv.addAddress(
//                         addressId: widget.addressId == null
//                             ? DateTime.now().toString()
//                             : widget.addressId,
//                         addressType: '$_pickedAddress',
//                         houseOrOfficeAddress:
//                             "${AddressTextfeild.houseOrOfficeNo.text} ${AddressTextfeild.roadOrStreet.text} ",
//                         state: AddressTextfeild.state.text,
//                         phone: AddressTextfeild.phone.text,
//                       );
//                       // print(addressProv.addressBook.values.toList()[0].phone);
//                       Navigator.pop(context);
//                     },
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
