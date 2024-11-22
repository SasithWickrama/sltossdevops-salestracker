// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:incentive_tracker/utils/constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../components/salesCountLable.dart';
import '../components/titleLine.dart';
import '../providers/login_provider.dart';
import '../providers/order_provider.dart';
import '../utils/constants/asset_constants.dart';
import '../utils/size_config.dart';
import 'login.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Timer? mytimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrderProvider>(context, listen: false)
          .getSoCount(context)
          .then(
        (value) {
          setState(() {});
        },
      );
      Provider.of<OrderProvider>(context, listen: false).resetData;
      Provider.of<OrderProvider>(context, listen: false)
          .getTargetCUCo(context)
          .then(
        (value) {
          setState(() {});
          if (Provider.of<LoginProvider>(context, listen: false)
                  .appUser
                  .job
                  .substring(0, 4) !=
              "CuCO") {
            Provider.of<OrderProvider>(context, listen: false).getSlab(context);
          }
        },
      );
      Provider.of<OrderProvider>(context, listen: false)
          .getLastUpdatedTime(context)
          .then(
        (value) {
          setState(() {});
        },
      );
    });
  }

  @override
  void dispose() {
    mytimer?.cancel();
    super.dispose();
  }

  final List<String> items = [
    DateFormat("MMMM y")
        .format(DateTime(DateTime.now().year, DateTime.now().month - 1))
        .toString(),
    DateFormat("MMMM y")
        .format(DateTime(DateTime.now().year, DateTime.now().month - 2))
        .toString(),
    DateFormat("MMMM y")
        .format(DateTime(DateTime.now().year, DateTime.now().month - 3))
        .toString(),
    DateFormat("MMMM y")
        .format(DateTime(DateTime.now().year, DateTime.now().month - 4))
        .toString(),
  ];

  final List<String> items2 = [
    DateFormat("yyyyMM")
        .format(DateTime(DateTime.now().year, DateTime.now().month - 1))
        .toString(),
    DateFormat("yyyyMM")
        .format(DateTime(DateTime.now().year, DateTime.now().month - 2))
        .toString(),
    DateFormat("yyyyMM")
        .format(DateTime(DateTime.now().year, DateTime.now().month - 3))
        .toString(),
    DateFormat("yyyyMM")
        .format(DateTime(DateTime.now().year, DateTime.now().month - 4))
        .toString(),
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    // final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Logout Alert"),
            content: const Text("Do You Want to Logout ?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text("No"),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final cacheDir = await getTemporaryDirectory();

                  if (cacheDir.existsSync()) {
                    cacheDir.deleteSync(recursive: true);
                  }

                  Provider.of<OrderProvider>(context, listen: false)
                      .resetData();

                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const LoginPage();
                  }), (r) {
                    return false;
                  });
                  return;
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text("Yes"),
                ),
              ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(AssetConstants.appName),
            backgroundColor: AppColors.primaryColor),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                TitleLine(
                    title:
                        'Sales Summary ${DateFormat("MMMM y").format(DateTime(DateTime.now().year, DateTime.now().month)).toString()}'),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      width: SizeConfig.w(context) / 2.5,
                      height: SizeConfig.w(context) / 2.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            Provider.of<OrderProvider>(context, listen: false)
                                .bgcolour, // Colors.amber,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Provider.of<OrderProvider>(context).targetMsg,
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "Target:  ${Provider.of<OrderProvider>(context).target}",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "Sales:  ${Provider.of<OrderProvider>(context).recordCount}",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              " ${Provider.of<OrderProvider>(context).currentSlab}",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('User',
                            style: TextStyle(
                                color: AppColors.buttonGreen,
                                fontWeight: FontWeight.normal)),
                        Text(
                            Provider.of<LoginProvider>(context)
                                .appUser
                                .username,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500)),
                        const Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text('Rtom',
                            style: TextStyle(
                                color: AppColors.buttonGreen,
                                fontWeight: FontWeight.normal)),
                        Text(Provider.of<LoginProvider>(context).appUser.rtom,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500)),
                        const Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text('Jobrole',
                            style: TextStyle(
                                color: AppColors.buttonGreen,
                                fontWeight: FontWeight.normal)),
                        Text(Provider.of<LoginProvider>(context).appUser.job,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500)),
                        const Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text('ACM Code',
                            style: TextStyle(
                                color: AppColors.buttonGreen,
                                fontWeight: FontWeight.normal)),
                        Text(
                            Provider.of<LoginProvider>(context).appUser.acccode,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500)),
                      ],
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                SalesCountLable(
                  lable: 'AB-CAB',
                  ammount: Provider.of<OrderProvider>(context).abcab,
                  bgcolour: AppColors.abcab,
                ),
                const Padding(
                  padding: EdgeInsets.all(2),
                ),
                SalesCountLable(
                    lable: 'AB-FTTH Create',
                    ammount: Provider.of<OrderProvider>(context).abftth,
                    bgcolour: AppColors.abftthcr),
                const Padding(
                  padding: EdgeInsets.all(2),
                ),
                SalesCountLable(
                    lable: 'AB-FTTH Upgrade',
                    ammount: Provider.of<OrderProvider>(context).abftthUpgrade,
                    bgcolour: AppColors.abftthup),
                const Padding(
                  padding: EdgeInsets.all(2),
                ),
                SalesCountLable(
                    lable: 'AB-Wireless Access',
                    ammount: Provider.of<OrderProvider>(context).lte,
                    bgcolour: AppColors.lte),
                const Padding(
                  padding: EdgeInsets.all(2),
                ),
                SalesCountLable(
                  lable: 'Fixed Broadband',
                  ammount: Provider.of<OrderProvider>(context).bb,
                  bgcolour: AppColors.bb,
                ),
                const Padding(
                  padding: EdgeInsets.all(2),
                ),
                SalesCountLable(
                  lable: 'IPTV',
                  ammount: Provider.of<OrderProvider>(context).iptv,
                  bgcolour: AppColors.iptv,
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                ),
                TitleLine(title: 'Previous Months Sales'),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text('Last Updated on: ',
                        style: TextStyle(
                            color: AppColors.buttonGreen,
                            fontWeight: FontWeight.normal)),
                    Text(Provider.of<OrderProvider>(context).updatedTime,
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Select Month',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;

                          Provider.of<OrderProvider>(context, listen: false)
                              .getMonthSales(context,
                                  items2.elementAt(items.indexOf(value)));
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: AppColors.primaryColor,
                          ),
                          color: AppColors.backgroundCol3,
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: FittedBox(
                      child: DataTable(
                        headingTextStyle: TextStyle(
                            color: AppColors.buttonGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        dataTextStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        border: TableBorder.all(
                            color: AppColors.primaryColor, width: 2),
                        columns: const [
                          DataColumn(label: Text('Service Type')),
                          DataColumn(label: Text('Total')),
                          DataColumn(label: Text('OK')),
                          DataColumn(label: Text('SU')),
                          DataColumn(label: Text('TX')),
                          DataColumn(label: Text('PN')),
                        ],
                        rows: List.generate(
                            Provider.of<OrderProvider>(context).myList.length,
                            (index) {
                          return DataRow(
                            cells: [
                              DataCell(Container(
                                  child: Text(
                                Provider.of<OrderProvider>(context)
                                    .myList[index]
                                    .service
                                    .toString(),
                                overflow: TextOverflow.visible,
                                softWrap: true,
                              ))),
                              DataCell(Container(
                                  child: Text(
                                Provider.of<OrderProvider>(context)
                                    .myList[index]
                                    .tot
                                    .toString(),
                                overflow: TextOverflow.visible,
                                softWrap: true,
                              ))),
                              DataCell(Container(
                                  child: Text(
                                Provider.of<OrderProvider>(context)
                                    .myList[index]
                                    .ok
                                    .toString(),
                                overflow: TextOverflow.visible,
                                softWrap: true,
                              ))),
                              DataCell(Container(
                                  child: Text(
                                Provider.of<OrderProvider>(context)
                                    .myList[index]
                                    .su
                                    .toString(),
                                overflow: TextOverflow.visible,
                                softWrap: true,
                              ))),
                              DataCell(Container(
                                  child: Text(
                                Provider.of<OrderProvider>(context)
                                    .myList[index]
                                    .tx
                                    .toString(),
                                overflow: TextOverflow.visible,
                                softWrap: true,
                              ))),
                              DataCell(Container(
                                  child: Text(
                                Provider.of<OrderProvider>(context)
                                    .myList[index]
                                    .pn
                                    .toString(),
                                overflow: TextOverflow.visible,
                                softWrap: true,
                              )))
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
