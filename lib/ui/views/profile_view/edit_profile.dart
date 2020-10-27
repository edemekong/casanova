import 'package:cached_network_image/cached_network_image.dart';
import 'package:casanova/model/user/user.dart';
import 'package:casanova/services/auth_api/auth_api.dart';
import 'package:casanova/ui/views/profile_view/widget/select_image.dart';
import 'package:casanova/ui/views/widgets/button.dart';
import 'package:casanova/ui/views/widgets/text_field_wid.dart';
import 'package:casanova/view_models/profile_view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  Users users;
  final authApi = GetIt.I.get<AuthApi>();

  static String routeName = '/editprofile';

  EditProfile({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileModel = Provider.of<ProfileViewModel>(context);
    profileModel.firstNameController.text = users.firstName ?? '';
    profileModel.lastNameController.text = users.lastName ?? '';
    profileModel.emailController.text = users.email ?? '';
    profileModel.phoneNameController.text = users.phone ?? '';
    profileModel.addressController.text = users.address ?? '';
    profileModel.passwordController.text = '******';
    users = authApi.users;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: <Widget>[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.yellow,
                            child: profileModel.profileState ==
                                    ProfileState.Loading
                                ? Center(child: CircularProgressIndicator())
                                : null,
                            backgroundImage: users == null
                                ? null
                                : CachedNetworkImageProvider(users.imageUrl),
                          ),
                        ),
                        Positioned(
                          bottom: -4,
                          right: 90,
                          child: Tooltip(
                            message: 'Add Image',
                            child: MaterialButton(
                              onPressed: () => selectImage(context, users),
                              color: Colors.white,
                              shape: CircleBorder(),
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.add_a_photo,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Change Photo',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    TextFieldWidRounded(
                      title: 'First Name',
                      leadingIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      controller: profileModel.firstNameController,
                    ),
                    TextFieldWidRounded(
                      title: 'Last Name',
                      leadingIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      controller: profileModel.lastNameController,
                    ),
                    TextFieldWidRounded(
                      title: 'Phone',
                      leadingIcon: Icons.person_outline,
                      keyboardType: TextInputType.phone,
                      controller: profileModel.phoneNameController,
                    ),
                    TextFieldWidRounded(
                      title: 'Email',
                      leadingIcon: Icons.person_outline,
                      keyboardType: TextInputType.emailAddress,
                      controller: profileModel.emailController,
                    ),
                    TextFieldWidRounded(
                      title: 'Address',
                      leadingIcon: Icons.person_outline,
                      keyboardType: TextInputType.streetAddress,
                      controller: profileModel.addressController,
                      maxLine: 2,
                    ),
                    TextFieldWidRounded(
                      title: 'Password',
                      leadingIcon: Icons.person_outline,
                      keyboardType: TextInputType.visiblePassword,
                      controller: profileModel.passwordController,
                      enableTextField: false,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GradiantButton(
                        isOutline: false,
                        title: 'Update',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
