// Core
import 'dart:io';
import 'dart:typed_data';

// External
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

// Internal
import '../models/transaction_record.dart';

Future<Uint8List> generateReceiptPDF(
  // PdfPageFormat format
  TransactionRecord txnRecord,
) async {
  final doc = pw.Document(pageMode: PdfPageMode.outlines);

  doc.addPage(pw.MultiPage(
      theme: pw.ThemeData.withFont(),
      // pageFormat: format.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      orientation: pw.PageOrientation.portrait,
      crossAxisAlignment: pw.CrossAxisAlignment.start,


      // header: (pw.Context context) {
      //   if (context.pageNumber == 1) {
      //     return pw.SizedBox();
      //   }
      //   return pw.Container(
      //       alignment: pw.Alignment.centerRight,
      //       margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
      //       padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
      //       decoration: const pw.BoxDecoration(
      //           border: pw.Border(
      //               bottom: pw.BorderSide(width: 0.5, color: PdfColors.grey))),
      //       child: pw.Text('MeterPay.NG',
      //           style: pw.Theme.of(context).defaultTextStyle.copyWith(
      //                 // color: PdfColors.grey,
      //                 color: PdfColors.amber,
      //               )));
      // },


      // footer: (pw.Context context) {
      //   return pw.Container(
      //       alignment: pw.Alignment.centerRight,
      //       margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
      //       child: pw.Text(
      //           'Page ${context.pageNumber} of ${context.pagesCount}',
      //           style: pw.Theme.of(context)
      //               .defaultTextStyle
      //               .copyWith(color: PdfColors.grey)));
      // },
      
      build: (pw.Context context) => <pw.Widget>[
            pw.Header(
                level: 1, text: 'File formats and Adobe Acrobat versions'),
            pw.Table.fromTextArray(context: context, data:  <List<String>>[
              // <String>['PDF Version', 'Acrobat Version'],
              <String>['Transaction Reference', txnRecord.txnReference],
              <String>['Token', txnRecord.token],
              <String>['Units', txnRecord.units],
              <String>['Meter Number', txnRecord.meterNumber],
              <String>['Meter Name', txnRecord.meterName],
              <String>['Date', txnRecord.date.toString()],
              <String>['Price Gross', txnRecord.priceGross],
              <String>['Price Net', txnRecord.priceNet],
              <String>['Debt', txnRecord.debt],
              <String>['Service Charge', txnRecord.serviceCharge],
              <String>['Receipt ID', txnRecord.receiptID],
              <String>['Free Units', txnRecord.freeUnits],
              <String>['Payment Type', txnRecord.paymentType],
              <String>['Username', txnRecord.username],
              <String>['Address', txnRecord.address],
              <String>['Meter Category', txnRecord.meterCategory],
              <String>['VAT', txnRecord.vat],
            ]),
            pw.Padding(padding: const pw.EdgeInsets.all(10)),
            pw.Paragraph(
                text:
                    'Text is available under the Creative Commons Attribution Share Alike License.')
          ]));

  return await doc.save();
}


Future<void> savePDF(TransactionRecord txnRecord) async {
  final String path = (await getExternalStorageDirectory())!.path;
  final File receiptFilePDF = File('$path/${txnRecord.txnReference}.pdf');
  final Uint8List pdfBytesList = await generateReceiptPDF(txnRecord);
  receiptFilePDF.writeAsBytes(pdfBytesList);
}
