import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/components/card_user.dart';
import 'package:unfollow_app_flutter/models/user.dart';

class ListCardUser extends StatelessWidget {
  const ListCardUser({
    Key key,
    @required ScrollController scrollController,
    @required List<User> listUsers,
  })  : _scrollController = scrollController,
        _listUsers = listUsers,
        super(key: key);

  final ScrollController _scrollController;
  final List<User> _listUsers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _listUsers.length + 1,
      itemBuilder: (context, index) {
        if (index == _listUsers.length && (_listUsers.length + 1) == 2) {
          return Center(child: CircularProgressIndicator());
        }

        if ((_listUsers.length + 1) == 1) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Um erro ocorreu. Tente mais tarde!"),
              ],
            ),
          );
        }

        return CardUser(user: _listUsers[index]);
      },
    );
  }
}
