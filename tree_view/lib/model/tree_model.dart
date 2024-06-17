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

  Future<bool?> searchResource(String filter, Resource resource,
      Map<String, List<Resource>> childHash) async {
    if (childHash[resource.id] != null) {
      List<Resource> resouceChild = List.from(childHash[resource.id]!);
      for (var r in resouceChild) {
        await searchResource(filter, r, childHash);
      }

      if (childHash[resource.id]!.isEmpty && !resource.name.contains(filter)) {
        return removeFromHash(resource, childHash);
      }
    } else if (!resource.name.contains(filter)) {
      return removeFromHash(resource, childHash);
    }
    return null;
  }

  bool? removeFromHash(
      Resource resource, Map<String, List<Resource>> childList) {
    if (childList[resource.parentId] != null) {
      childList[resource.parentId]!
          .removeWhere((element) => element == resource);
    } else if (childList[resource.locationId] != null) {
      childList[resource.locationId]!
          .removeWhere((element) => element == resource);
    } else {
      return false;
    }
    return null;
  }
}
