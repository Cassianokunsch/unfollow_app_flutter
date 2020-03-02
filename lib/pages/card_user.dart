import 'package:flutter/material.dart';

class CardUser extends StatelessWidget {
  final String _img;
  final String _fullName;
  final String _username;
  final Function _onDeleteUser;

  CardUser(this._fullName, this._img, this._username, this._onDeleteUser);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black26,
                width: 1,
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(_img),
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_username),
                Text(_fullName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black45)),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.delete),
            onPressed: _onDeleteUser,
          ),
        ],
      ),
    );
  }
}
