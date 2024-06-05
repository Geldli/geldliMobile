// ignore_for_file: use_function_type_syntax_for_parameters, prefer_const_constructors
// https://help.syncfusion.com/flutter/pdf/getting-started

import 'dart:io';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> _createPDF() async {
  //making the pdf
  PdfDocument document = PdfDocument();
  document.pages.add().graphics.drawString(
    'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: Rect.fromLTWH(0, 0, 500, 50));
  List<int> bytes = await document.save();
  document.dispose();

  //saving the pdf
  final directory = await getApplicationSupportDirectory();
  final path = directory.path;
  File file = File('$path/Output.pdf');
  await file.writeAsBytes(bytes, flush: true);
}