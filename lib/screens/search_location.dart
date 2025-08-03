import 'package:flutter/material.dart';

class SearchWeatherDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, 'return from close');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Return search results based on the query
    return Center(
      child: Text('Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Return search suggestions
    return Center(
      child: Text('Suggestions for: $query'),
    );
  }
}
