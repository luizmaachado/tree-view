import 'package:tree_view/constants/resource_type_enum.dart';

///
/// Resource Model class (Location, Asset and Component)
///
class Resource {
  String id;
  String? parentId;
  String name;
  String? sensorType;
  String? status;
  String? locationId;
  ResourceTypeEnum resourceType;

  Resource(this.id, this.parentId, this.name, this.sensorType, this.status,
      this.locationId, this.resourceType);
}
