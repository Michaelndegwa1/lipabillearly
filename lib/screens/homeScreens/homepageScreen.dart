import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  double _waterBill = 0;
  double _garbage = 0;
  double _security = 0;
  double _wifi = 0;
  double _rent = 0;
  double _telecom = 0;

  void _updateWaterBill(double value) {
    setState(() {
      _waterBill = value;
    });
  }

  void _updateGarbage(double value) {
    setState(() {
      _garbage = value;
    });
  }

  void _updateSecurity(double value) {
    setState(() {
      _security = value;
    });
  }

  void _updateWifi(double value) {
    setState(() {
      _wifi = value;
    });
  }

  void _updateRent(double value) {
    setState(() {
      _rent = value;
    });
  }

  void _updateTelecom(double value) {
    setState(() {
      _telecom = value;
    });
  }

  double get _totalAmount =>
      _waterBill + _garbage + _security + _wifi + _rent + _telecom;

  String get _formattedTotalAmount {
    final kshAmount = _totalAmount;
    return 'KSH ${kshAmount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lipa Bills Zako'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PaymentOptionBox(
                label: ' Water Bill',
                icon: Icons.opacity,
                amount: _waterBill,
                onUpdate: _updateWaterBill,
              ),
              const SizedBox(height: 20),
              PaymentOptionBox(
                label: 'Telecom Bill',
                icon: Icons.call,
                amount: _telecom,
                onUpdate: _updateTelecom,
              ),
              const SizedBox(height: 20),
              PaymentOptionBox(
                label: 'GARBAGE',
                icon: Icons.delete,
                amount: _garbage,
                onUpdate: _updateGarbage,
              ),
              const SizedBox(height: 20),
              PaymentOptionBox(
                label: 'Security',
                icon: Icons.security,
                amount: _security,
                onUpdate: _updateSecurity,
              ),
              const SizedBox(height: 20),
              PaymentOptionBox(
                label: 'Net (WiFi)',
                icon: Icons.wifi,
                amount: _wifi,
                onUpdate: _updateWifi,
              ),
              const SizedBox(height: 20),
              PaymentOptionBox(
                label: 'Rent BILL',
                icon: Icons.home,
                amount: _rent,
                onUpdate: _updateRent,
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                child: const Text('PREPAID BILLS'),
                onPressed: () {
                  // Implement payment logic here
                },
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Prepaid RENT: ${_rent.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 26.0),
                    ),
                    Slider(
                      value: _rent,
                      min: 0,
                      max: 10000,
                      divisions: 100,
                      onChanged: _updateRent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'SECURITY: ${_security.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 26.0),
                    ),
                    Slider(
                      value: _security,
                      min: 0,
                      max: 10000,
                      divisions: 100,
                      onChanged: _updateSecurity,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'WATER BILL: ${_waterBill.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 26.0),
                    ),
                    Slider(
                      value: _waterBill,
                      min: 0,
                      max: 10000,
                      divisions: 100,
                      onChanged: _updateWaterBill,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Total Amount: KSH $_formattedTotalAmount',
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                child: const Text('PAY BILLS'),
                onPressed: () {
                  // Implement payment logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOptionBox extends StatefulWidget {
  final String label;
  final IconData icon;
  final double amount;
  final ValueChanged<double> onUpdate;

  const PaymentOptionBox({
    Key? key,
    required this.label,
    required this.icon,
    required this.amount,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _PaymentOptionBoxState createState() => _PaymentOptionBoxState();
}

class _PaymentOptionBoxState extends State<PaymentOptionBox> {
  late double _currentAmount;
  @override
  void initState() {
    super.initState();
    _currentAmount = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.tealAccent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 50),
            const SizedBox(height: 10),
            Text(widget.label, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text(
              'Amount: KSH$_currentAmount',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter amount to pay'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _currentAmount = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Implement payment logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
