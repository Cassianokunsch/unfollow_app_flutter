import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/queries.dart';

class HomeView extends StatefulWidget {
  static String tag = 'home-view';

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Query(
          options: QueryOptions(documentNode: gql(myListFollowers)),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (result.data == null) {
              print(result.exception);
              return Text("No Data Found !");
            }

            List followers = result.data['myListFollowers']['followers'];

            return ListView.builder(
              itemCount: followers.length,
              itemBuilder: (context, index) {
                final repository = followers[index];

                return Text(repository['username']);
              },
            );
          },
        ),
      ),
    );
  }
}
