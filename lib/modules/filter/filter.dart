
/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'filter_controller.dart';
import 'filter_service.dart';

class Filter extends StatefulWidget {
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final FilterController _controller = Get.put(FilterController());
  final FilterService _service = FilterService();
  String dropdownValue = 'Null';
  String dropdownByorder = 'Null';
  bool click_art = false;
  bool click_des = false;
  bool click_vis = false;
  bool click_scul = false;
  bool click_band = false;
  bool click_photo = false;
  bool click_opt = false;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: screenwidth * 1,
          height: screenheight * 1.5,
          child: Form(
            child: Stack(
              children: [
                Container(
                  width: screenwidth,
                  height: screenheight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.3,
                      fit: BoxFit.fitHeight,
                      image: AssetImage("images/6.jpg"),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Obx(() {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SizedBox(height: screenheight * 0.005),
                    Row(
                    children: [
                    IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                    Get.toNamed('/Welcome');
                    },
                    ),
                    SizedBox(width: screenwidth * 0.18),
                    Text(
                    _controller.filteredData.isEmpty ? 'Search and Filter' : 'Search Results',
                    style: TextStyle(
                    color: Colors.orange.shade200,
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    ),
                    ),
                    ],
                    ),
                    SizedBox(height: screenheight * 0.01),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                    decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                    ),
                    ),
                    onChanged: (value) {
                    _controller.filterData(value);
                    },
                    ),
                    ),
                    if (_controller.filteredData.isEmpty) ...[
                    SizedBox(height: screenheight * 0.01),
                    Row(
                    children: [
                    SizedBox(width: screenwidth * 0.01),
                    Flexible(
                      child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                    isExpanded: true,
                    style: TextStyle(
                    color: Colors.black26,
                    fontSize: 15,
                    ),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                    setState(() {
                    dropdownValue = newValue!;
                    });
                    },
                    items: const [
                    DropdownMenuItem<String>(
                    value: 'Null',
                    child: Text('Null'),
                    ),
                    DropdownMenuItem<String>(
                    value: 'Artist_Name',
                    child: Text('Artist_Name'),
                    ),
                    DropdownMenuItem<String>(
                    value: 'Title',
                    child: Text('Title'),
                    ),
                    DropdownMenuItem<String>(
                    value: 'Description',
                    child: Text('Description'),
                    ),
                    ],
                    ),
                    ),
                    SizedBox(width: screenwidth * 0.1),
                    Flexible(
                    child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                    isExpanded: true,
                    style: TextStyle(
                    color: Colors.black26,
                    fontSize: 15,
                    ),
                    value: dropdownByorder,
                    onChanged: (String? newValue) {
                    setState(() {
                    dropdownByorder = newValue!;
                    });
                    },
                    items: const [
                    DropdownMenuItem<String>(
                    value: 'Null',
                    child: Text('Null'),
                    ),
                    DropdownMenuItem<String>(
                    value: 'Evaluation',
                    child: Text('Evaluation'),
                    ),
                    DropdownMenuItem<String>(
                    value: 'Price',
                    child: Text('Price'),
                    ),
                    DropdownMenuItem<String>(
                    value: 'Date',
                    child: Text('Date'),
                    ),
                    ],
                    ),
                    ),
                    ],
                    ),
                    SizedBox(height: screenheight * 0.1),
                    Text(
                    'Filter by type',
                    style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    ),
                    ),
                    SizedBox(height: screenheight * 0.02),
                    Row(
                    children: [
                    SizedBox(width: screenwidth * 0.04),
                    FilterButton(
                    label: 'Art',
                    isSelected: click_art,
                    onTap: () {
                    setState(() {
                    click_art = !click_art;
                    });
                    },
                    ),
                    SizedBox(width: screenwidth * 0.01),
                    FilterButton(
                    label: 'Band',
                    isSelected: click_band,
                    onTap: () {
                    setState(() {
                    click_band = !click_band;
                    });
                    },
                    ),
                    ],
                    ),
                    SizedBox(height: screenheight * 0.01),
                    Row(
                    children: [
                    SizedBox(width: screenwidth * 0.04),
                    FilterButton(
                    label: 'Sculpture',
                    isSelected: click_scul,
                    onTap: () {
                    setState(() {
                    click_scul = !click_scul;
                    });
                    },
                    ),
                    SizedBox(width: screenwidth * 0.01),
                    FilterButton(
                    label: 'Design',
                    isSelected: click_des,
                    onTap: () {
                    setState(() {
                    click_des = !click_des;
                    });
                    },
                    ),
                    SizedBox(width: screenwidth * 0.01),
                    FilterButton(
                    label: 'Visual',
                    isSelected: click_vis,
                    onTap: () {
                    setState(() {
                    click_vis = !click_vis;
                    });
                    },
                    ),
                    ],
                    ),
                    SizedBox(height: screenheight * 0.01),
                    Row(
                    children: [
                    SizedBox(width: screenwidth * 0.04),
                    FilterButton(
                    label: 'Optical Communication',
                    isSelected: click_opt,
                    onTap: () {
                    setState(() {
                    click_opt = !click_opt;
                    });
                    },
                    ),
                    SizedBox(width: screenwidth * 0.01),
                      FilterButton(
                    label: 'Photography',
                    isSelected: click_photo,
                    onTap: () {
                    setState(() {
                    click_photo = !click_photo;
                    });
                    },
                    ),
                    ],
                    ),
                    SizedBox(height: screenheight * 0.05),
                    ElevatedButton(
                    onPressed: () {
                    // Apply filter logic here
                    // For demonstration, let's filter based on selected types and other filters
                    _controller.applyFilters(
                    dropdownValue,
                    dropdownByorder,
                    {
                    'Art': click_art,
                    'Band': click_band,
                    'Sculpture': click_scul,
                    'Design': click_des,
                    'Visual': click_vis,
                    'Optical Communication': click_opt,
                    'Photography': click_photo,
                    },
                    );
                    },
                    child: Text(
                    'Apply Filter',
                    style: TextStyle(
                    fontSize: 20,
                    ),
                    ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ] else ...[
                      for (var item in _controller.filteredData)
                        ListTile(
                          title: Text(item['name'] ?? 'No Name'),
                          subtitle: Text(item['type'] ?? 'No Type'),
                        ),
                    ],
                        ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orangeAccent : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
          onPressed: onTap,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

}*/


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'filter_controller.dart';
import 'filter_service.dart';

