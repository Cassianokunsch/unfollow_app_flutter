import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/models/user.dart';

class CardUser extends StatelessWidget {
  final User user;
  const CardUser({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(user.profilePicUrl),
      ),
      title: Text(user.username),
      subtitle: Text(user.fullName),
      trailing: IconButton(
        color: Colors.white54,
        icon: Icon(Icons.delete),
        onPressed: () {
          print('object');
        },
      ),
    );
  }
}
