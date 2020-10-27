import 'package:casanova/ui/commons/sizes.dart';
import 'package:casanova/view_models/theme_view_model/theme_model.dart';
import 'package:flutter/material.dart';

class AddressName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaddingAll16(
      child: RichText(
        text: TextSpan(
          style: TextStyle(height: 1.5),
          children: [
            TextSpan(
              text: 'Paul Jeremiah\n',
              style: TextStyle(
                fontSize: 16,
                color: grey800,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Fort Church Rd, Trans Amadi Port Harcourt,\n',
              style: TextStyle(
                fontSize: 12,
                color: grey600,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Rivers, Nigeria',
              style: TextStyle(
                fontSize: 13,
                color: primaryColor,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
