import 'package:flutter/material.dart';
import '../../../../view_models/theme_view_model/theme_model.dart';

class DetailCard extends StatelessWidget {
  final String detialType;
  final VoidCallback onTapChange;
  final Widget body;

  DetailCard({this.detialType, this.onTapChange, this.body});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      detialType.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: grey500,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTapChange,
                      child: Text(
                        'CHANGE',
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryButtonColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  color: white,
                  width: MediaQuery.of(context).size.width,
                  child: body),
            ),
          ],
        ),
      ),
    );
  }
}
