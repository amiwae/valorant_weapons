import 'package:flutter/material.dart';
import 'package:valorantweapons/data_api/daftar_weapons.dart';
import 'package:valorantweapons/fitur/konversi_uang.dart';


class DetailWeapons extends StatefulWidget {
  final Data weaponsData;

  DetailWeapons({required this.weaponsData});

  @override
  State<DetailWeapons> createState() => _DetailWeaponsState();
}

class _DetailWeaponsState extends State<DetailWeapons> {
  List<bool> favoriteStatusList = List.filled(0, false);
  @override
  void initState() {
    super.initState();
    favoriteStatusList = List.filled(widget.weaponsData.skins?.length ?? 0, false);
  }

  String selectedCurrency = 'USD';
  String _convertCost(num? cost) {
    if (cost == null) return "N/A";

    double conversionRate = 1.0; // Default USD
    if (selectedCurrency == 'Rupiah') {
      conversionRate = 15424.30;
    } else if (selectedCurrency == 'JPY') {
      conversionRate = 149.54;
    } else if (selectedCurrency == 'Euro') {
      conversionRate = 0.92;
    }

    double convertedCost = cost * conversionRate;
    return convertedCost.toStringAsFixed(1); // Menampilkan 1 angka di belakang koma
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.weaponsData.displayName ?? "Weapons Detail"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFBD3944), Color(0xFF000000)]
            )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Card(
                    color: Color(0xFFdcdcd4),
                    elevation:10,
                    shadowColor: Colors.white,// Memberikan bayangan pada Card
                    margin: const EdgeInsets.symmetric(horizontal: 25.0), // Memberikan jarak Card
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 400,
                              height: 200,
                              child: Image.network(widget.weaponsData.displayIcon!),
                            ),
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.weaponsData.displayName!,style: TextStyle(
                                    fontSize: 18
                                ),),
                                SizedBox(height: 20)
                              ],
                            ),
                          ),
                          Center(
                            child: DataTable(
                              columnSpacing: 30, // Jarak antar kolom
                              columns: [
                                DataColumn(label: Text("Category",style: TextStyle(fontWeight: FontWeight.bold),),),
                                DataColumn(
                                    label: Text("${widget.weaponsData.shopData?.category ?? ""}")),
                              ],
                              rows: <DataRow>[
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text("Fire Rate")),
                                    DataCell(Text("${widget.weaponsData.weaponStats?.fireRate ??
                                        ""}")),
                                  ],
                                ),
                                DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text("Magazine Size")),
                                      DataCell(Text("${widget.weaponsData.weaponStats
                                          ?.magazineSize ?? ""}")),
                                    ]
                                ),
                                DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text("Reload Time")),
                                      DataCell(Text("${widget.weaponsData.weaponStats
                                          ?.reloadTimeSeconds ?? ""} s")),
                                    ]
                                ),
                                DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Text("Head Damage")),
                                      DataCell(Text("${_getHeadDamage(
                                          widget.weaponsData.weaponStats?.damageRanges)}")),
                                    ]
                                ),
                                DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Text("Body Damage")),
                                      DataCell(Text("${_getBodyDamage(
                                          widget.weaponsData.weaponStats?.damageRanges)}")),
                                    ]
                                ),
                                DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Text("Leg Damage")),
                                      DataCell(Text("${_getLegDamage(
                                          widget.weaponsData.weaponStats?.damageRanges)}")),
                                    ]
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text("Cost")),
                                    DataCell(
                                      Row(
                                        children: [
                                          Container(
                                              width: 100,
                                              child: Text("${_convertCost(widget.weaponsData.shopData?.cost ?? 0)} ")),
                                          KonversiUang(
                                            onCurrencyChanged: (String newCurrency) {
                                              setState(() {
                                                selectedCurrency = newCurrency;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Text(
                    widget.weaponsData.displayName! + ' Skins',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var skin in widget.weaponsData.skins ?? [])
                          Card(
                            elevation:10,
                            shadowColor: Colors.white,
                            color: Color(0xFFdcdcd4),
                            margin: const EdgeInsets.only(bottom: 20.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 600,
                                  height: 200,
                                  child: Image.network(
                                    skin.displayIcon ?? "URL_Default_Icon",
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(skin.displayName ?? ""),
                                SizedBox(height: 20),
                              ]
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showFavoriteSnackbar(bool isFavorite, String skinName) {
    final snackBarText = isFavorite
        ? "Skin ditambahkan di Favorite"
        : "Skin dihapus dari Favorite";

    final snackBar = SnackBar(content: Text(snackBarText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String _getHeadDamage(List<DamageRanges>? damageRanges) {
    // Check if damageRanges is not null and not empty
    if (damageRanges != null && damageRanges.isNotEmpty) {
      // Assuming you want to display headDamage from the first element
      return damageRanges[0].headDamage?.toString() ?? "N/A";
    } else {
      return "N/A";
    }
  }

  String _getBodyDamage(List<DamageRanges>? damageRanges) {
    // Check if damageRanges is not null and not empty
    if (damageRanges != null && damageRanges.isNotEmpty) {
      // Assuming you want to display headDamage from the first element
      return damageRanges[0].bodyDamage?.toString() ?? "N/A";
    } else {
      return "N/A";
    }
  }

  String _getLegDamage(List<DamageRanges>? damageRanges) {
    // Check if damageRanges is not null and not empty
    if (damageRanges != null && damageRanges.isNotEmpty) {
      // Assuming you want to display headDamage from the first element
      return damageRanges[0].legDamage?.toString() ?? "N/A";
    } else {
      return "N/A";
    }
  }
}