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

  Future<List<Resource>> createTree(String asset) async {
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

    return orphanList;
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

  Future<bool?> searchResource(Map<String, String> filterObj, Resource resource,
      Map<String, List<Resource>> filterHash) async {
    if (filterHash[resource.id] != null) {
      List<Resource> resouceChild = List.from(filterHash[resource.id]!);
      for (var r in resouceChild) {
        await searchResource(filterObj, r, filterHash);
      }

      if (filterHash[resource.id]!.isEmpty &&
          !checkFilter(filterObj, resource)) {
        return removeFromHash(resource, filterHash);
      }
    } else if (!checkFilter(filterObj, resource)) {
      return removeFromHash(resource, filterHash);
    }
    return null;
  }

  bool? removeFromHash(
      Resource resource, Map<String, List<Resource>> filterHash) {
    if (filterHash[resource.parentId] != null) {
      filterHash[resource.parentId]!
          .removeWhere((element) => element == resource);
    } else if (filterHash[resource.locationId] != null) {
      filterHash[resource.locationId]!
          .removeWhere((element) => element == resource);
    } else {
      return false;
    }
    return null;
  }

  bool checkFilter(Map<String, String> filterObj, Resource resource) {
    if (filterObj.containsKey('name')) {
      if (!resource.name.contains(filterObj['name']!)) {
        return false;
      }
    }
    if (filterObj.containsKey('sensorType')) {
      if (resource.sensorType != filterObj['sensorType']) {
        return false;
      }
    }
    if (filterObj.containsKey('status')) {
      if (resource.status != filterObj['status']) {
        return false;
      }
    }
    return true;
  }
}
