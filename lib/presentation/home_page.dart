import 'package:demonotes_getx/controllers/home_controller.dart';
import 'package:demonotes_getx/widgets/search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SearchView(hint: "Filter notes", onTextChanged: (text) {
        controller.filter(text);
      })),
      body: SafeArea(child: buildContent()),
    );
  }

  Widget buildContent() {
    return Obx(
        () {
          debugPrint("HomePage.render");
          if (controller.filteredNotes.value.isProcessing) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: controller.filteredNotes.value.items.length,
              itemBuilder: (context, index) {
                var note = controller.filteredNotes.value.items[index];
                return Card(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(15),
                    child: Text(note.text),
                  ),
                );
              }
          );
        }
    );
  }
}
