import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view/constants/resource_type_enum.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/view/components/tree_list.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

///
/// Class that shows and manage each tile in the tree
///
class TreeTile extends StatefulWidget {
  final Resource resource;
  final TreeViewModel viewModel;
  bool showChildren = false;

  TreeTile({super.key, required this.resource, required this.viewModel});

  @override
  State<TreeTile> createState() => _TreeTile();
}

class _TreeTile extends State<TreeTile> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool hasChildren =
        widget.viewModel.getChildHash().keys.contains(widget.resource.id);
    return GestureDetector(
        onTap: () {
          setState(() {
            if (hasChildren) {
              widget.showChildren = !widget.showChildren;
            }
          });
        },
        child: Container(
            padding: EdgeInsets.only(top: screenSize.height * 0.013),
            child: Column(children: [
              Row(children: [
                hasChildren
                    ? getArrow()
                    : SizedBox(
                        width: screenSize.width * 0.083,
                      ),
                getSvg(),
                Flexible(
                    child: Container(
                        child: Text(
                  widget.resource.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: screenSize.width * 0.04),
                ))),
                SizedBox(
                  width: screenSize.width * 0.02,
                ),
                displaySign(),
              ]),
              widget.showChildren
                  ? Padding(
                      padding: EdgeInsets.only(left: screenSize.width * 0.05),
                      child: TreeList(
                          resourceList:
                              widget.viewModel.getChild(widget.resource),
                          viewModel: widget.viewModel))
                  : Container()
            ])));
  }

  // function that creates the icon for the tile
  Widget getSvg() {
    Size screenSize = MediaQuery.of(context).size;
    String svgPath = '';
    if (widget.resource.resourceType == ResourceTypeEnum.Location) {
      svgPath = 'assets/icons/location.svg';
    } else if (widget.viewModel
        .getChildHash()
        .keys
        .contains(widget.resource.id)) {
      svgPath = 'assets/icons/asset.svg';
    } else {
      svgPath = 'assets/icons/component.svg';
    }
    return SvgPicture.asset(
      svgPath,
      color: Colors.blue,
      height: screenSize.height * 0.03,
    );
  }

// function that creates the sign for the tile (energy or alert)
  Widget displaySign() {
    Size screenSize = MediaQuery.of(context).size;
    if (widget.resource.sensorType == 'energy') {
      return SvgPicture.asset('assets/icons/bolt.svg',
          color: Colors.green, height: screenSize.height * 0.02);
    } else if (widget.resource.status == 'alert') {
      return ClipOval(
          child: Container(
              height: screenSize.height * 0.015,
              width: screenSize.height * 0.015,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              )));
    } else {
      return Container();
    }
  }

// function that manages and create the arrow for the tile
  Widget getArrow() {
    String svgPath = "";
    Size screenSize = MediaQuery.of(context).size;
    if (widget.showChildren) {
      svgPath = 'assets/icons/down.svg';
    } else {
      svgPath = 'assets/icons/right.svg';
    }
    return Padding(
        padding: EdgeInsets.only(
            left: screenSize.width * 0.03, right: screenSize.width * 0.015),
        child: SvgPicture.asset(svgPath, width: screenSize.width * 0.04));
  }
}
