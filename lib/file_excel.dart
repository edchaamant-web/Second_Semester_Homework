import 'dart:io';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileExcel {
  List<List<String>> excelData = [];
  String? fileName;

  Future<void> addDataToExcel(List<CellValue?> rowData, int rownumber) async {
    final dir = await getExternalStorageDirectory();
    final folderPath = p.join(dir!.path);
    final filePath = p.join(folderPath, 'test.xlsx');

    Excel excel;
    Sheet sheet;
    List<CellValue> columname = [
      TextCellValue('اسم المنتج'),
      TextCellValue('البلد المنتج'),
      TextCellValue('السعر'),
    ];
    List<List<CellValue>> allRows = [
      [TextCellValue('هاتف ذكي'), TextCellValue('الصين'), DoubleCellValue(350)],
      [
        TextCellValue('لابتوب'),
        TextCellValue('الولايات المتحدة'),
        DoubleCellValue(1200),
      ],
      [
        TextCellValue('سماعة لاسلكية'),
        TextCellValue('اليابان'),
        DoubleCellValue(150),
      ],
      [
        TextCellValue('كاميرا رقمية'),
        TextCellValue('كوريا'),
        DoubleCellValue(500),
      ],
      [
        TextCellValue('ساعة ذكية'),
        TextCellValue('السويد'),
        DoubleCellValue(250),
      ],
      [TextCellValue('طابعة'), TextCellValue('ألمانيا'), DoubleCellValue(300)],
      [
        TextCellValue('حقيبة ظهر'),
        TextCellValue('إيطاليا'),
        DoubleCellValue(80),
      ],
    ];

    if (File(filePath).existsSync()) {
      final bytes = File(filePath).readAsBytesSync();
      excel = Excel.decodeBytes(bytes);
      sheet = excel.tables.values.first;
    } else {
      excel = Excel.createExcel();
      sheet = excel.tables.values.first;
      sheet.appendRow(columname);
      for (int i = 0; i < allRows.length; i++) {
        sheet.appendRow(allRows[i]);
      }
    }
    // تحديد الصف الصحيح للإضافة
    int insertRowIndex = rownumber;
    if (insertRowIndex < 0) insertRowIndex = 0;
    if (insertRowIndex > sheet.maxRows) insertRowIndex = sheet.maxRows;

    if (rownumber != 0) {
      sheet.insertRowIterables(rowData, insertRowIndex);
    } else {
      sheet.appendRow(rowData);
    }
    Directory(folderPath).createSync(recursive: true);
    File(filePath).writeAsBytesSync(excel.encode()!);
    exportToDownloads(File(filePath));
    return; // نرجع الملف
  }

  Future<void> exportToDownloads(File excelFile) async {
    final bytes = await excelFile.readAsBytes();

    await FilePicker.platform.saveFile(
      dialogTitle: 'سيتم استبدال الملف إن وُجد',
      fileName: 'test.xlsx', // نفس الاسم = استبدال بعد موافقة المستخدم
      bytes: bytes,
      lockParentWindow: true,
    );
  }

  Future<List<List<String>>> readExcelData() async {
    final dir = await getExternalStorageDirectory();
    final filePath = p.join(dir!.path, 'AMD', 'test.xlsx');

    if (!File(filePath).existsSync()) {
      return [];
    }

    final bytes = File(filePath).readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);

    final sheet = excel.tables.values.first;

    List<List<String>> data = [];

    for (var row in sheet.rows) {
      data.add(row.map((cell) => cell?.value.toString() ?? '').toList());
    }

    return data;
  }

  Future<void> pickAndReadExcel({
    required Function(List<List<String>>) onDataLoaded,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result == null || result.files.isEmpty) return;

      PlatformFile file = result.files.first;

      if (file.path == null) return;

      Uint8List bytes = File(file.path!).readAsBytesSync();

      Excel excel;
      try {
        excel = Excel.decodeBytes(bytes);
      } catch (e) {
        print('تعذر فتح ملف Excel: $e');
        return;
      }

      List<List<String>> temp = [];

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          temp.add(row.map((cell) => cell?.value.toString() ?? '').toList());
        }
        break; // أول Sheet فقط
      }

      // إرسال البيانات للواجهة عبر callback
      onDataLoaded(temp);
    } catch (e) {
      print('خطأ أثناء قراءة الملف: $e');
    }
  }

  Future<void> loadAppExcelOnStart({
    required Function(List<List<String>>) onDataLoaded,
  }) async {
    try {
      final dir = await getExternalStorageDirectory();
      if (dir == null) return;

      final filePath = p.join(dir.path, 'test.xlsx');

      // إذا الملف غير موجود لا نفعل شيء
      if (!File(filePath).existsSync()) {
        onDataLoaded([]);
        return;
      }

      final bytes = File(filePath).readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);

      final sheet = excel.tables.values.first;

      List<List<String>> data = [];

      for (var row in sheet.rows) {
        data.add(row.map((cell) => cell?.value.toString() ?? '').toList());
      }

      onDataLoaded(data);
    } catch (e) {
      print('خطأ أثناء تحميل ملف التطبيق: $e');
    }
  }
}
