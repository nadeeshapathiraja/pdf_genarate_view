import 'package:flutter/material.dart';
import 'package:pdf_vie/model/final_view_model.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'provider/final_vie_provider.dart';

class FinalView extends StatefulWidget {
  const FinalView({Key? key}) : super(key: key);

  @override
  _FinalViewState createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.picture_as_pdf,
                size: 100,
              ),
              const Text(
                "Genarate PDF",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: _createPdf,
                child: const Text("Invoice PDF"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createPdf() async {
    PdfDocument document = PdfDocument();
    document.pages.add();

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Invoice.pdf');
  }
}
