import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes_pbp_9/entity/fnb.dart';
import 'package:tubes_pbp_9/requests/fnbReq.dart';

final fnbProvider =
    FutureProvider.family<List<Foodbev>, String>((ref, category) async {
  return FoodnBev.fetchByCategory(category);
});

class FnBPageView extends ConsumerWidget {
  const FnBPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuList = ["Promo", "Bites", "Drinks"];
    final selectedMenu = ValueNotifier<String>(menuList[0]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        title: const Text(
          'Cineatma',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF384357),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Menu",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ValueListenableBuilder<String>(
              valueListenable: selectedMenu,
              builder: (context, currentMenu, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: menuList.map((menu) {
                      final isSelected = currentMenu == menu;
                      return GestureDetector(
                        onTap: () {
                          selectedMenu.value = menu;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color.fromARGB(255, 36, 43, 56)
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            menu,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            Expanded(
              child: ValueListenableBuilder<String>(
                valueListenable: selectedMenu,
                builder: (context, currentMenu, _) {
                  final fnbData = ref.watch(fnbProvider(selectedMenu.value));
                  return fnbData.when(
                    data: (data) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          if (item.kategori == currentMenu) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.fastfood,
                                    color: Colors
                                        .white), // Ganti dengan gambar nanti
                                title: Text(
                                  item.name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                subtitle: Text(
                                  "${item.deskripsi}\n\$${item.harga.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (err, stack) => Center(
                      child: Text(
                        'Error: $err',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
