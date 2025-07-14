import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:receipt_generator/colors/color.dart';

class ReceiptPage extends StatelessWidget {
  final String userId;
  final String biltyNo;
  final String senderName;
  final String receiverName;
  final String truckOwnerName;
  final String truckNumber;
  final String from;
  final String to;
  final String senderAddress;
  final String receiverAddress;
  final double amount;
  final double advance;
  final double balance;
  final List<Map<String, TextEditingController>> productList;

  ReceiptPage({
    required this.userId,
    required this.biltyNo,
    required this.senderName,
    required this.receiverName,
    required this.truckOwnerName,
    required this.truckNumber,
    required this.from,
    required this.to,
    required this.senderAddress,
    required this.receiverAddress,
    required this.amount,
    required this.advance,
    required this.balance,
    required this.productList,
  });

  Future<void> generatePDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text("TRANSPORT RECEIPT", style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),

              buildReceiptRow("User ID:", userId),
              buildReceiptRow("Bilty No:", biltyNo),
              buildReceiptRow("Date:", DateTime.now().toLocal().toString().split(' ')[0]),
              buildReceiptRow("From:", from),
              buildReceiptRow("To:", to),
              buildReceiptRow("Sender:", senderName),
              buildReceiptRow("Receiver:", receiverName),
              buildReceiptRow("Truck Owner:", truckOwnerName),
              buildReceiptRow("Truck No:", truckNumber),
              buildReceiptRow("Sender Address:", senderAddress),
              buildReceiptRow("Receiver Address:", receiverAddress),

              pw.SizedBox(height: 10),
              pw.Text("Product List", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),

              buildProductTable(),

              pw.SizedBox(height: 10),
              buildReceiptRow("Total Amount:", "₹${amount.toStringAsFixed(2)}"),
              buildReceiptRow("Advance:", "₹${advance.toStringAsFixed(2)}"),
              buildReceiptRow("Balance:", "₹${balance.toStringAsFixed(2)}"),

              pw.SizedBox(height: 30),

              // Signatures
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text("Sender Signature", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Container(width: 150, height: 50, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(width: 2)))),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text("Receiver Signature", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Container(width: 150, height: 50, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(width: 2)))),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/receipt_${biltyNo}.pdf");

    await file.writeAsBytes(await pdf.save());

    // Open PDF file after saving
    OpenFile.open(file.path);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("PDF saved: ${file.path}")));
  }

  pw.Widget buildReceiptRow(String label, String value) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 4.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.Text(value, style: pw.TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  pw.Widget buildProductTable() {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            tableCell("Product Name", isHeader: true),
            tableCell("Weight", isHeader: true),
            tableCell("Quantity", isHeader: true),
            tableCell("Rate", isHeader: true),
            tableCell("Fare", isHeader: true),
          ],
        ),
        ...productList.map((product) {
          return pw.TableRow(
            children: [
              tableCell(product['productName']!.text),
              tableCell(product['weight']!.text),
              tableCell(product['quantity']!.text),
              tableCell(product['rate']!.text),
              tableCell(product['fare']!.text),
            ],
          );
        }).toList(),
      ],
    );
  }

  pw.Widget tableCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(8.0),
      child: pw.Center(
        child: pw.Text(
          text,
          style: pw.TextStyle(fontSize: 14, fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Receipt", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.tealBlue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Existing receipt details here...

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => generatePDF(context),
                child: Text("Generate PDF"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
