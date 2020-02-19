import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/queries.dart';

class HomeView extends StatelessWidget {
  static String tag = 'home-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Query(
          options: QueryOptions(documentNode: gql(listCountries)),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (result.data == null) {
              print(result.exception);
              return Text("No Data Found !");
            }

            List repositories = result.data['continents'];

            return ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (context, index) {
                  final repository = repositories[index];

                  return Text(repository['code']);
                });
          },
        ),
      ),
    );
  }
}
