import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view/constants/companies_enum.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/view/components/app_bar.dart';
import 'package:tree_view/view/components/tree_list.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

class AssetTreeView extends StatefulWidget {
  final TreeViewModel viewModel;
  final CompaniesEnum company;
  AssetTreeView({super.key, required this.viewModel, required this.company});
  bool isSensorButtonPressed = false;
  bool isCriticalButtonPressed = false;

  @override
  State<AssetTreeView> createState() => _AssetTreeView();
}

class _AssetTreeView extends State<AssetTreeView> {
  Map<String, String> filterObj = {};
  late Future<List<Resource>> parentList;
  @override
  void initState() {
    parentList = widget.viewModel.getOrphanList(widget.company, getFilterObj());
    // TODO: implement initState
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    parentList = widget.viewModel.getOrphanList(widget.company, getFilterObj());
    super.setState(fn);
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(isMainPage: false),
            body: ListView(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              searchBar(),
              buttonSearch(),
              Divider(),
              FutureBuilder(
                  future: parentList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Resource>> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Container();
                    } else {
                      return TreeList(
                          viewModel: widget.viewModel,
                          resourceList: snapshot.data!);
                    }
                  })
            ])));
  }

  void search(String value) {
    if (searchController.text == '') {
      widget.viewModel.nameFilter = null;
    } else {
      widget.viewModel.nameFilter = searchController.text;
    }
    setState(() {});
  }

  Widget buttonSearch() {
    return Row(
      children: [
        OutlinedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    widget.isSensorButtonPressed
                        ? Color.fromARGB(255, 33, 136, 255)
                        : Colors.white)),
            onPressed: () {
              widget.isSensorButtonPressed = !widget.isSensorButtonPressed;
              setState(() {});
            },
            child: Row(children: [
              SvgPicture.asset('assets/icons/energy.svg'),
              Text('Sensor de Energia')
            ])),
        OutlinedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    widget.isCriticalButtonPressed
                        ? Color.fromARGB(255, 33, 136, 255)
                        : Colors.white)),
            onPressed: () {
              widget.isCriticalButtonPressed = !widget.isCriticalButtonPressed;
              setState(() {});
            },
            child: Row(children: [
              SvgPicture.asset('assets/icons/critical.svg'),
              Text('Crítico')
            ])),
      ],
    );
  }

  Widget searchBar() {
    return Row(
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
    );
  }

  Map<String, String> getFilterObj() {
    if (searchController.text != '') {
      filterObj.addAll({'name': searchController.text});
    } else {
      if (filterObj.keys.contains('name')) filterObj.remove('name');
    }
    if (widget.isSensorButtonPressed) {
      filterObj.addAll({'sensorType': 'energy'});
    } else {
      if (filterObj.keys.contains('sensorType')) filterObj.remove('sensorType');
    }
    if (widget.isCriticalButtonPressed) {
      filterObj.addAll({'status': 'alert'});
    } else {
      if (filterObj.keys.contains('status')) filterObj.remove('status');
    }
    return filterObj;
  }
}
