import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/storage.dart';

class ClientProvider extends StatelessWidget {
  ClientProvider({@required this.child, @required this.uri});

  final Widget child;
  final String uri;

  @override
  Widget build(BuildContext context) {
    final HttpLink _httpLink = HttpLink(uri: uri);
    final AuthLink _authLink = AuthLink(getToken: () async => getToken());
    final ErrorLink _erroLink =
        ErrorLink(errorHandler: (ErrorResponse response) {
      print('oi');
      if (response.exception != null) {
        print(response.exception.graphqlErrors);
      }
    });

    final ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: Link.from([_authLink, _httpLink, _erroLink]),
      cache: InMemoryCache(),
    ));
    return GraphQLProvider(
      client: _client,
      child: child,
    );
  }
}
