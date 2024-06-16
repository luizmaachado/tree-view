import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tree_view/constants/resource_type_enum.dart';
import 'package:tree_view/model/resource_model.dart';

class TreeModel {
  List<Resource> orphanList = [];
  Map<String, List<Resource>> childHash = HashMap();

  Map<String, List<Resource>> getchildHash() {
    return childHash;
  }

  createTree(String asset) async {
    orphanList = [];
    childHash = HashMap();
    String assetPath = asset + '/assets.json';
    String locationPath = asset + '/locations.json';
    final String assetResponse = await rootBundle.loadString(assetPath);
    final assetData = await json.decode(assetResponse);
    for (var data in assetData) {
      Resource resource = Resource(
          data['id'],
          data['parentId'],
          data['name'],
          data['sensorType'],
          data['status'],
          data['locationId'],
          ResourceTypeEnum.Asset);
      if (data['parentId'] == null && data['locationId'] == null) {
        orphanList.add(resource);
      } else if (data['parentId'] != null) {
        addParent(resource, resource.parentId);
      } else {
        addParent(resource, resource.locationId);
      }
    }
    final String locationResponse = await rootBundle.loadString(locationPath);
    final locationData = await json.decode(locationResponse);
    for (var data in locationData) {
      Resource resource = Resource(
          data['id'],
          data['parentId'],
          data['name'],
          data['sensorType'],
          data['status'],
          data['locationId'],
          ResourceTypeEnum.Location);
      if (data['parentId'] == null) {
        orphanList.add(resource);
      } else {
        addParent(resource, resource.parentId);
      }
    }
  }

  void addParent(Resource resource, String? parentId) {
    if (childHash[parentId] != null) {
      childHash[parentId]!.add(resource);
    } else {
      childHash.addAll({
        parentId!: [resource]
      });
    }
  }
}
