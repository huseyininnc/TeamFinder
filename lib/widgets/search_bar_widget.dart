import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({
    Key key,
    @required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
