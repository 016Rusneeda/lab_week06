import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/favorites_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการโปรดของฉัน'),
        actions: [
          // 1. เช็คว่ามีสินค้าไหม ถ้ามีถึงจะแสดงปุ่มล้างข้อมูล
          if (favorites.items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                // 2. แสดง Dialog ยืนยัน
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('ยืนยันการล้างข้อมูล'),
                    content: const Text('คุณต้องการลบรายการโปรดทั้งหมดหรือไม่?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('ยกเลิก'),
                      ),
                      TextButton(
                        onPressed: () {
                          // 3. ใช้ context.read เรียกคำสั่งล้างข้อมูลครั้งเดียว
                          context.read<FavoritesModel>().clear();
                          Navigator.pop(dialogContext); // ปิด Dialog
                        },
                        child: const Text('ตกลง', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: favorites.items.isEmpty
          ? const Center(child: Text('ยังไม่มีสินค้าที่บันทึกไว้'))
          : ListView.builder(
              itemCount: favorites.items.length,
              itemBuilder: (context, index) {
                final item = favorites.items[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('฿${item.price.toStringAsFixed(0)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => context.read<FavoritesModel>().remove(item),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Text('มูลค่ารวม: ฿${favorites.totalValue.toStringAsFixed(0)}'),
      ),
    );
  }
}