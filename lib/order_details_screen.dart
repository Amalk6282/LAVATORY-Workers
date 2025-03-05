import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details - #ORD-8945',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF2C3E50),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Content area
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Customer and Order Info Sections
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Customer Information
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C3E50),
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 8),
                                  InfoRow('Name:', 'John Smith'),
                                  SizedBox(height: 8),
                                  InfoRow('Phone:', '(555) 123-4567'),
                                  SizedBox(height: 8),
                                  InfoRow('Email:', 'john.smith@example.com'),
                                  SizedBox(height: 8),
                                  InfoRow(
                                    'Address:',
                                    '123 Main St, Apt 4B\nCityville, ST 12345',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            // Order Information
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C3E50),
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 8),
                                  InfoRow('Order ID:', '#ORD-8945'),
                                  SizedBox(height: 8),
                                  InfoRow('Date:', 'Feb 28, 2025, 10:30 AM'),
                                  SizedBox(height: 8),
                                  InfoRow('Service:', 'Wash & Fold'),
                                  SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: Text(
                                          'Status:',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFE082),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          'Pending',
                                          style: TextStyle(
                                            color: Colors.amber[800],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Spacer(),

                      // // Action Buttons
                      // Padding(
                      //   padding: EdgeInsets.all(16),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: ElevatedButton(
                      //           onPressed: () {},
                      //           style: ElevatedButton.styleFrom(
                      //             backgroundColor: Colors.blue,
                      //             foregroundColor: Colors.white,
                      //             padding: EdgeInsets.symmetric(vertical: 16),
                      //           ),
                      //           child: Text(
                      //             'Accept Order',
                      //             style: TextStyle(fontSize: 16),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(width: 8),
                      //       Expanded(
                      //         child: ElevatedButton(
                      //           onPressed: () {},
                      //           style: ElevatedButton.styleFrom(
                      //             backgroundColor: Colors.red,
                      //             foregroundColor: Colors.white,
                      //             padding: EdgeInsets.symmetric(vertical: 16),
                      //           ),
                      //           child: Text(
                      //             'Reject Order',
                      //             style: TextStyle(fontSize: 16),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(width: 8),
                      //       Expanded(
                      //         child: ElevatedButton(
                      //           onPressed: () {},
                      //           style: ElevatedButton.styleFrom(
                      //             backgroundColor: Colors.grey,
                      //             foregroundColor: Colors.white,
                      //             padding: EdgeInsets.symmetric(vertical: 16),
                      //           ),
                      //           child: Text(
                      //             'Contact Customer',
                      //             style: TextStyle(fontSize: 16),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  InfoRow(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
