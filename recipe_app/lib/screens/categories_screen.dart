import 'package:flutter/material.dart';

import '../dummy-data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          for (int i = 0; i < DUMMY_CATEGORIES.length; i++)
            CategoryItem(
              DUMMY_CATEGORIES[i].id,
              DUMMY_CATEGORIES[i].title,
              DUMMY_CATEGORIES[i].color,
            )
        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2, //for 200 width, have 300 height
          crossAxisSpacing: 20,
          mainAxisSpacing:
              20, //how much distance between columns and rows in the grid
        ),
      );
  }
}
