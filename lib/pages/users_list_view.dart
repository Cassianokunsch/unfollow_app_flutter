import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/pages/card_user.dart';

class UserList extends StatefulWidget {
  static String tag = '/';
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List _listUsers = List();

  _onDeleteUser(index) {
    _listUsers.removeAt(index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seguidores"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _listUsers.length,
          itemBuilder: (context, index) {
            return CardUser(
                _listUsers[index]['fullName'],
                _listUsers[index]['profilePicUrl'],
                _listUsers[index]['username'],
                () => this._onDeleteUser(index));
          },
        ),
      ),
    );
  }

  loadUsers() async {
    List _myListUnfollowers = [
      {
        "pk": "7465871688",
        "username": "heloisa_araujo35",
        "fullName": "HELO💝",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/77197290_447971942515446_580893901582237696_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=k9xaYtwNxm4AX_U77Ox&oh=21f32fcd7407235c621e4df6c7879054&oe=5E999469"
      },
      {
        "pk": "9946824768",
        "username": "baconfazbemcom",
        "fullName": "Bacon Faz Bem Com...",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/47584587_1960608734036779_7611704534196289536_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=Qpww6f6a_BcAX9F1tai&oh=bfdfb2ebc356619b253f655263817112&oe=5E9073AA"
      },
      {
        "pk": "8471921527",
        "username": "inalleyshop",
        "fullName": "In Alley",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/39104618_269685627197886_3973347758189838336_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=uqfYHvwLnyEAX9wPQNN&oh=62be2cc727dc59e759ff75a6c097bd41&oe=5E99DD34"
      },
      {
        "pk": "1265316727",
        "username": "kerolaineribeiro",
        "fullName": "Kerolaine Ribeiro",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/66481903_2177561029171157_6550961853919395840_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=P9s4m6pZvzEAX_kAUij&oh=4fae7bd54bdcaf8c4c0b79f09b6970b4&oe=5E84E823"
      },
      {
        "pk": "661851302",
        "username": "sthela_assis",
        "fullName": "Sthela",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/83537036_624453904975074_7470423388880633856_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=cVUqW6O0H98AX97xFmP&oh=c4933460b6aaa251c62c6ae20f971555&oe=5E8DBC28"
      },
      {
        "pk": "7465871688",
        "username": "heloisa_araujo35",
        "fullName": "HELO💝",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/77197290_447971942515446_580893901582237696_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=k9xaYtwNxm4AX_U77Ox&oh=21f32fcd7407235c621e4df6c7879054&oe=5E999469"
      },
      {
        "pk": "9946824768",
        "username": "baconfazbemcom",
        "fullName": "Bacon Faz Bem Com...",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/47584587_1960608734036779_7611704534196289536_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=Qpww6f6a_BcAX9F1tai&oh=bfdfb2ebc356619b253f655263817112&oe=5E9073AA"
      },
      {
        "pk": "8471921527",
        "username": "inalleyshop",
        "fullName": "In Alley",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/39104618_269685627197886_3973347758189838336_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=uqfYHvwLnyEAX9wPQNN&oh=62be2cc727dc59e759ff75a6c097bd41&oe=5E99DD34"
      },
      {
        "pk": "1265316727",
        "username": "kerolaineribeiro",
        "fullName": "Kerolaine Ribeiro",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/66481903_2177561029171157_6550961853919395840_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=P9s4m6pZvzEAX_kAUij&oh=4fae7bd54bdcaf8c4c0b79f09b6970b4&oe=5E84E823"
      },
      {
        "pk": "661851302",
        "username": "sthela_assis",
        "fullName": "Sthela",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/83537036_624453904975074_7470423388880633856_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=cVUqW6O0H98AX97xFmP&oh=c4933460b6aaa251c62c6ae20f971555&oe=5E8DBC28"
      },
      {
        "pk": "7465871688",
        "username": "heloisa_araujo35",
        "fullName": "HELO💝",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/77197290_447971942515446_580893901582237696_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=k9xaYtwNxm4AX_U77Ox&oh=21f32fcd7407235c621e4df6c7879054&oe=5E999469"
      },
      {
        "pk": "9946824768",
        "username": "baconfazbemcom",
        "fullName": "Bacon Faz Bem Com...",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/47584587_1960608734036779_7611704534196289536_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=Qpww6f6a_BcAX9F1tai&oh=bfdfb2ebc356619b253f655263817112&oe=5E9073AA"
      },
      {
        "pk": "8471921527",
        "username": "inalleyshop",
        "fullName": "In Alley",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/39104618_269685627197886_3973347758189838336_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=uqfYHvwLnyEAX9wPQNN&oh=62be2cc727dc59e759ff75a6c097bd41&oe=5E99DD34"
      },
      {
        "pk": "1265316727",
        "username": "kerolaineribeiro",
        "fullName": "Kerolaine Ribeiro",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/66481903_2177561029171157_6550961853919395840_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=P9s4m6pZvzEAX_kAUij&oh=4fae7bd54bdcaf8c4c0b79f09b6970b4&oe=5E84E823"
      },
      {
        "pk": "661851302",
        "username": "sthela_assis",
        "fullName": "Sthela",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/83537036_624453904975074_7470423388880633856_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=cVUqW6O0H98AX97xFmP&oh=c4933460b6aaa251c62c6ae20f971555&oe=5E8DBC28"
      },
      {
        "pk": "7465871688",
        "username": "heloisa_araujo35",
        "fullName": "HELO💝",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/77197290_447971942515446_580893901582237696_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=k9xaYtwNxm4AX_U77Ox&oh=21f32fcd7407235c621e4df6c7879054&oe=5E999469"
      },
      {
        "pk": "9946824768",
        "username": "baconfazbemcom",
        "fullName": "Bacon Faz Bem Com...",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/47584587_1960608734036779_7611704534196289536_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=Qpww6f6a_BcAX9F1tai&oh=bfdfb2ebc356619b253f655263817112&oe=5E9073AA"
      },
      {
        "pk": "8471921527",
        "username": "inalleyshop",
        "fullName": "In Alley",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/39104618_269685627197886_3973347758189838336_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=uqfYHvwLnyEAX9wPQNN&oh=62be2cc727dc59e759ff75a6c097bd41&oe=5E99DD34"
      },
      {
        "pk": "1265316727",
        "username": "kerolaineribeiro",
        "fullName": "Kerolaine Ribeiro",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/66481903_2177561029171157_6550961853919395840_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=P9s4m6pZvzEAX_kAUij&oh=4fae7bd54bdcaf8c4c0b79f09b6970b4&oe=5E84E823"
      },
      {
        "pk": "661851302",
        "username": "sthela_assis",
        "fullName": "Sthela",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/83537036_624453904975074_7470423388880633856_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=cVUqW6O0H98AX97xFmP&oh=c4933460b6aaa251c62c6ae20f971555&oe=5E8DBC28"
      },
      {
        "pk": "5677931940",
        "username": "carolfreitasp",
        "fullName": "Carol Freitas",
        "profilePicUrl":
            "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-19/s150x150/87345940_2718465414907025_7525621625669025792_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_ohc=Up_RRQOCcVcAX9Rt1-Q&oh=fe6a3bf0e1b8328ee10f4da382d59af4&oe=5E958BB0"
      }
    ];

    setState(() {
      _listUsers = _myListUnfollowers;
    });
  }
}
