import 'package:excel_homework/file_excel.dart';
import 'package:excel_homework/screens/add_cells.dart';
import 'package:excel_homework/screens/add_row.dart';
import 'package:flutter/material.dart';
import '../core/compotenet/elevated_button_widget.dart';
import '../core/color/app_color.dart';
import '../core/string/app_string.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FileExcel fe = FileExcel();
  List<List<String>> excelData = [];
  @override
  void initState() {
    super.initState();
    fich();
  }

  void fich() {
    fe.loadAppExcelOnStart(
      onDataLoaded: (data) {
        setState(() {
          excelData = data;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.appBar()), centerTitle: true),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButtonWidget(
                  action: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddRow()),
                    );

                    if (result == true) {
                      fich();
                    }
                  },

                  title: AppString.addRowInFile(),
                  buttunicon: Icon(
                    Icons.table_rows_outlined,
                    weight: 7,
                    size: 20,
                  ),
                ),
                ElevatedButtonWidget(
                  action: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCells()),
                    );

                    if (result == true) {
                      fich();
                    }
                  },

                  title: AppString.addCell(),
                  buttunicon: Icon(Icons.add, weight: 7, size: 20),
                ),
              ],
            ),

            // زر تحميل ملف Excel
            ElevatedButtonWidget(
              action: () async {
                await fe.pickAndReadExcel(
                  onDataLoaded: (data) {
                    setState(() {
                      excelData = data;
                    });
                  },
                );
              },
              title: AppString.lodeFile(),
              buttunicon: Icon(Icons.search_rounded, weight: 7, size: 25),
            ),

            Divider(
              color: AppColor.primary(),
              indent: 17,
              thickness: 5,
              endIndent: 17,
              radius: BorderRadius.circular(20),
            ),

            // عرض DataTable بناءً على excelData
            excelData.isEmpty
                ? const Text('لا توجد بيانات')
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: excelData.first
                            .map((e) => DataColumn(label: Text(e)))
                            .toList(),
                        rows: excelData.skip(1).map((row) {
                          return DataRow(
                            cells: row
                                .map((cell) => DataCell(Text(cell)))
                                .toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
