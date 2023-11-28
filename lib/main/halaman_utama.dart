import 'package:flutter/material.dart';
import 'package:valorantweapons/main/daftar_fav.dart';
import 'package:valorantweapons/data_api/api_data_source.dart';
import 'package:valorantweapons/fitur/clock.dart';
import 'package:valorantweapons/data_api/daftar_weapons.dart';
import 'package:valorantweapons/main/detail_weapons.dart';

import '../models_hive/fav.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {

  String favName = "APA";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.network(
              'https://assets.website-files.com/64c8ba1e1ec040c990d68596/65048ace6192a38a6214b6a9_002_RG_2021_FULL_LOCKUP_OFFWHITE.png',
              height: 25
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
          colors: [Color(0xFFBD3944), Color(0xFF000000)]
          )
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Center(
                    child: SizedBox(
                      height: 140,
                      child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Valorant_logo_-_pink_color_version.svg/2560px-Valorant_logo_-_pink_color_version.svg.png",
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Text(
                      'Welcome to Valorant-Weapons',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Text(
                      'Provides detailed information about all weapons in Valorant',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: SizedBox(
                      height: 30,
                      width: 150,
                      child: Container(
                        child: Jam(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            ),
            _buildDaftarWeaponsBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return DaftarFav();
        }));
      }, child: Icon(Icons.favorite),
        backgroundColor: Color(0xFFbd3944),
      ),
    );
  }

  Widget _buildDaftarWeaponsBody() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadUsers(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        } else if (snapshot.hasData) {
          DaftarWeapons daftarWeapons = DaftarWeapons.fromJson(snapshot.data);
          return _buildSuccessSection(daftarWeapons);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildSuccessSection(DaftarWeapons daftarWeapons) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: daftarWeapons.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(context, daftarWeapons.data![index]);
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: Image.network(
      'https://media.tenor.com/1_EIhMNuXRAAAAAd/omen-valorant.gif',
      fit: BoxFit.cover,
      width: 300,
      height: 300,
    ),
    );
  }

  Widget _buildItemUsers(BuildContext context, Data weaponsData) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailWeapons(weaponsData: weaponsData),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          child: Card(
            elevation:10,
            shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Color(0xFFdcdcd4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 600,
                    height: 200,
                    child: Image.network(weaponsData.displayIcon!),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weaponsData.displayName!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                      ),
                    ),
                    SizedBox(width: 10),
                    FavoriteIcon(weaponsData: weaponsData),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}
class FavoriteIcon extends StatefulWidget {
  final Data weaponsData;

  FavoriteIcon({required this.weaponsData});

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIsFavorite();
  }

  //fixed bug, tadinya senjata yang difavorite saat direload icon berubah tapi list masih ada
  Future<void> _checkIsFavorite() async {
    final favorites = await FavoriteProvider().getFavorites();
    setState(() {
      isFavorite = favorites
          .any((favorite) => favorite.displayName == widget.weaponsData.displayName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () async {
        setState(() {
          isFavorite = !isFavorite;
        });

        final snackBarText = isFavorite
            ? "Success added to favorite weapons"
            : "Success deleted from favorite weapons";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackBarText),
            duration: Duration(seconds: 1),
          ),
        );

        final favoriteProvider = FavoriteProvider();
        if (isFavorite) {
          await favoriteProvider.addToFavorites(
              widget.weaponsData.displayName!, widget.weaponsData.displayIcon!);
        } else {
          await favoriteProvider.removeFromFavorites(widget.weaponsData.displayName!);
        }
      },
    );
  }
}

