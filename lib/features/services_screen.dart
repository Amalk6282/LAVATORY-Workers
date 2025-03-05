import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'add_edit_service.dart';

class LaundryService {
  String id;
  String name;
  String description;
  int price;
  int estimatedTimeHours;
  bool isPopular;

  LaundryService({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.estimatedTimeHours,
    this.isPopular = false,
  });
}

class LaundryServicesScreen extends StatefulWidget {
  @override
  _LaundryServicesScreenState createState() => _LaundryServicesScreenState();
}

class _LaundryServicesScreenState extends State<LaundryServicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Sample data for laundry services
  List<LaundryService> _services = [];

  List<LaundryService> get filteredServices {
    if (_searchController.text.isEmpty) {
      return _services;
    }

    return _services.where((service) {
      bool matchesSearch = _searchController.text.isEmpty ||
          service.name.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ) ||
          service.description.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              );

      return matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    Supabase.instance.client
        .from('laundry_services')
        .select('*')
        .then((response) {
      final data = response;
      final services = data.map((e) {
        return LaundryService(
          id: e['id'].toString(),
          name: e['name'].toString(),
          description: e['description'].toString(),
          price: e['price'],
          estimatedTimeHours: e['hours'],
          isPopular: false,
        );
      }).toList();

      setState(() {
        _services = services;
      });
    }).onError((e, s) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching services: ${e!.toString()}")));
    });

    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laundry Services Management'),
        backgroundColor: Color(0xFF2C3E50),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            SizedBox(height: 16),
            _buildServicesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        Text(
          'Services',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        // OutlinedButton.icon(
        //   icon: Icon(Icons.file_download),
        //   label: Text('Export'),
        //   onPressed: () {
        //     ScaffoldMessenger.of(
        //       context,
        //     ).showSnackBar(SnackBar(content: Text('Services list exported')));
        //   },
        //   style: OutlinedButton.styleFrom(
        //     foregroundColor: Color(0xFF2C3E50),
        //     side: BorderSide(color: Color(0xFF2C3E50)),
        //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        //   ),
        // ),
        SizedBox(width: 12),
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text('Add Service'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddEditService(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3498DB),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search services...',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // SizedBox(width: 16),
        // Expanded(
        //   flex: 2,
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 16),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(8),
        //       border: Border.all(color: Colors.grey[300]!),
        //     ),
        //     child: DropdownButtonHideUnderline(
        //       child: DropdownButton<String>(
        //         value: _selectedCategory,
        //         isExpanded: true,
        //         hint: Text('Category'),
        //         items: _categories.map((category) {
        //           return DropdownMenuItem<String>(
        //             value: category,
        //             child: Text(category),
        //           );
        //         }).toList(),
        //         onChanged: (value) {
        //           setState(() {
        //             _selectedCategory = value!;
        //           });
        //         },
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildServicesList() {
    return Expanded(
      child: filteredServices.isEmpty
          ? Center(
              child: Text(
                'No services found',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                return _buildServiceCard(service);
              },
            ),
    );
  }

  Widget _buildServiceCard(LaundryService service) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    service.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if (service.isPopular)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              service.description,
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                // _buildInfoChip(icon: Icons.category, label: service.category),
                // SizedBox(width: 12),
                _buildInfoChip(
                  icon: Icons.access_time,
                  label: '${service.estimatedTimeHours} hours',
                ),
                SizedBox(width: 12),
                _buildInfoChip(
                  icon: Icons.attach_money,
                  label: '\$${service.price.toStringAsFixed(2)}',
                  backgroundColor: Colors.green[50]!,
                  textColor: Colors.green[800]!,
                ),
                Spacer(),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showServiceDialog(service: service);
                    } else if (value == 'delete') {
                      _showDeleteConfirmation(service);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    Color backgroundColor = const Color(0xFFE3F2FD),
    Color textColor = const Color(0xFF1565C0),
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showServiceDialog({LaundryService? service}) {
    final bool isEditing = service != null;
    final nameController = TextEditingController(
      text: isEditing ? service.name : '',
    );
    final descriptionController = TextEditingController(
      text: isEditing ? service.description : '',
    );
    final priceController = TextEditingController(
      text: isEditing ? service.price.toString() : '',
    );
    final hoursController = TextEditingController(
      text: isEditing ? service.estimatedTimeHours.toString() : '',
    );

    // String selectedCategory = isEditing ? service.category : 'Wash & Fold';
    bool isPopular = isEditing ? service.isPopular : false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit Service' : 'Add New Service'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Service Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Price ',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.attach_money),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: hoursController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Time (hours)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.access_time),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 16),
                    // DropdownButtonFormField<String>(
                    //   value: selectedCategory,
                    //   decoration: InputDecoration(
                    //     labelText: 'Category',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   items:
                    //       _categories.where((c) => c != 'All Categories').map((
                    //     category,
                    //   ) {
                    //     return DropdownMenuItem<String>(
                    //       value: category,
                    //       child: Text(category),
                    //     );
                    //   }).toList(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectedCategory = value!;
                    //     });
                    //   },
                    // ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Switch(
                          value: isPopular,
                          onChanged: (value) {
                            setState(() {
                              isPopular = value;
                            });
                          },
                          activeColor: Color(0xFF3498DB),
                        ),
                        SizedBox(width: 8),
                        Text('Popular Service'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate inputs
                    if (nameController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        priceController.text.isEmpty ||
                        hoursController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }

                    // Parse inputs
                    final int price = int.tryParse(priceController.text) ?? 0;
                    final int hours = int.tryParse(hoursController.text) ?? 24;

                    if (isEditing) {
                      // Update existing service
                      setState(() {
                        service.name = nameController.text;
                        service.description = descriptionController.text;
                        service.price = price;
                        // service.category = selectedCategory;
                        service.estimatedTimeHours = hours;
                        service.isPopular = isPopular;
                      });
                    } else {
                      // Create new service
                      final newService = LaundryService(
                        id: 'SRV-${_services.length.toString().padLeft(3, '0')}',
                        name: nameController.text,
                        description: descriptionController.text,
                        price: price,
                        // category: selectedCategory,
                        estimatedTimeHours: hours,
                        isPopular: isPopular,
                      );

                      setState(() {
                        _services.add(newService);
                      });
                    }

                    Navigator.pop(context);
                    _refreshUI();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3498DB),
                  ),
                  child: Text(isEditing ? 'Update' : 'Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(LaundryService service) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Service'),
          content: Text(
            'Are you sure you want to delete "${service.name}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _services.removeWhere((s) => s.id == service.id);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Service deleted')));
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _refreshUI() {
    setState(() {});
  }
}
