import 'dart:collection';

import 'package:tree_view/constants/companies_enum.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/model/tree_model.dart';

class TreeViewModel {
  TreeModel tree = TreeModel();
  late CompaniesEnum actualCompany = CompaniesEnum.None;
  String? filter;
  createTree(CompaniesEnum company) async {
    String assetPath = '';
    if (actualCompany == company) {
      return null;
    }
    switch (company) {
      case CompaniesEnum.Apex:
        assetPath = 'assets/jsons/ApexUnit';
      case CompaniesEnum.Jaguar:
        assetPath = 'assets/jsons/JaguarUnit';
      case CompaniesEnum.Tobias:
        assetPath = 'assets/jsons/TobiasUnit';

      case CompaniesEnum.None:
    }
    await tree.createTree(assetPath);
    actualCompany = company;
  }

  Future<List<Resource>> getOrphanList() async {
    if (filter != null) {
      return getFilteredTree();
    }
    return tree.orphanList;
  }

  Map<String, List<Resource>> getChildHash() {
    return tree.childHash;
  }

  Future<List<Resource>> getChild(Resource resource) async {
    return tree.childHash[resource.id] == null
        ? []
        : tree.childHash[resource.id]!;
  }

  Future<List<Resource>> getFilteredTree() async {
    Map<String, List<Resource>> filteredChildHash = getChildHash();
    List<Resource> filteredList = [];

    await search(filteredChildHash, filteredList);

    return filteredList;
  }

  Future<List<Resource>> search(Map<String, List<Resource>> filteredChildHash,
      List<Resource> filteredList) async {
    for (Resource resource in tree.orphanList) {
      List<Resource> child = await getChild(resource);
      if (child.isNotEmpty) {
        bool? resourceIsOk =
            await tree.searchResource(filter!, resource, filteredChildHash);
        if (resourceIsOk != false) {
          filteredList.add(resource);
        }
      } else {
        if (resource.name.contains(filter!)) {
          filteredList.add(resource);
        }
      }
    }
    return filteredList;
  }
}
