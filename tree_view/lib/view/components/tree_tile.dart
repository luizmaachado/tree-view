import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view/constants/resource_type_enum.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/view/components/tree_list.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

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
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.showChildren = !widget.showChildren;
          });
        },
        child: Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
            child: Column(children: [
              Row(children: [
                widget.viewModel
                        .getChildHash()
                        .keys
                        .contains(widget.resource.id)
                    ? const Icon(Icons.arrow_drop_down_rounded)
                    : Container(),
                getSvg(),
                Text(widget.resource.name)
              ]),
              widget.showChildren
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1),
                      child: TreeList(
                          resourceList:
                              widget.viewModel.getChild(widget.resource),
                          viewModel: widget.viewModel))
                  : Container()
            ])));
  }

  Widget getSvg() {
    if (widget.resource.resourceType == ResourceTypeEnum.Location) {
      return SvgPicture.asset(
        'assets/icons/location.svg',
        color: Colors.blue,
      );
    } else if (widget.viewModel
        .getChildHash()
        .keys
        .contains(widget.resource.id)) {
      return SvgPicture.asset(
        'assets/icons/asset.svg',
        color: Colors.blue,
      );
    } else {
      return SvgPicture.asset(
        'assets/icons/component.svg',
        color: Colors.blue,
      );
    }
  }
}
