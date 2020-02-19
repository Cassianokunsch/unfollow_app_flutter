import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ClientProvider extends StatelessWidget {
  ClientProvider({@required this.child, @required this.uri});

  final Widget child;
  final String uri;

  @override
  Widget build(BuildContext context) {
    final HttpLink _httpLink = HttpLink(uri: uri);
    final ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: _httpLink,
      cache: InMemoryCache(),
    ));
    return GraphQLProvider(
      client: _client,
      child: child,
    );
  }
}
