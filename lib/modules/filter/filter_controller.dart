
/*import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  var filteredData = <Map<String, dynamic>>[].obs;
  var allData = <Map<String, dynamic>>[
    // يجب ملء allData بالبيانات الفعلية الخاصة بك
    // مثال:
    {'name': 'Art Piece 1', 'type': 'Art', 'price': 100, 'date': '2022-01-01', 'evaluation': 4.5},
    {'name': 'Sculpture Piece', 'type': 'Sculpture', 'price': 200, 'date': '2022-02-01', 'evaluation': 3.8},
    {'name': 'Photography Piece', 'type': 'Photography', 'price': 150, 'date': '2022-03-01', 'evaluation': 4.0},
    // أضف المزيد من العناصر هنا
  ].obs;

  @override
  void onInit() {
    super.onInit();
    filteredData.assignAll(allData);
  }

  void filterData(String query) {
    if (query.isEmpty) {
      filteredData.assignAll(allData);
    } else {
      filteredData.assignAll(
        allData.where(
              (item) => item['name']?.toString().toLowerCase().contains(query.toLowerCase()) ?? false,
        ),
      );
    }
  }

  void applyFilters(String searchField, String orderBy, Map<String, bool> typeFilters) {
    List<Map<String, dynamic>> filtered = allData;

    // Filter by type
    filtered = filtered.where((item) {
      if (typeFilters[item['type']] == true) {
        return true;
      }
      return false;
    }).toList();

    // Search by specific field
    if (searchField != 'Null' && searchController.text.isNotEmpty) {
      filtered = filtered.where((item) {
        return item[searchField]?.toString().toLowerCase().contains(searchController.text.toLowerCase()) ?? false;
      }).toList();
    }

    // Order by specified field
    if (orderBy != 'Null') {
      filtered.sort((a, b) {
        var aValue = a[orderBy];
        var bValue = b[orderBy];

        if (aValue == null || bValue == null) {
          return 0;
        }

        if (orderBy == 'Price' || orderBy == 'Evaluation') {
          return aValue.compareTo(bValue);
        } else if (orderBy == 'Date') {
          return DateTime.parse(aValue).compareTo(DateTime.parse(bValue));
        }

        return aValue.toString().compareTo(bValue.toString());
      });
    }

    filteredData.assignAll(filtered);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
*/

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
//import 'package:your_api_service.dart';

class FilterController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  var filteredData = [].obs;
  var allData = [].obs;
  @override
  void onInit() {
    super.onInit();
  }
  void filterData(String query) {
    filteredData.assignAll(
      allData.where(
            (item) => item.name.toLowerCase().contains(query.toLowerCase()),
      ),
    );
  }
  void filterByType(String type) {
    filteredData.assignAll(
      allData.where((item) => item.type == type),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
