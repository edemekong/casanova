// import 'package:flutter/material.dart';
// import 'package:my_daily_wash/provider/product_services_prov.dart/address/address_prov.dart';
// import 'package:my_daily_wash/provider/product_services_prov.dart/cart_prov.dart';
// import 'package:my_daily_wash/ui/commons/sizes.dart';
// import 'package:my_daily_wash/ui/views/cart/order_cart.dart';
// import 'package:my_daily_wash/ui/views/drawer_pages/widgets/second_app_bar.dart';
// import 'package:my_daily_wash/ui/views/widgets/badge.dart';
// import 'package:my_daily_wash/view_models/theme_model.dart';
// import 'package:provider/provider.dart';

// import 'edit_address.dart';

// class MyAddress extends StatelessWidget {
//   final bool openFromCheckOut;

//   const MyAddress({Key key, this.openFromCheckOut}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('My Address'), actions: [
//         Consumer<CartProvider>(builder: (context, cartProv, child) {
//           return Badge(
//               child: IconButton(
//                   padding: const EdgeInsets.all(0),
//                   icon: Icon(
//                     Icons.shopping_cart_outlined,
//                     size: 25,
//                     color: Colors.grey[800],
//                   ),
//                   onPressed: () => Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (ctx) => OrderCart()))),
//               value: cartProv.itemCount.toString());
//         })
//       ]),
//       body: Consumer<AddressProv>(builder: (context, addressProv, child) {
//         return Column(
//           children: [
//             SecondAppBar(
//               isTrailingWid: true,
//               leadingText: 'MY ADDRESSES',
//               child: InkWell(
//                   onTap: addressProv.addressBook.length == 3
//                       ? null
//                       : () => Navigator.of(context).push(
//                           MaterialPageRoute(builder: (ctx) => EditAddress())),
//                   child: Icon(Icons.add,
//                       color: addressProv.addressBook.length == 3
//                           ? grey400
//                           : primaryButtonColor)),
//             ),
//             Expanded(
//               child: ListView.separated(
//                 itemCount: addressProv.addressBook.length,
//                 separatorBuilder: (ctx, i) => Divider(),
//                 itemBuilder: (ctx, i) {
//                   print(addressProv.addressBook.length);
//                   final houseOrOfficeAddress = addressProv.addressBook.values
//                       .toList()[i]
//                       .houseOrOfficeAddress;
//                   final addressId = addressProv.addressBook.keys.toList()[i];

//                   final state =
//                       addressProv.addressBook.values.toList()[i].state;
//                   final phone =
//                       addressProv.addressBook.values.toList()[i].phone;
//                   final addressType =
//                       addressProv.addressBook.values.toList()[i].addressType;

//                   return Container(
//                     padding: paddingAll16,
//                     child: Column(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 child: Row(
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Paul Jeremiah\n',
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                         Text(
//                                             '$houseOrOfficeAddress $state\nNigeria\n$addressType\n\n$phone'),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 InkWell(
//                                   child: Icon(
//                                     Icons.edit,
//                                     color: primaryButtonColor,
//                                   ),
//                                   onTap: () => Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                           builder: (ctx) => EditAddress(
//                                               addressId: addressId))),
//                                 ),
//                                 sizedBoxHeight20,
//                                 InkWell(
//                                   child: Icon(
//                                     Icons.delete,
//                                     color: primaryButtonColor,
//                                   ),
//                                   onTap: () =>
//                                       addressProv.removeAddress(addressId),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         openFromCheckOut == null || openFromCheckOut == false
//                             ? Container()
//                             : Column(
//                                 children: [
//                                   sizedBoxHeight16,
//                                   Divider(),
//                                   FlatButton(
//                                     onPressed: () {},
//                                     child: Text('Select Address'),
//                                     shape: StadiumBorder(),
//                                     color: Colors.orange[100],
//                                   ),
//                                 ],
//                               ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
