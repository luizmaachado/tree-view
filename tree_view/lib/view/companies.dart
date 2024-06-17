import 'package:flutter/material.dart';
import 'package:tree_view/constants/companies_enum.dart';
import 'package:tree_view/model/tree_model.dart';
import 'package:tree_view/view/asset_tree.dart';
import 'package:tree_view/view/components/app_bar.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

class Companies extends StatelessWidget {
  Companies({super.key});
  TreeViewModel viewModel = TreeViewModel();

  TreeModel tree = TreeModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(isMainPage: true),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              await viewModel.createTree(CompaniesEnum.Apex);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AssetTreeView(viewModel: viewModel)));
            },
            child: Text('Apex'),
          ),
          TextButton(
            onPressed: () async {
              viewModel.createTree(CompaniesEnum.Jaguar);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AssetTreeView(viewModel: viewModel)));
            },
            child: Text('Jaguar'),
          ),
          TextButton(
            onPressed: () async {
              viewModel.createTree(CompaniesEnum.Tobias);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AssetTreeView(viewModel: viewModel)));
            },
            child: Text('Tobias'),
          )
        ],
      ),
    ));
  }
}
