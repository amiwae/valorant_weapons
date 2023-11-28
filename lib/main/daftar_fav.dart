import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../models_hive/fav.dart';


class DaftarFav extends StatefulWidget {
  @override
  _DaftarFavState createState() => _DaftarFavState();
}
class _DaftarFavState extends State<DaftarFav> {
  final FavoriteProvider _favoriteProvider = FavoriteProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Weapons'),
        backgroundColor: Colors.black,
      ),
      body: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFBD3944), Color(0xFF000000)],
          ),
        ),
        child: FutureBuilder<List<Favorite>>(
          future: _favoriteProvider.getFavorites(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Error Details: ${snapshot.error}');
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('There is no Favorite Weapon yet'));
            } else {
              List<Favorite> favorites = snapshot.data!;
              Hive.close();

              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final favorite = favorites[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                    child: Card(
                      color: Color(0xFFdcdcd4),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          title: Text(favorite.displayName),
                          subtitle: Image.network(favorite.displayIcon),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
