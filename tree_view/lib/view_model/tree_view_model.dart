import 'package:tree_view/constants/companies_enum.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/model/tree_model.dart';

class TreeViewModel {
  TreeModel tree = TreeModel();
  late CompaniesEnum actualCompany = CompaniesEnum.None;
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

  List<Resource> getOrphanList() {
    return tree.orphanList;
  }

  Map<String, List<Resource>> getChildHash() {
    return tree.childHash;
  }

  List<Resource> getChild(Resource resource) {
    return tree.childHash[resource.id] == null
        ? []
        : tree.childHash[resource.id]!;
  }
}
