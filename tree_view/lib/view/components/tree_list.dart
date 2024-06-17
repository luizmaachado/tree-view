import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/view/components/tree_tile.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

class TreeList extends StatelessWidget {
  final Future<List<Resource>> resourceList;
  final TreeViewModel viewModel;

  const TreeList(
      {super.key, required this.resourceList, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: resourceList,
      builder: (BuildContext context, AsyncSnapshot<List<Resource>> snapshot) {
        if (snapshot.hasData) {
          return Column(children: createTile(snapshot.data!));
        } else if (snapshot.hasError) {
          return Container();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  createTile(List<Resource> snapshot) {
    var treeTile = <TreeTile>[];

    snapshot.forEach((i) {
      return treeTile.add(TreeTile(
        viewModel: viewModel,
        resource: i,
      ));
    });
    return treeTile;
  }
}
