import 'package:flutter/material.dart';
import '../../../../ui/commons/sizes.dart';
import '../../../../ui/views/widgets/button.dart';
import '../../../../ui/views/widgets/text_field_wid.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.call, color: Colors.white),
        label: Text('Call Instead', style: TextStyle(color: Colors.white)),
        onPressed: () {},
      ),
      body: PaddingAll16(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFieldWidRounded(
                  title: 'Name',
                ),
                TextFieldWidRounded(
                  title: 'Subject',
                ),
                TextFieldWidRounded(
                  title: 'Feedback',
                  maxLine: 6,
                ),
                sizedBoxHeight16,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: raisedButtonAcrossApp(
                    context,
                    title: 'SEND',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
