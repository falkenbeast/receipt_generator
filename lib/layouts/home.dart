import 'package:flutter/material.dart';
import 'package:receipt_generator/layouts/productDetails.dart';

import 'bill_data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each input field
  final billNoController = TextEditingController();
  final senderNameController = TextEditingController();
  final senderAddressController = TextEditingController();
  final recipientNameController = TextEditingController();
  final recipientAddressController = TextEditingController();
  final truckOwnerNameController = TextEditingController();
  final chassisNoController = TextEditingController();
  final driverController = TextEditingController();
  final engineNoController = TextEditingController();
  final dateController = TextEditingController();
  final truckNoController = TextEditingController();
  final fromWhereController = TextEditingController();
  final tillWhereController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNoController = TextEditingController();
  final ifscCodeController = TextEditingController();

  @override
  void dispose() {
    billNoController.dispose();
    senderNameController.dispose();
    senderAddressController.dispose();
    recipientNameController.dispose();
    recipientAddressController.dispose();
    truckOwnerNameController.dispose();
    chassisNoController.dispose();
    driverController.dispose();
    engineNoController.dispose();
    dateController.dispose();
    truckNoController.dispose();
    fromWhereController.dispose();
    tillWhereController.dispose();
    bankNameController.dispose();
    accountNameController.dispose();
    accountNoController.dispose();
    ifscCodeController.dispose();
    super.dispose();
  }

  Widget buildTextField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.teal),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      appBar: AppBar(
        title: const Text('Enter Bill Details'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField("Bill no", billNoController, Icons.receipt),
              buildTextField("Sender name", senderNameController, Icons.person),
              buildTextField("Sender address", senderAddressController, Icons.location_on),
              buildTextField("Recipient name", recipientNameController, Icons.person_outline),
              buildTextField("Recipient address", recipientAddressController, Icons.home),
              buildTextField("Truck owner name", truckOwnerNameController, Icons.directions_bus),
              buildTextField("Chassis no", chassisNoController, Icons.confirmation_number),
              buildTextField("Driver", driverController, Icons.drive_eta),
              buildTextField("Engine no", engineNoController, Icons.build),
              buildTextField("Date", dateController, Icons.date_range),
              buildTextField("Truck no", truckNoController, Icons.local_shipping),
              buildTextField("From where", fromWhereController, Icons.place),
              buildTextField("Till where", tillWhereController, Icons.map),
              buildTextField("Bank name", bankNameController, Icons.account_balance),
              buildTextField("Account name", accountNameController, Icons.person_pin),
              buildTextField("Account no", accountNoController, Icons.account_box),
              buildTextField("IFSC Code", ifscCodeController, Icons.code),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                  onPressed: () {
                    final billData = BillData(
                      billNo: billNoController.text,
                      senderName: senderNameController.text,
                      senderAddress: senderAddressController.text,
                      recipientName: recipientNameController.text,
                      recipientAddress: recipientAddressController.text,
                      truckOwnerName: truckOwnerNameController.text,
                      chassisNo: chassisNoController.text,
                      driver: driverController.text,
                      engineNo: engineNoController.text,
                      date: dateController.text,
                      truckNo: truckNoController.text,
                      fromWhere: fromWhereController.text,
                      tillWhere: tillWhereController.text,
                      bankName: bankNameController.text,
                      accountName: accountNameController.text,
                      accountNo: accountNoController.text,
                      ifscCode: ifscCodeController.text,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(billData: billData),
                      ),
                    );
                  },

                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
