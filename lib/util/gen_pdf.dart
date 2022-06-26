// Core
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// External
// import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf_render/pdf_render.dart' as render;
import 'package:image/image.dart' as imglib;
import 'package:pdf_image_renderer/pdf_image_renderer.dart';

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
            pw.Header(level: 1, text: 'MeterPay.NG Receipt'),
            pw.Table.fromTextArray(context: context, data: <List<String>>[
              // <String>['PDF Version', 'Acrobat Version'],
              <String>['', ''],
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
          ]));

  return await doc.save();
}

Future<File> savePDF(TransactionRecord txnRecord) async {
  final status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  final String path = (await getExternalStorageDirectory())!.path;
  // print(path + '--------------------------');
  final File receiptFilePDF = File('$path/${txnRecord.txnReference}.pdf');
  final Uint8List pdfBytesList = await generateReceiptPDF(txnRecord);
  receiptFilePDF.writeAsBytes(pdfBytesList);
  return receiptFilePDF;
}

Future<void> sharePDF(TransactionRecord txnRecord) async {
  final File receiptFilePDF = await savePDF(txnRecord);
  // OpenFile.open(receiptFilePDF.path);
  final status = await Permission.storage.status;
  if (status.isGranted) {
    Share.shareFiles([receiptFilePDF.path], subject: 'Receipt from MeterPay.NG')
        .whenComplete(() => receiptFilePDF.delete(recursive: true));
  }
}

// Future<void> shareImage() async {

// final doc = await PdfDocument.openFile('abc.pdf');
// final pages = doc.pageCount;
// List<imglib.Image> images = [];

// // get images from all the pages
// for (int i = 1; i <= pages; i++) {
//   var page = await doc.getPage(i);
//   var imgPDF = await page.render();
//   var img = await imgPDF.createImageDetached();
//   var imgBytes = await img.toByteData(format: ImageByteFormat.png);
//   var libImage = imglib.decodeImage(imgBytes.buffer
//       .asUint8List(imgBytes.offsetInBytes, imgBytes.lengthInBytes));
//   images.add(libImage);
// }

// // stitch images
// int totalHeight = 0;
// images.forEach((e) {
//   totalHeight += e.height;
// });
// int totalWidth = 0;
// images.forEach((element) {
//   totalWidth = totalWidth < element.width ? element.width : totalWidth;
// });
// final mergedImage = imglib.Image(totalWidth, totalHeight);
// int mergedHeight = 0;
// images.forEach((element) {
//   imglib.copyInto(mergedImage, element, dstX: 0, dstY: mergedHeight, blend: false);
//   mergedHeight += element.height;
// });
// }

// Future<render.PdfPageImage> _renderPage(render.PdfDocument document, int pageNumber) async {
//     final page = await document.getPage(pageNumber);
//     final pageImage = await page.render(
//       width: page.width * 2,
//       height: page.height * 2,
//       format: PdfPageFormat.PNG,
//     );
//     await page.close();
//     return pageImage;
//   }

void shareRenderedPDFImage(TransactionRecord txnRecord, Color color) async {
  final File receiptFilePDF = await savePDF(txnRecord);
  final String rootPath = (await getExternalStorageDirectory())!.path;
  final String receiptPDFFilePath = '$rootPath/${txnRecord.txnReference}.pdf';

  final pdf = PdfImageRendererPdf(path: receiptPDFFilePath);

  await pdf.open();

  await pdf.openPage(pageIndex: 0);

  final size = await pdf.getPageSize(pageIndex: 0);

  final Uint8List? image = await pdf.renderPage(
    pageIndex: 0,
    x: 0,
    y: 0,
    width: size.width,
    height: size.height,
    scale: 1,
    background: color,
  );

  await pdf.closePage(pageIndex: 0);

  pdf.close();

  final File receiptFileImage = File('$rootPath/${txnRecord.txnReference}.png');

  if (image != null) {
    receiptFileImage.writeAsBytes(image);
    final status = await Permission.storage.status;
    if (status.isGranted) {
      Share.shareFiles([receiptFileImage.path],
              subject: 'Receipt from MeterPay.NG')
          .whenComplete(() {
        receiptFilePDF.delete();
        receiptFileImage.delete();
      });
    }
  }
}
