import 'package:flutter/material.dart';
import 'package:lacatory_workers/util/value_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../common_widgets.dart/custom_alert_dialog.dart';

class AddEditService extends StatefulWidget {
  final Map? serviceDetails;
  const AddEditService({
    super.key,
    this.serviceDetails,
  });

  @override
  State<AddEditService> createState() => _AddEditServiceState();
}

class _AddEditServiceState extends State<AddEditService> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    if (widget.serviceDetails != null) {
      nameController.text = widget.serviceDetails!['name'];
      descriptionController.text = widget.serviceDetails!['description'];
      priceController.text = widget.serviceDetails!['price'].toString();
      hoursController.text = widget.serviceDetails!['hours'].toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Add Service',
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              validator: alphanumericWithSpecialCharsValidator,
              decoration: InputDecoration(
                labelText: 'Service Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              validator: alphanumericWithSpecialCharsValidator,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: priceController,
              validator: numericValidator,
              decoration: InputDecoration(
                labelText: 'Price ',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              validator: numericValidator,
              decoration: InputDecoration(
                labelText: 'Time (hours)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time),
              ),
            ),
          ],
        ),
      ),
      primaryButton: 'Save',
      isLoading: _isLoading,
      onPrimaryPressed: _isLoading
          ? null
          : () async {
              if (formKey.currentState?.validate() ?? false) {
                setState(() {
                  _isLoading = true;
                });

                try {
                  final supabase = Supabase.instance.client;

                  if (widget.serviceDetails != null) {
                    await supabase.from('laundry_services').update({
                      'name': nameController.text.trim(),
                      'description': descriptionController.text.trim(),
                      'price': int.parse(priceController.text.trim()),
                      'hours': int.parse(hoursController.text.trim()),
                    }).eq('id', widget.serviceDetails!['id']);
                  } else {
                    await supabase.from('laundry_services').insert({
                      'name': nameController.text.trim(),
                      'description': descriptionController.text.trim(),
                      'price': int.parse(priceController.text.trim()),
                      'hub_user_id': supabase.auth.currentUser!.id,
                      'hours': int.parse(hoursController.text.trim()),
                    });
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }

                setState(() {
                  _isLoading = false;
                });

                Navigator.pop(context);
              }
            },
    );
  }
}
