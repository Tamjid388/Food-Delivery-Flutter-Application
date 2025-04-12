import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_receipt_page.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:food_delivery_app/pages/cart_page.dart';
import 'package:food_delivery_app/services/database/firestore.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DeliveryProgressPage extends StatefulWidget {
  final String paymentMethod;

  const DeliveryProgressPage({super.key, required this.paymentMethod});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  final FirestoreService db = FirestoreService();
  late String receipt;
  late String finalPaymentMethod;

  @override
  void initState() {
    super.initState();

    finalPaymentMethod = widget.paymentMethod.trim().isNotEmpty
        ? widget.paymentMethod
        : "Not Provided";

    debugPrint("Payment Method in DeliveryProgressPage (initState): $finalPaymentMethod");

    receipt = context.read<Restauarant>().displayCartReceipt();

    db.saveOrderToDatabase(receipt, finalPaymentMethod);
  }

  Future<void> downloadReceiptAsPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Zaika - Receipt', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              pw.Text('Payment Method: $finalPaymentMethod', style: pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 8),
              pw.Text(receipt, style: pw.TextStyle(fontSize: 14)),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: 'zaika_receipt.pdf');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Payment Method in DeliveryProgressPage (build): $finalPaymentMethod");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Progress",
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Provider.of<Restauarant>(context, listen: false).clearCart();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyReceiptPage(receipt: receipt, paymentMethod: finalPaymentMethod),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: downloadReceiptAsPDF,
                icon: const Icon(Icons.download),
                label: const Text("Download Receipt"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
