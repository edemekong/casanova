import 'package:flutter/material.dart';
import '../../../../ui/commons/sizes.dart';
import '../../../../ui/commons/styles.dart';
import '../../../../ui/views/chackout_view/widgets/checkout_nav.dart';
import '../../../../ui/views/widgets/card_wid.dart';
import '../../../../view_models/theme_view_model/theme_model.dart';
import '../../../../model/user/user.dart';

class PaymentPage extends StatefulWidget {
  final Function onTap;
  final Users user;

  const PaymentPage({Key key, this.onTap, this.user}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isChecked1 = true;
  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: Container(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PaddingVertical8Horizontal16(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SELECT A PAYMENT METHOD'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: grey500,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      CardWid(
                        child: CheckboxListTile(
                          value: true,
                          onChanged: (v) async {
                            // await paymentProv.swapToPayFromBank(v);
                          },
                          title: Text('PAY ON DELIVERY', style: titleOnCard),
                          // contentPadding: EdgeInsets.all(10),
                          subtitle: Text(
                            'Pay on delivery, you must follow the due proces your health is our no.1 piority...',
                            style: subTitleOnCard,
                          ),
                        ),
                      ),
                      CardWid(
                        child: CheckboxListTile(
                          value: true,
                          onChanged: (v) async {
                            // await paymentProv.swapToPayFromBank(v);
                          },
                          title: Text(
                            'PAY FROM BANK',
                            style: titleOnCard,
                          ),
                          // contentPadding: EdgeInsets.all(10),
                          subtitle: Text(
                            'Stay safe, go cashless with MY DAILY WASH...',
                            style: subTitleOnCard,
                          ),
                        ),
                      ),
                      // paymentProv.paymentMethodMap[CartProvider.PayFromBank]
                      //     ? CardWid(
                      //         child: Container(
                      //           height: 200,
                      //         ),
                      //       )
                      //     : Text(''),
                    ],
                  ),
                ),
              ],
            ),
          )),
          CartDetailsValue(
            addbutton: true,
            buttonTitle: 'PROCEED TO SUMMERY',
            ontap: () => widget.onTap(2),
          )
        ],
      ),
    );
  }
}
