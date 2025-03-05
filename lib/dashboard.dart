import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            color: const Color(0xFF2C3E50),
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Main content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Status cards row
                  buildStatusCardsRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the row of status cards
  Widget buildStatusCardsRow() {
    return Row(
      children: [
        Expanded(child: buildStatusCard("TODAY'S ORDERS", "24")),
        const SizedBox(width: 10),
        Expanded(child: buildStatusCard("PENDING ORDERS", "18")),
        const SizedBox(width: 10),
        Expanded(child: buildStatusCard("IN PROCESS", "12")),
        const SizedBox(width: 10),
        Expanded(child: buildStatusCard("READY FOR PICKUP", "8")),
      ],
    );
  }

  // Individual status card
  Widget buildStatusCard(String title, String count) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(left: BorderSide(color: Colors.blue, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }

  // Build the row of action buttons
  Widget buildActionButtonsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildActionButton(
            context,
            "New Order",
            Icons.add_circle_outline,
            () => showNewOrderDialog(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: buildActionButton(
            context,
            "Accept Orders",
            Icons.check_circle_outline,
            () => showAcceptOrdersDialog(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: buildActionButton(
            context,
            "Schedule Pickup",
            Icons.delivery_dining,
            () => showSchedulePickupDialog(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: buildActionButton(
            context,
            "View Reports",
            Icons.bar_chart,
            () => showReportsDialog(context),
          ),
        ),
      ],
    );
  }

  // Individual action button
  Widget buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 18), const SizedBox(width: 8), Text(text)],
      ),
    );
  }

  // Recent orders section
  Widget buildRecentOrdersSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Orders',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // Orders table container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              // Table header
              buildOrdersTableHeader(),
              // Order rows
              buildOrderRow(
                context,
                '#ORD-8945',
                'John Smith',
                'Wash & Fold',
                'Today, 10:30 AM',
                '\$24.50',
                'Pending',
                Colors.amber[100]!,
              ),
              buildOrderRow(
                context,
                '#ORD-8944',
                'Sarah Johnson',
                'Dry Cleaning',
                'Today, 9:15 AM',
                '\$35.75',
                'Processing',
                Colors.green[100]!,
              ),
              buildOrderRow(
                context,
                '#ORD-8943',
                'Mike Williams',
                'Wash & Iron',
                'Yesterday, 4:45 PM',
                '\$18.90',
                'Ready',
                Colors.blue[100]!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Orders table header
  Widget buildOrdersTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Order ID',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Customer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Services',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Amount',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Action',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Individual order row
  Widget buildOrderRow(
    BuildContext context,
    String orderId,
    String customer,
    String service,
    String date,
    String amount,
    String status,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(orderId, style: const TextStyle(color: Colors.blue)),
          ),
          Expanded(flex: 2, child: Text(customer)),
          Expanded(flex: 2, child: Text(service)),
          Expanded(flex: 2, child: Text(date)),
          Expanded(flex: 1, child: Text(amount)),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: status == 'Pending'
                      ? Colors.amber[800]
                      : status == 'Processing'
                          ? Colors.green[800]
                          : Colors.blue[800],
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => showOrderDetailsDialog(
                context,
                orderId,
                customer,
                service,
                date,
                amount,
                status,
              ),
              child: const Text('View', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }

  // DIALOG FUNCTIONS

  // New Order Dialog
  void showNewOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dialog title
                Row(
                  children: [
                    const Icon(Icons.add_circle_outline, color: Colors.blue),
                    const SizedBox(width: 10),
                    const Text(
                      'Create New Order',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Form fields
                buildDialogField('Customer Name', 'Enter customer name...'),
                const SizedBox(height: 15),
                buildDialogField('Phone Number', 'Enter phone number...'),
                const SizedBox(height: 15),
                const Text('Service Type'),
                const SizedBox(height: 5),
                buildServiceTypeDropdown(),
                const SizedBox(height: 15),
                buildDialogField('Pickup Date', 'Select date...'),
                const SizedBox(height: 15),
                buildDialogField(
                  'Notes',
                  'Add any special instructions...',
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                // Dialog actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Create Order'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Accept Orders Dialog
  void showAcceptOrdersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.blue),
                    const SizedBox(width: 10),
                    const Text(
                      'Accept Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Pending Orders to Accept:'),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildPendingOrderItem(
                          '#ORD-8945',
                          'John Smith',
                          'Wash & Fold',
                          '\$24.50',
                        ),
                        buildPendingOrderItem(
                          '#ORD-8941',
                          'Emma Davis',
                          'Dry Cleaning',
                          '\$37.25',
                        ),
                        buildPendingOrderItem(
                          '#ORD-8938',
                          'Robert Wilson',
                          'Wash & Iron',
                          '\$19.99',
                        ),
                        buildPendingOrderItem(
                          '#ORD-8937',
                          'Lisa Johnson',
                          'Wash & Fold',
                          '\$26.50',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 10),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Accept Selected'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Schedule Pickup Dialog
  void showSchedulePickupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.delivery_dining, color: Colors.blue),
                    const SizedBox(width: 10),
                    const Text(
                      'Schedule Pickup',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Orders Ready for Pickup:'),
                const SizedBox(height: 10),
                Container(
                  height: 150,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildPendingOrderItem(
                          '#ORD-8943',
                          'Mike Williams',
                          'Wash & Iron',
                          '\$18.90',
                        ),
                        buildPendingOrderItem(
                          '#ORD-8939',
                          'David Brown',
                          'Dry Cleaning',
                          '\$42.75',
                        ),
                        buildPendingOrderItem(
                          '#ORD-8934',
                          'Jennifer Lee',
                          'Wash & Fold',
                          '\$31.50',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                buildDialogField('Pickup Date', 'Select date...'),
                const SizedBox(height: 15),
                buildDialogField('Pickup Time', 'Select time...'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Schedule'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // View Reports Dialog
  void showReportsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.bar_chart, color: Colors.blue),
                    const SizedBox(width: 10),
                    const Text(
                      'Reports',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Select Report Type:'),
                const SizedBox(height: 15),
                Container(
                  height: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildReportTypeButton(
                          'Daily Sales Report',
                          Icons.today,
                        ),
                        const SizedBox(height: 10),
                        buildReportTypeButton(
                          'Weekly Order Summary',
                          Icons.date_range,
                        ),
                        const SizedBox(height: 10),
                        buildReportTypeButton(
                          'Monthly Revenue',
                          Icons.insert_chart,
                        ),
                        const SizedBox(height: 10),
                        buildReportTypeButton(
                          'Customer Activity',
                          Icons.people,
                        ),
                        const SizedBox(height: 10),
                        buildReportTypeButton(
                          'Service Popularity',
                          Icons.pie_chart,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Order Details Dialog
  void showOrderDetailsDialog(
    BuildContext context,
    String orderId,
    String customer,
    String service,
    String date,
    String amount,
    String status,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_long, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text(
                      'Order Details - $orderId',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                buildOrderDetailItem('Customer', customer),
                buildOrderDetailItem('Service', service),
                buildOrderDetailItem('Date', date),
                buildOrderDetailItem('Amount', amount),
                buildOrderDetailItem('Status', status),
                const Divider(height: 30),
                const Text(
                  'Items',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                buildOrderItem('Shirts', '3', '\$12.00'),
                buildOrderItem('Pants', '2', '\$10.00'),
                buildOrderItem('Bedsheets', '1 set', '\$8.00'),
                const Divider(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      amount,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 10),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Update Status'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // HELPER WIDGETS

  // Dialog input field
  Widget buildDialogField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  // Service type dropdown
  Widget buildServiceTypeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: const Text('Select service type'),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: 'wash_fold',
                    child: Text('Wash & Fold'),
                  ),
                  DropdownMenuItem(
                    value: 'dry_cleaning',
                    child: Text('Dry Cleaning'),
                  ),
                  DropdownMenuItem(
                    value: 'wash_iron',
                    child: Text('Wash & Iron'),
                  ),
                  DropdownMenuItem(
                    value: 'stain_removal',
                    child: Text('Stain Removal'),
                  ),
                ],
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Pending order item with checkbox
  Widget buildPendingOrderItem(
    String orderId,
    String customer,
    String service,
    String amount,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (value) {}),
          Expanded(
            flex: 2,
            child: Text(orderId, style: const TextStyle(color: Colors.blue)),
          ),
          Expanded(flex: 3, child: Text(customer)),
          Expanded(flex: 2, child: Text(service)),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Report type button
  Widget buildReportTypeButton(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }

  // Order detail item (for order details dialog)
  Widget buildOrderDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  // Order item (for order details dialog)
  Widget buildOrderItem(String item, String quantity, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(item)),
          Expanded(flex: 1, child: Text(quantity)),
          Expanded(flex: 1, child: Text(price, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
