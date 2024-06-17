import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/view/components/app_bar.dart';
import 'package:tree_view/view/components/tree_list.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

class AssetTreeView extends StatefulWidget {
  final TreeViewModel viewModel;
  AssetTreeView({super.key, required this.viewModel});
  bool isSensorButtonPressed = false;
  bool isCriticalButtonPressed = false;

  @override
  State<AssetTreeView> createState() => _AssetTreeView();
}

class _AssetTreeView extends State<AssetTreeView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(isMainPage: false),
            body: ListView(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 234, 239, 243),
                      ),
                      child: Row(children: [
                        const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 142, 152, 163),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Buscar Ativo ou Local',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 142, 152, 163),
                                )),
                            onChanged: search,
                          ),
                        )
                      ]))
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          widget.isSensorButtonPressed =
                              !widget.isSensorButtonPressed;
                        });
                      },
                      child: Row(children: [
                        SvgPicture.asset('assets/icons/energy.svg'),
                        Text('Sensor de Energia')
                      ])),
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          widget.isSensorButtonPressed =
                              !widget.isSensorButtonPressed;
                        });
                      },
                      child: Row(children: [
                        SvgPicture.asset('assets/icons/critical.svg'),
                        Text('Crítico')
                      ])),
                ],
              ),
              Divider(),
              TreeList(
                  viewModel: widget.viewModel,
                  resourceList: widget.viewModel.getOrphanList()),
            ])));
  }

  void search(String value) {
    widget.viewModel.filter = searchController.text;
    setState(() {});
  }
}
