import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view/constants/companies_enum.dart';
import 'package:tree_view/model/resource_model.dart';
import 'package:tree_view/view/widgets/app_bar.dart';
import 'package:tree_view/view/components/tree_list.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

///
/// Page that shows the tree view and has filters
///
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
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(isMainPage: false),
            body: ListView(children: [
              SizedBox(height: screenSize.height * 0.02),
              Container(
                  padding: EdgeInsets.only(left: screenSize.width * 0.05),
                  child: Column(children: [
                    searchBar(),
                    SizedBox(height: screenSize.height * 0.01),
                    buttonSearch()
                  ])),
              const Divider(),
              FutureBuilder(
                  future: parentList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Resource>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Container();
                    } else {
                      return TreeList(
                          viewModel: widget.viewModel,
                          resourceList: snapshot.data!);
                    }
                  })
            ])));
  }

  // function that manages the search bar
  void search(String value) {
    setState(() {});
  }

  // function that creates the button filters
  Widget buttonSearch() {
    Size screenSize = MediaQuery.of(context).size;
    return Row(
      children: [
        OutlinedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
                backgroundColor: MaterialStatePropertyAll<Color>(
                    widget.isSensorButtonPressed
                        ? const Color.fromARGB(255, 33, 136, 255)
                        : Colors.white)),
            onPressed: () {
              widget.isSensorButtonPressed = !widget.isSensorButtonPressed;
              setState(() {});
            },
            child: Row(children: [
              SvgPicture.asset('assets/icons/energy.svg',
                  height: screenSize.height * 0.03,
                  color: widget.isSensorButtonPressed
                      ? Colors.white
                      : const Color.fromARGB(255, 119, 129, 140)),
              Text('Sensor de Energia',
                  style: TextStyle(
                      color: widget.isSensorButtonPressed
                          ? Colors.white
                          : const Color.fromARGB(255, 119, 129, 140)))
            ])),
        SizedBox(
          width: screenSize.width * 0.05,
        ),
        OutlinedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
                backgroundColor: MaterialStatePropertyAll<Color>(
                    widget.isCriticalButtonPressed
                        ? const Color.fromARGB(255, 33, 136, 255)
                        : Colors.white)),
            onPressed: () {
              widget.isCriticalButtonPressed = !widget.isCriticalButtonPressed;
              setState(() {});
            },
            child: Row(children: [
              SvgPicture.asset(
                'assets/icons/critical.svg',
                height: screenSize.height * 0.03,
                color: widget.isCriticalButtonPressed
                    ? Colors.white
                    : const Color.fromARGB(255, 119, 129, 140),
              ),
              Text(
                'Crítico',
                style: TextStyle(
                    color: widget.isCriticalButtonPressed
                        ? Colors.white
                        : const Color.fromARGB(255, 119, 129, 140)),
              )
            ])),
      ],
    );
  }

// function that creates the search bar
  Widget searchBar() {
    Size screenSize = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
            width: screenSize.width * 0.9,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 234, 239, 243),
            ),
            child: Padding(
                padding: EdgeInsets.only(left: screenSize.width * 0.04),
                child: Row(children: [
                  const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 142, 152, 163),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.5,
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
                ])))
      ],
    );
  }

// function that manages filter
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
