import 'package:flutter/material.dart';

class CardUser extends StatelessWidget {
  final String img;
  final String fullName;
  final String username;
  final Function onDelete;

  const CardUser({this.img, this.fullName, this.username, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 8.0),
      child: InkWell(
        onTap: () {
          print('teste');
        },
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
                  image: NetworkImage(img),
                ),
              ),
            ),
            SizedBox(width: 15.0),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(username),
                  Text(fullName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black45)),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              color: Colors.red,
              icon: Icon(Icons.delete),
              onPressed: () {
                onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
