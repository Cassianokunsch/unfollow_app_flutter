import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/models/user.dart';

class UserInfoScreen extends StatelessWidget {
  final User me;
  UserInfoScreen(this.me);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildBody(this.me),
      ),
    );
  }

  Container buildBody(User me) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(me.profilePicUrl),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(me.fullName),
                      Text('@' + me.username),
                      SizedBox(height: 20),
                      //Text(me.biography),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
