import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  final List<Map<String, dynamic>> _items = List.generate(
    20,
        (index) => {
      'id': index,
      'title': 'Item ${index + 1}',
      'subtitle': 'Descripción del item ${index + 1}',
      'isSelected': false,
      'color': Colors.primaries[Random().nextInt(Colors.primaries.length)],
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80,
            pinned: true,
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Mi Lista',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resumen',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF5F5DC),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Items totales: ${_items.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFFF5F5DC),
                        ),
                      ),
                      Text(
                        'Seleccionados: ${_items.where((item) => item['isSelected']).length}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFFF5F5DC),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final item = _items[index];
                  return _buildListItem(item, index);
                },
                childCount: _items.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addItem,
        elevation: 4,
        label: Row(
          children: [
            const Icon(Icons.add),
            const SizedBox(width: 8),
            Text(
              "Nuevo Item",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> item, int index) {
    return Dismissible(
      key: ValueKey(item['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      onDismissed: (_) => _removeItem(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: item['isSelected']
              ? item['color'].withOpacity(0.1)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: item['isSelected']
                ? item['color']
                : Colors.grey.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: item['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: GoogleFonts.poppins(
                  color: item['color'],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          title: Text(
            item['title'],
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              item['subtitle'],
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          trailing: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                item['isSelected']
                    ? Icons.check_circle_rounded
                    : Icons.circle_outlined,
                key: ValueKey(item['isSelected']),
                color: item['isSelected'] ? item['color'] : Colors.grey[400],
                size: 28,
              ),
            ),
            onPressed: () => _toggleSelection(index),
          ),
          onTap: () => _toggleSelection(index),
        ),
      ),
    );
  }

  void _toggleSelection(int index) {
    setState(() {
      _items[index]['isSelected'] = !_items[index]['isSelected'];
    });
  }

  void _addItem() {
    setState(() {
      _items.insert(0, {
        'id': _items.length,
        'title': 'Nuevo Item',
        'subtitle': 'Descripción del nuevo item',
        'isSelected': false,
        'color': Colors.primaries[Random().nextInt(Colors.primaries.length)],
      });
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }
}