import 'package:flutter/material.dart';

class KonversiUang extends StatefulWidget {
  final ValueChanged<String> onCurrencyChanged;

  KonversiUang({required this.onCurrencyChanged});

  @override
  _KonversiUangState createState() => _KonversiUangState();
}

class _KonversiUangState extends State<KonversiUang> {
  String selectedCurrency = 'USD';

  Map<String, double> conversionRates = {
    //konversi per 13.21 19/11/2023
    'USD': 1.0,
    'Rupiah': 15424.30,
    'JPY': 149.54,
    'Euro': 0.92,
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: conversionRates.keys.map((String currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(currency,
          style: TextStyle(fontSize: 14),),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            selectedCurrency = newValue;
            widget.onCurrencyChanged(selectedCurrency);
          });
        }
      },
    );
  }
}