class Filter extends StatefulWidget {
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final FilterController _controller = Get.put(FilterController());
  final FilterService _service = FilterService();
  String dropdownValue = 'Null';
  String dropdownByorder = 'Null';
  bool click_art = false;
  bool click_des = false;
  bool click_vis = false;
  bool click_scul = false;
  bool click_print = false;
  bool click_photo = false;
  bool click_mos = false;
  bool click_mural = false;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: screenwidth * 1,
          height: screenheight * 1.5,
          child: Form(
            child: Stack(
              children: [
                Container(
                  width: screenwidth,
                  height: screenheight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.3,
                      fit: BoxFit.fitHeight,
                      image: AssetImage("images/6.jpg"),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenheight * 0.005),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Get.toNamed('/Welcome');
                              },
                            ),
                            SizedBox(width: screenwidth * 0.18),
                            Text(
                              'Search and Filter',
                              style: TextStyle(
                                color: Colors.orange.shade200,
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenheight * 0.01),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Search',
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      _controller.filterData(value);
                                    },
                                  ),
                                  SizedBox(height: screenheight * 0.01),
                                  Row(
                            children: [
                            SizedBox(width: screenwidth * 0.01),
                        /*    Text(
                              'Search for',
                              style: TextStyle(color: Colors.black54),
                            ),*/
                             // SizedBox(width: screenwidth * 0.03),
                              Flexible(
                              child: DropdownButtonFormField<String>(
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 20,
                                isExpanded: true,
                                style: TextStyle(
                                color: Colors.black26,
                                fontSize: 15,
                              ),
                              value: dropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Null',
                                  child: Text('Null'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Artist_Name',
                                  child: Text('Artist_Name'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Title',
                                  child: Text('Title'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Description',
                                  child: Text('Description'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: screenwidth * 0.1),
                      /*    Text(
                            'Order by',
                            style: TextStyle(color: Colors.black54),
                          ),*/
                            //  SizedBox(width: screenwidth * 0.03),

                              Flexible(
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Colors.white,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 20,
                              isExpanded: true,
                              style: TextStyle(
                                color: Colors.black26,
                                fontSize: 15,
                              ),
                              value: dropdownByorder,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownByorder = newValue!;
                                });
                              },
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Null',
                                  child: Text('Null'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Evaluation',
                                  child: Text('Evaluation'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Price',
                                  child: Text('Price'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Date',
                                  child: Text('Date'),
                                ),
                              ],
                            ),
                          ),
                          ],
                        ),
                                  SizedBox(height: screenheight * 0.1),
                                  Text(
                          'Filter by type',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                                  SizedBox(height: screenheight * 0.02),
                                  Row(
                          children: [
                            SizedBox(width: screenwidth * 0.04),
                            FilterButton(
                              label: 'Art',
                              isSelected: click_art,
                              onTap: () {
                                setState(() {
                                  click_art = !click_art;
                                });
                              },
                            ),
                            SizedBox(width: screenwidth * 0.01),
                            FilterButton(
                              label: 'Printing_Art',
                              isSelected: click_print,
                              onTap: () {
                                setState(() {
                                  click_print = !click_print;
                                });
                              },
                            ),SizedBox(width: screenwidth * 0.01),
                            FilterButton(
                              label: 'Mural_Art',
                              isSelected: click_mural,
                              onTap: () {
                                setState(() {
                                  click_mural = !click_mural;
                                });
                              },
                            ),

                          ],
                        ),
                                  SizedBox(height: screenheight * 0.01),
                                  Row(
                          children: [
                            SizedBox(width: screenwidth * 0.04),
                            FilterButton(
                              label: 'Sculpture',
                              isSelected: click_scul,
                              onTap: () {
                                setState(() {
                                  click_scul = !click_scul;
                                });
                              },
                            ),
                            SizedBox(width: screenwidth * 0.01),
                            FilterButton(
                              label: 'Graphic_Design',
                              isSelected: click_des,
                              onTap: () {
                                setState(() {
                                  click_des = !click_des;
                                });
                              },
                            ),
                          ],
                        ),
                                  SizedBox(height: screenheight * 0.01),
                                  Row(
                          children: [
                            SizedBox(width: screenwidth * 0.04),
                            FilterButton(
                              label: 'Photography',
                              isSelected: click_photo,
                              onTap: () {
                                setState(() {
                                  click_photo = !click_photo;
                                });
                              },
                            ), SizedBox(width: screenwidth * 0.01),
                            FilterButton(
                              label: 'Mosaic',
                              isSelected: click_mos,
                              onTap: () {
                                setState(() {
                                  click_mos = !click_mos;
                                });
                              },
                            ),
                          ],
                        ),
                                  SizedBox(height: screenheight * 0.05),
                                  ElevatedButton(
                          onPressed: () {
                            // Apply filter logic here
                          },
                          child: Text(
                            'Apply Filter',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: EdgeInsets.fromLTRB(70, 16, 70, 16),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
      ),
    ),
    ),
    ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
          color: isSelected ? Colors.orangeAccent : Colors.white,
          borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}