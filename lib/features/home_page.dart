import 'package:flutter/material.dart';
import 'package:sql_homework/core/color/app_color.dart';
import 'package:sql_homework/core/string/app_string.dart';

import 'data/data_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(note.note),
            leading: Checkbox(
              value: note.checkStatus,
              onChanged: (val) async {
                if (val != null) {
                  await controller.updateCheck(note, val ? 1 : 0);
                  setState(() {});
                }
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: AppColor.delet()),
              onPressed: () async {
                await controller.deleteNote(note.id);
                setState(() {});
              },
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
          AppString.appBar(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  AppString.textFeild(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: textController,
                decoration: InputDecoration(hintText: AppString.hintText()),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(30, 23, 20, 30),
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
                        AppString.ok(),
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
                indent: 17,
                thickness: 5,
                endIndent: 17,
                radius: BorderRadius.circular(20),
              ),

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
          Text(
            AppString.noData(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 5),
          Text(
            AppString.addNote(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
