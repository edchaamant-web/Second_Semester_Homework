import 'package:excel_homework/core/compotenet/elevated_button_widget.dart';
import 'package:excel_homework/core/compotenet/text_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import '../file_excel.dart';

class AddCells extends StatefulWidget {
  const AddCells({super.key});

  @override
  State<AddCells> createState() => _AddCellState();
}

class _AddCellState extends State<AddCells> {
  final FileExcel fe = FileExcel();

  final TextEditingController valueController = TextEditingController();
  final TextEditingController rowController = TextEditingController();

  // أسماء الأعمدة للعرض في القائمة المنسدلة
  final List<String> columns = ['اسم المنتج', 'البلد المنتج', 'السعر'];
  String? selectedColumn;

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  bool checkFields() {
    if (selectedColumn == null ||
        valueController.text.isEmpty ||
        rowController.text.isEmpty) {
      _showSnackBar('الرجاء تعبئة جميع الحقول');
      return false;
    }
    var rowNumber = int.tryParse(rowController.text);

    rowNumber ??= 0;

    final row = int.tryParse(rowController.text);
    if (row == null || row < 1) {
      _showSnackBar('رقم الصف غير صالح');
      return false;
    }

    return true;
  }

  Future<void> saveCell() async {
    if (!checkFields()) return;

    // تحديد رقم العمود من القائمة
    final columnIndex = columns.indexOf(selectedColumn!);

    // إنشاء قائمة طولها 3 تحتوي null إلا في العمود المحدد
    List<CellValue?> rowData = List.filled(columns.length, null);
    rowData[columnIndex] = TextCellValue(valueController.text);

    await fe.addDataToExcel(rowData, int.parse(rowController.text));

    _showSnackBar('تمت إضافة الخلية بنجاح!');
    Navigator.pop(context, true); // إرجاع نتيجة للواجهة الرئيسية
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة خلية')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Align(
                alignment: AlignmentGeometry.centerRight,
                child: Text(
                  'العمود',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<String>(
              value: selectedColumn,
              items: columns
                  .map((col) => DropdownMenuItem(value: col, child: Text(col)))
                  .toList(),
              onChanged: (val) => setState(() => selectedColumn = val),
            ),
            const SizedBox(height: 12),

            // حقل إدخال القيمة
            TextFeildWidget(titles: 'القيمة', textController: valueController),
            const SizedBox(height: 12),
            TextFeildWidget(titles: 'رقم الصف', textController: rowController),

            ElevatedButtonWidget(
              action: saveCell,
              title: 'حفظ الخلية',
              buttunicon: Icon(Icons.check_circle_outline, weight: 7, size: 25),
              num: 15,
            ),
          ],
        ),
      ),
    );
  }
}
