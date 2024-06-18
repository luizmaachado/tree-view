import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view/constants/companies_enum.dart';
import 'package:tree_view/model/tree_model.dart';
import 'package:tree_view/view/pages/asset_tree.dart';
import 'package:tree_view/view/widgets/app_bar.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

///
/// Page that shows all companies
///

class Companies extends StatelessWidget {
  Companies({super.key});
  TreeViewModel viewModel = TreeViewModel();

  TreeModel tree = TreeModel();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(isMainPage: true),
            body: Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssetTreeView(
                                  viewModel: viewModel,
                                  company: CompaniesEnum.Jaguar)));
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            top: screenSize.height * 0.0375,
                            bottom: screenSize.height * 0.0125),
                        height: screenSize.height * 0.095,
                        width: screenSize.width * 0.88,
                        color: const Color.fromARGB(255, 33, 136, 255),
                        child: Row(children: [
                          SizedBox(
                            width: screenSize.width * 0.09,
                          ),
                          SvgPicture.asset(
                            'assets/icons/companies.svg',
                            color: Colors.white,
                            width: screenSize.width * 0.06,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.04,
                          ),
                          const Text(
                            'Jaguar Unit',
                            style: TextStyle(color: Colors.white),
                          )
                        ])),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssetTreeView(
                                  viewModel: viewModel,
                                  company: CompaniesEnum.Tobias)));
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            top: screenSize.height * 0.0375,
                            bottom: screenSize.height * 0.0125),
                        height: screenSize.height * 0.095,
                        width: screenSize.width * 0.88,
                        color: const Color.fromARGB(255, 33, 136, 255),
                        child: Row(children: [
                          SizedBox(
                            width: screenSize.width * 0.09,
                          ),
                          SvgPicture.asset(
                            'assets/icons/companies.svg',
                            color: Colors.white,
                            width: screenSize.width * 0.06,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.04,
                          ),
                          const Text(
                            'Tobias Unit',
                            style: TextStyle(color: Colors.white),
                          )
                        ])),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssetTreeView(
                                  viewModel: viewModel,
                                  company: CompaniesEnum.Apex)));
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            top: screenSize.height * 0.0375,
                            bottom: screenSize.height * 0.0125),
                        height: screenSize.height * 0.095,
                        width: screenSize.width * 0.88,
                        color: const Color.fromARGB(255, 33, 136, 255),
                        child: Row(children: [
                          SizedBox(
                            width: screenSize.width * 0.09,
                          ),
                          SvgPicture.asset(
                            'assets/icons/companies.svg',
                            color: Colors.white,
                            width: screenSize.width * 0.06,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.04,
                          ),
                          const Text(
                            'Apex Unit',
                            style: TextStyle(color: Colors.white),
                          )
                        ])),
                  ),
                ],
              ),
            )));
  }
}
