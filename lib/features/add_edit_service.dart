import 'package:flutter/material.dart';

import '../common_widgets.dart/custom_alert_dialog.dart';

class AddEditService extends StatefulWidget {
  const AddEditService({
    super.key,
  });

  @override
  State<AddEditService> createState() => _AddEditServiceState();
}

class _AddEditServiceState extends State<AddEditService> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Add Service',
      content: Column(
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
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'Price ',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
          SizedBox(width: 16),
          TextField(
            controller: hoursController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Time (hours)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.access_time),
            ),
          ),
        ],
      ),
      primaryButton: 'Save',
      onPrimaryPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
