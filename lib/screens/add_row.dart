import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import '../core/compotenet/elevated_button_widget.dart';
import '../core/compotenet/text_feild_widget.dart';
import '../core/string/app_string.dart';
import '../file_excel.dart';

class AddRow extends StatefulWidget {
  const AddRow({super.key});

  @override
  State<AddRow> createState() => _AddRowState();
}

class _AddRowState extends State<AddRow> {
  FileExcel fe = FileExcel();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController cuntrycontroller = TextEditingController();
  TextEditingController rowcontroller = TextEditingController();
  List<CellValue>? prodectInfo;
  bool checkFields() {
    if (namecontroller.text.trim().isEmpty ||
        cuntrycontroller.text.trim().isEmpty ||
        pricecontroller.text.trim().isEmpty) {
      _showSnackBar('الرجاء تعبئة جميع الحقول');
      return false;
    }

    if (double.tryParse(pricecontroller.text) == null) {
      _showSnackBar('الرجاء إدخال سعر صحيح');
      return false;
    }

    var rowNumber = int.tryParse(rowcontroller.text);

    rowNumber ??= 0;

    if (rowNumber < 0 || rowNumber >= 40) {
      _showSnackBar('رقم الصف يجب أن يكون بين 0 و 39');
      return false;
    }

    fe.addDataToExcel(
      prodectInfo = [
        TextCellValue(namecontroller.text),
        TextCellValue(cuntrycontroller.text),
        TextCellValue(pricecontroller.text),
      ],
      rowNumber,
    );
    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool clearFields() {
    namecontroller.clear();
    pricecontroller.clear();
    cuntrycontroller.clear();
    rowcontroller.clear();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.appBar()), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9, 20, 9, 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFeildWidget(
                titles: AppString.textFeild(),
                hints: AppString.hintText(),
                textController: namecontroller,
              ),
              TextFeildWidget(
                titles: AppString.cuntryFeild(),
                hints: AppString.cuntryhint(),
                textController: cuntrycontroller,
              ),
              TextFeildWidget(
                titles: AppString.priceFeild(),
                hints: AppString.pricehint(),
                textController: pricecontroller,
              ),
              TextFeildWidget(
                titles: AppString.rowFeild(),
                textController: rowcontroller,
              ),
              ElevatedButtonWidget(
                action: () {
                  if (checkFields()) {
                    _showSnackBar('تمت إضافة البيانات بنجاح!');

                    bool now = clearFields();
                    if (now) {
                      Navigator.pop(context, true);
                    }
                  }
                },
                title: AppString.ok(),
                buttunicon: Icon(
                  Icons.check_circle_outline,
                  weight: 7,
                  size: 25,
                ),
                num: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
