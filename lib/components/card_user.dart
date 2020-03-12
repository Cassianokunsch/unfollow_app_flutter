import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/models/user.dart';

class CardUser extends StatelessWidget {
  final User user;
  final IconData icon;
  final Function onPressedIcon, onTap;

  const CardUser({
    Key key,
    @required this.user,
    @required this.icon,
    @required this.onPressedIcon,
    @required this.onTap,
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
        icon: Icon(icon),
        onPressed: () {
          onPressedIcon();
        },
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
