import 'package:demonotes_getx/controllers/home_controller.dart';
import 'package:demonotes_getx/widgets/search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Container(
        child: SearchView(controller: controller.svController, hint: "Filter notes", onTextChanged: (text) {
            controller.filterNotes(keyword: text);
          }),
        ),
      ),
      body: SafeArea(child: buildContent()),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor: Colors.cyan,
          currentIndex: controller.tabIndex,
            onTap: (index) {
              controller.selectTabAt(index);
            },
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Active'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Secret'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Archived')
        ]),
      ),
    );
  }

  Widget buildContent() {
    return Obx(
        () {
          debugPrint("HomePage.render");
          if (controller.isActiveTabLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: controller.filteredNotes.length,
              itemBuilder: (context, index) {
                var note = controller.filteredNotes[index];
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
