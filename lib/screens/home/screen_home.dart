import 'package:flutter/material.dart';

class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({super.key});

  @override
  _TipCalculatorScreenState createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  final TextEditingController _billController = TextEditingController();
  double _billAmount = 0.0;
  double _tipPercentage = 0.15; 
  double _totalAmount = 0.0;

  final List<double> _tipOptions = [0.15, 0.20, 0.25];

  void _calculateTotalAmount() {
    setState(() {
      _billAmount = double.tryParse(_billController.text) ?? 0.0;
      _totalAmount = _billAmount + (_billAmount * _tipPercentage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _billController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Bill Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Tip Percentage:',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _tipOptions.map((tip) {
                return Expanded(
                  child: RadioListTile(
                    title: Text('${(tip * 100).toStringAsFixed(0)}%'),
                    value: tip,
                    groupValue: _tipPercentage,
                    onChanged: (value) {
                      setState(() {
                        _tipPercentage = value ?? 0.15;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateTotalAmount,
              child: const Text('Calculate Total'),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Amount: \$${_totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}