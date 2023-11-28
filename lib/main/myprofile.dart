import 'package:flutter/material.dart';

import 'daftar_fav.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 10),
            Text("My Profile"),
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
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("My Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),),
                SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network('https://media.licdn.com/dms/image/D5603AQFrYsASEVE3dA/profile-displayphoto-shrink_400_400/0/1697987871757?e=1705536000&v=beta&t=NBYvHkIAJS5RMwd34XS6gqBV6gtOo0bbfboZZb_bNMw'), // Ganti path sesuai dengan nama gambar lokal Anda
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: DataTable(
                    columnSpacing: 10,
                    columns: <DataColumn>[
                      DataColumn(label: Text("Nama")),
                      DataColumn(label: Text(": Muhammad Amirul")),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text("NIM")),
                          DataCell(Text(": 124210002")),
                        ],),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text("Tempat, Tanggal Lahir")),
                          DataCell(Text(": Bantul, 30 Maret 2003")),
                        ],),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text("Hobi")),
                          DataCell(Text(": Mobile Legends")),
                        ],),
                    ],),
                ),
              ],
            ),
          ),
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
}
