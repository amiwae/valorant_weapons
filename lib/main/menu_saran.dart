import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorantweapons/login/loginpage.dart';

class MenuSaran extends StatefulWidget {
  const MenuSaran({super.key});

  @override
  State<MenuSaran> createState() => _MenuSaranState();
}

class _MenuSaranState extends State<MenuSaran> {
  late SharedPreferences logindata;
  late String username;
  @override
  void initState(){
    super.initState();
    initial();
  }

  void initial() async{
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString("username")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFBD3944), Color(0xFF000000)]
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Card(
                elevation: 20,
                shadowColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Image.network(
                    'https://media.tenor.com/1_EIhMNuXRAAAAAd/omen-valorant.gif',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Saran dan Kesan",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white
                ),),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(label: Text("No.", style: TextStyle(color: Colors.white),)),
                    DataColumn(label: Text("Saran Kesan", style: TextStyle(color: Colors.white),)),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("1.", style: TextStyle(color: Colors.white),)),
                        DataCell(
                          Container(
                            child: Text(
                              "Mata kuliah ini menyenangkan sekali, Mahasiswa bebas semaunya mau berangkat atau tidak, mengerjakan tugas, ujian, kuis, atau tidak terserah masing-masing mahasiswa",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text("2.", style: TextStyle(color: Colors.white),)),
                        DataCell(
                          Container(
                            child: Text(
                              "Semoga ke depannya lebih menyenangkan lagi",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                logindata.setBool("login", true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
              }, child: Text("Keluar"))
            ],
          ),
        ),
      ),
    );
  }
}