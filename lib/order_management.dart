import 'package:flutter/material.dart';
import 'package:lacatory_workers/order_details_screen.dart';

class Order {
  final String id;
  final String customer;
  final String services;
  final int items;
  final String orderDate;
  final String deliveryDate;
  final double amount;
  final String status;

  Order({
    required this.id,
    required this.customer,
    required this.services,
    required this.items,
    required this.orderDate,
    required this.deliveryDate,
    required this.amount,
    required this.status,
  });
}

class OrderManagementScreen extends StatefulWidget {
  final String status;
  const OrderManagementScreen({super.key, required this.status});

  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All Statuses';
  int _currentPage = 1;

  List<Order> _orders = [
    Order(
      id: '#ORD-8945',
      customer: 'John Smith',
      services: 'Wash & Fold',
      items: 8,
      orderDate: 'Feb 28, 2025',
      deliveryDate: 'Mar 1, 2025',
      amount: 24.50,
      status: 'Pending',
    ),
    Order(
      id: '#ORD-8944',
      customer: 'Sarah Johnson',
      services: 'Dry Cleaning',
      items: 4,
      orderDate: 'Feb 28, 2025',
      deliveryDate: 'Mar 2, 2025',
      amount: 35.75,
      status: 'Process',
    ),
  ];

  List<Order> get filteredOrders {
    if (_selectedFilter == 'Today') {
      return _orders
          .where((order) => order.deliveryDate == 'Mar 1, 2025')
          .toList();
    } else {
      return _orders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 16),
              _buildOrdersTable(
                status: widget.status,
              ),
              // SizedBox(height: 16),
              // _buildPagination(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2C3E50),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Text(
            '${widget.status} Order Management',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTable({required String status}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            _buildTableHeader(),
            Expanded(
              child: ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  return _buildOrderRow(filteredOrders[index], status: status);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Order ID',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Customer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Services',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Items',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Order Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Delivery Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Amount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Status',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Action',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderRow(Order order, {required String status}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(order.id, style: TextStyle(color: Colors.grey[700])),
          ),
          Expanded(
            flex: 2,
            child: Text(
              order.customer,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              order.services,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: Text(
              order.items.toString(),
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              order.orderDate,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              order.deliveryDate,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '\$${order.amount.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Expanded(flex: 2, child: _buildStatusBadge(order.status)),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                if (status == 'Pending')
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen()),
                      );
                    },
                    child: Text('Active', style: TextStyle(color: Colors.blue)),
                  ),
                if (status == 'Active')
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen()),
                      );
                    },
                    child:
                        Text('Complete', style: TextStyle(color: Colors.blue)),
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen()),
                    );
                  },
                  child: Text('View', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor = Colors.grey[300]!;
    Color textColor = Colors.grey[800]!;

    if (status == 'Pending') {
      backgroundColor = Color(0xFFFFF9C4);
      textColor = Color(0xFFF57F17);
    } else if (status == 'Process') {
      backgroundColor = Color(0xFFE0F2F1);
      textColor = Color(0xFF00897B);
    } else if (status == 'Completed') {
      backgroundColor = Color(0xFFE8F5E9);
      textColor = Color(0xFF2E7D32);
    } else if (status == 'Cancelled') {
      backgroundColor = Color(0xFFFFEBEE);
      textColor = Color(0xFFD32F2F);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget _buildFilters() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Container(
  //           padding: EdgeInsets.symmetric(horizontal: 16),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(8),
  //             border: Border.all(color: Colors.grey[300]!),
  //           ),
  //           child: Row(
  //             children: [
  //               Icon(Icons.search, color: Colors.blue),
  //               SizedBox(width: 8),
  //               Expanded(
  //                 child: TextField(
  //                   controller: _searchController,
  //                   decoration: InputDecoration(
  //                     hintText: 'Search orders...',
  //                     border: InputBorder.none,
  //                   ),
  //                   onChanged: (value) {
  //                     setState(() {});
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       SizedBox(width: 16),
  //       _buildFilterButton('All Statuses'),
  //       SizedBox(width: 16),
  //       _buildFilterButton('Today'),
  //       SizedBox(width: 16),
  //       ElevatedButton.icon(
  //         icon: Icon(Icons.add),
  //         label: Text('New Order'),
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Color(0xFF3498DB),
  //           foregroundColor: Colors.white,
  //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  //         ),
  //         onPressed: () {
  //           _showNewOrderDialog();
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildFilterButton(String text) {
  //   bool isSelected = _selectedFilter == text;

  //   return InkWell(
  //     onTap: () {
  //       setState(() {
  //         _selectedFilter = text;
  //       });
  //     },
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(
  //           color: isSelected ? Color(0xFF3498DB) : Colors.grey[300]!,
  //           width: isSelected ? 2 : 1,
  //         ),
  //       ),
  //       child: Text(
  //         text,
  //         style: TextStyle(
  //           color: isSelected ? Color(0xFF3498DB) : Colors.grey[700],
  //           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
  //         ),
  //       ),
  //     ),
  //   );
  // }
//   Widget _buildPagination() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildPaginationButton('«', _currentPage > 1, () {
//           if (_currentPage > 1) {
//             setState(() {
//               _currentPage--;
//             });
//           }
//         }),
//         _buildPaginationButton('1', _currentPage != 1, () {
//           setState(() {
//             _currentPage = 1;
//           });
//         }, isActive: _currentPage == 1),
//         _buildPaginationButton('2', _currentPage != 2, () {
//           setState(() {
//             _currentPage = 2;
//           });
//         }, isActive: _currentPage == 2),
//         _buildPaginationButton('»', true, () {
//           setState(() {
//             _currentPage = 2;
//           });
//         }),
//       ],
//     );
//   }

//   Widget _buildPaginationButton(
//     String text,
//     bool enabled,
//     VoidCallback onPressed, {
//     bool isActive = false,
//   }) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 4),
//       child: InkWell(
//         onTap: enabled ? onPressed : null,
//         child: Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: isActive ? Color(0xFF3498DB) : Colors.white,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: Colors.grey[300]!),
//           ),
//           child: Center(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: isActive
//                     ? Colors.white
//                     : enabled
//                         ? Colors.grey[800]
//                         : Colors.grey[400],
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showOrderDetails(Order order) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Order Details'),
//           content: Container(
//             width: double.maxFinite,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildDetailRow('Order ID', order.id),
//                 _buildDetailRow('Customer', order.customer),
//                 _buildDetailRow('Services', order.services),
//                 _buildDetailRow('Items', order.items.toString()),
//                 _buildDetailRow('Order Date', order.orderDate),
//                 _buildDetailRow('Delivery Date', order.deliveryDate),
//                 _buildDetailRow(
//                   'Amount',
//                   '\$${order.amount.toStringAsFixed(2)}',
//                 ),
//                 _buildDetailRow('Status', order.status),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Close'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle updating order status
//                 setState(() {
//                   // Update order status here
//                 });
//                 Navigator.pop(context);
//               },
//               child: Text('Update Status'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Text(
//               label + ':',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[700],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(value, style: TextStyle(color: Colors.grey[900])),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showNewOrderDialog() {
//     TextEditingController customerController = TextEditingController();
//     TextEditingController servicesController = TextEditingController();
//     TextEditingController itemsController = TextEditingController();
//     TextEditingController amountController = TextEditingController();
//     String status = 'Pending';

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('New Order'),
//           content: Container(
//             width: double.maxFinite,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: customerController,
//                   decoration: InputDecoration(labelText: 'Customer Name'),
//                 ),
//                 TextField(
//                   controller: servicesController,
//                   decoration: InputDecoration(labelText: 'Services'),
//                 ),
//                 TextField(
//                   controller: itemsController,
//                   decoration: InputDecoration(labelText: 'Number of Items'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 TextField(
//                   controller: amountController,
//                   decoration: InputDecoration(labelText: 'Amount'),
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 ),
//                 SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   value: status,
//                   decoration: InputDecoration(labelText: 'Status'),
//                   items: ['Pending', 'Process', 'Completed', 'Cancelled']
//                       .map(
//                         (status) => DropdownMenuItem(
//                           value: status,
//                           child: Text(status),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (value) {
//                     status = value!;
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Get last order ID and increment
//                 String lastId = _orders.first.id;
//                 int orderNumber = int.parse(lastId.split('-')[1]) + 1;
//                 String newId = '#ORD-${orderNumber.toString()}';

//                 // Get today's date and delivery date (1 day from now)
//                 DateTime now = DateTime.now();
//                 String orderDate = '${now.month} ${now.day}, ${now.year}';
//                 DateTime delivery = now.add(Duration(days: 1));
//                 String deliveryDate =
//                     '${delivery.month} ${delivery.day}, ${delivery.year}';

//                 // Create new order
//                 Order newOrder = Order(
//                   id: newId,
//                   customer: customerController.text,
//                   services: servicesController.text,
//                   items: int.tryParse(itemsController.text) ?? 0,
//                   orderDate: orderDate,
//                   deliveryDate: deliveryDate,
//                   amount: double.tryParse(amountController.text) ?? 0.0,
//                   status: status,
//                 );

//                 // Add to orders list
//                 setState(() {
//                   _orders.insert(0, newOrder); // Add at beginning
//                 });

//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
}
