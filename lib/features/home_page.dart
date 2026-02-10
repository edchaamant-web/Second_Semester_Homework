import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sql_homework/core/color/app_color.dart';
import 'package:sql_homework/features/data/app_data.dart';
import 'data/data_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.toggleTheme});
  final VoidCallback toggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  final DataFunction controller = DataFunction();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    await controller.refreshNotes();
    setState(() {});
  }

  Widget notesListView() {
    if (controller.notes.isEmpty) {
      return noTasksWidget();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.notes.length,
      itemBuilder: (context, index) {
        final note = controller.notes[index];
        return Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(
              note.note,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: Checkbox(
              value: note.checkStatus,
              onChanged: (val) async {
                if (val != null) {
                  if (val == true) {
                    await controller.updateCheck(note, val ? 1 : 0);
                  }
                  setState(() {});
                }
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    showmydialog(context, note);
                  },
                ),

                IconButton(
                  icon: Icon(Icons.delete, color: AppColor.delet()),
                  onPressed: () async {
                    await controller.deleteNote(note.id);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'appBar'.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(7.50),
          child: CircleAvatar(
            child: TextButton(
              onPressed: () {
                if (context.locale.languageCode == 'ar') {
                  context.setLocale(const Locale('en'));
                } else {
                  context.setLocale(const Locale('ar'));
                }
              },
              child: Text(
                'languages'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(7.50),
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.brightness_6),
                onPressed: widget.toggleTheme,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 25, 0),
                child: Text(
                  "textFeild".tr(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: textController,
                decoration: InputDecoration(hintText: "hintText".tr()),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(40, 23, 40, 30),
                child: ElevatedButton(
                  onPressed: () async {
                    if (textController.text.isNotEmpty) {
                      await controller.addNote(textController.text);
                      textController.clear();
                      setState(() {});
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ok".tr(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(width: 7),
                      const Icon(Icons.check_circle_outline),
                    ],
                  ),
                ),
              ),

              Divider(
                color: AppColor.primary(),
                indent: 25,
                thickness: 5,
                endIndent: 25,
                radius: BorderRadius.circular(20),
              ),
              SizedBox(height: 5),
              notesListView(),
            ],
          ),
        ),
      ),
    );
  }

  Center noTasksWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_tasks.png'),
          const SizedBox(height: 10),
          Text("noData".tr(), style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 5),
          Text("addNote".tr(), style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }

  void showmydialog(BuildContext context, AppData note) {
    TextEditingController textUpdateController = TextEditingController(
      text: note.note,
    );

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "update".tr(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TextField(
                      controller: textUpdateController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'updateed'.tr(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'cancel'.tr(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          await controller.updateNote(
                            note,
                            textUpdateController.text,
                          );
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: Text(
                          'okUpDate'.tr(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
