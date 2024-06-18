import 'dart:collection';

import 'package:tree_view/constants/companies_enum.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/model/tree_model.dart';

///
/// Tree ViewModel Class
///
class TreeViewModel {
  TreeModel tree = TreeModel();
  late CompaniesEnum actualCompany = CompaniesEnum.None;
  String? nameFilter;
  bool energySensorFilter = false;
  bool criticalStatusFilter = false;

  // Function that, given a company, returns the orphan list
  Future<List<Resource>> createTree(CompaniesEnum company) async {
    String assetPath = '';

    switch (company) {
      case CompaniesEnum.Apex:
        assetPath = 'assets/jsons/ApexUnit';
      case CompaniesEnum.Jaguar:
        assetPath = 'assets/jsons/JaguarUnit';
      case CompaniesEnum.Tobias:
        assetPath = 'assets/jsons/TobiasUnit';

      case CompaniesEnum.None:
    }
    actualCompany = company;
    var list = await tree.createTree(assetPath);

    return list;
  }

  // Function that, given a resource, returns his children
  List<Resource> getChild(Resource resource) {
    return tree.childHash[resource.id] == null
        ? []
        : tree.childHash[resource.id]!;
  }

  // Function that, given company and filterObj returns a list of orphans
  // (main function to manage the assetTree page)
  Future<List<Resource>> getOrphanList(
      CompaniesEnum company, Map<String, String> filterObj) async {
    if (filterObj.keys.isNotEmpty) {
      await createTree(company);
      return getFilteredTree(filterObj);
    }
    return createTree(company);
  }

  // Function that simply returns the childHash
  Map<String, List<Resource>> getChildHash() {
    return tree.childHash;
  }

  // Function that filters the tree given a filter object
  Future<List<Resource>> getFilteredTree(Map<String, String> filterObj) async {
    Map<String, List<Resource>> filteredChildHash =
        Map<String, List<Resource>>.from(getChildHash());

    List<Resource> filteredList = [];

    await search(filteredChildHash, filteredList, filterObj);

    return filteredList;
  }

  // Auxiliar function that filters the tree
  Future<List<Resource>> search(Map<String, List<Resource>> filteredChildHash,
      List<Resource> filteredList, Map<String, String> filterObj) async {
    for (Resource resource in tree.orphanList) {
      List<Resource> child = filteredChildHash[resource.id] == null
          ? []
          : filteredChildHash[resource.id]!;
      if (child.isNotEmpty) {
        bool? resourceIsOk =
            await tree.searchResource(filterObj, resource, filteredChildHash);
        if (resourceIsOk != false) {
          filteredList.add(resource);
        }
      } else {
        if (tree.checkFilter(filterObj, resource)) {
          filteredList.add(resource);
        }
      }
    }
    return filteredList;
  }
}
