import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Center(
      child: Text(
        'Search Screen',
        style: themeData.textTheme.headline6,
      ),
    );
  }
}
