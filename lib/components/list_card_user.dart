import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/components/card_user.dart';
import 'package:unfollow_app_flutter/models/user.dart';

class ListCardUser extends StatelessWidget {
  final IconData icon;
  final Function onPressedIcon, onTap;

  const ListCardUser({
    Key key,
    @required ScrollController scrollController,
    @required List<User> listUsers,
    @required this.icon,
    @required this.onPressedIcon,
    @required this.onTap,
  })  : _scrollController = scrollController,
        _listUsers = listUsers,
        super(key: key);

  final ScrollController _scrollController;
  final List<User> _listUsers;

  _onPressedIcon(int index) {
    onPressedIcon(index);
  }

  _onTap(int index) {
    onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _listUsers.length + 1,
      itemBuilder: (context, index) {
        if (index == _listUsers.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return CardUser(
          user: _listUsers[index],
          icon: icon,
          onPressedIcon: () {
            _onPressedIcon(index);
          },
          onTap: () {
            _onTap(index);
          },
        );
      },
    );
  }
}
