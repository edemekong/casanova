import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../.././model/user/user.dart';
import '../../.././services/auth_api/auth_api.dart';
import '../../.././ui/commons/sizes.dart';
import '../../.././ui/views/order_view/order_status.dart';

import 'edit_profile.dart';

class ProfileView extends StatelessWidget {
  static String routeName = '/profile';
  final authApi = GetIt.I.get<AuthApi>();

  @override
  Widget build(BuildContext context) {
    final user = authApi.users;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => EditProfile(users: user)));
            },
          ),
        ],
      ),
      body: Profile(),
    );
  }
}

class Profile extends StatelessWidget {
  final authApi = GetIt.I.get<AuthApi>();

  @override
  Widget build(BuildContext context) {
    final user = authApi.users;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          _header(context, user),
          _contentBuilder(
            context,
            title: 'User Details',
            body: [
              _contextText(
                context,
                title: 'First name',
                subtitle: '${user.firstName}',
              ),
              SizedBox(height: 20),
              _contextText(
                context,
                title: 'Last name',
                subtitle: '${user.lastName}',
              ),
              SizedBox(height: 20),
              _contextText(
                context,
                title: 'Phone',
                subtitle: '${user.phone}',
              ),
              SizedBox(height: 20),
              _contextText(
                context,
                title: 'Email',
                subtitle: '${user.email}',
              ),
              SizedBox(height: 20),
              _contextText(
                context,
                title: 'Password',
                subtitle: '**********',
              ),
            ],
            height: 250,
          ),
          _contentBuilder(
            context,
            title: 'Recent order',
            body: List.generate(
                4,
                (i) => Column(
                      children: [
                        ListTile(
                            title: Text('5645645'),
                            subtitle: Text('2020-04-17'),
                            trailing: Text('N 12342'),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => OrderStatus()))),
                        Divider(height: 0),
                      ],
                    )),
            height: 250,
          ),
        ],
      ),
    );
  }

  Widget _header(context, Users user) {
    return Container(
      padding: paddingAll16,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange[100],
              radius: 60,
              child: CircleAvatar(
                  radius: 59,
                  backgroundImage: CachedNetworkImageProvider(user.imageUrl)),
            ),
            SizedBox(height: 6),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '${user.fullName}\n',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: '${user.email}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _contentBuilder(BuildContext context,
      {String title, List<Widget> body, double height}) {
    return IntrinsicHeight(
      child: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey),
                  )),
            ),
            Expanded(
              // flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: body,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _contextText(context, {String title, String subtitle, Color color}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title\n',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
          TextSpan(
            text: '$subtitle',
            style: TextStyle(
              color: color == null ? Colors.black : color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
