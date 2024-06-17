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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AssetTreeView(
                          viewModel: viewModel, company: CompaniesEnum.Apex)));
            },
            child: Text('Apex'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AssetTreeView(
                          viewModel: viewModel,
                          company: CompaniesEnum.Jaguar)));
            },
            child: Text('Jaguar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AssetTreeView(
                          viewModel: viewModel,
                          company: CompaniesEnum.Tobias)));
            },
            child: Text('Tobias'),
          )
        ],
      ),
    ));
  }
}
