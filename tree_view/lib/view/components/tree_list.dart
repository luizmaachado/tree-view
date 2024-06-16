import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/view/components/tree_tile.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

class TreeList extends StatelessWidget {
  final List<Resource> resourceList;
  final TreeViewModel viewModel;

  const TreeList(
      {super.key, required this.resourceList, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: createTile(),
    );
  }

  createTile() {
    var text = <TreeTile>[];

    resourceList.forEach((i) {
      return text.add(TreeTile(
        viewModel: viewModel,
        resource: i,
      ));
    });
    return text;
  }
}
