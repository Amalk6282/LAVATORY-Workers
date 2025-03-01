import 'package:flutter/material.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({Key? key}) : super(key: key);

  @override
  _WorkerProfileScreenState createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  // Sample worker data - in a real app, this would come from your backend
  final Map<String, dynamic> workerData = {
    'name': 'Alex Johnson',
    'email': 'alex.johnson@lavatory.com',
    'phone': '(555) 123-4567',
    'joinDate': 'Jan 15, 2025',
    'position': 'Senior Laundry Specialist',
    'completedOrders': 248,
    'rating': 4.8,
    'address': '123 Washington St, Laundryville, NY 10001',
  };

  bool isEditing = false;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: workerData['name']);
    emailController = TextEditingController(text: workerData['email']);
    phoneController = TextEditingController(text: workerData['phone']);
    addressController = TextEditingController(text: workerData['address']);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lavatory',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            color: Colors.grey[700],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body:
      // Main content
      Expanded(
        child: Container(
          color: Colors.grey[100],
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile image
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue[50],
                        child: Text(
                          workerData['name'].toString().substring(0, 1),
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Profile info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isEditing ? 'Edit Profile' : 'Worker Profile',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      if (isEditing) {
                                        // Save changes
                                        workerData['name'] =
                                            nameController.text;
                                        workerData['email'] =
                                            emailController.text;
                                        workerData['phone'] =
                                            phoneController.text;
                                        workerData['address'] =
                                            addressController.text;
                                      }
                                      isEditing = !isEditing;
                                    });
                                  },
                                  icon: Icon(
                                    isEditing ? Icons.save : Icons.edit,
                                  ),
                                  label: Text(
                                    isEditing ? 'Save' : 'Edit Profile',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                _buildStatCard(
                                  'Completed Orders',
                                  workerData['completedOrders'].toString(),
                                ),
                                const SizedBox(width: 16),
                                _buildStatCard(
                                  'Rating',
                                  '${workerData['rating']} / 5.0',
                                ),
                                const SizedBox(width: 16),
                                _buildStatCard(
                                  'Position',
                                  workerData['position'],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Personal Information
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoField('Full Name', nameController, isEditing),
                      const Divider(),
                      _buildInfoField('Email', emailController, isEditing),
                      const Divider(),
                      _buildInfoField('Phone', phoneController, isEditing),
                      const Divider(),
                      _buildInfoField('Address', addressController, isEditing),
                      const Divider(),
                      _buildInfoRow('Join Date', workerData['joinDate']),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Schedule
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Work Schedule',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildScheduleCard(
                              'Monday',
                              '9:00 AM - 5:00 PM',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildScheduleCard(
                              'Tuesday',
                              '9:00 AM - 5:00 PM',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildScheduleCard(
                              'Wednesday',
                              '9:00 AM - 5:00 PM',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildScheduleCard(
                              'Thursday',
                              '9:00 AM - 5:00 PM',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildScheduleCard(
                              'Friday',
                              '9:00 AM - 5:00 PM',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildScheduleCard('Saturday', 'Off'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey[700]),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {},
        dense: true,
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(
    String label,
    TextEditingController controller,
    bool isEditing,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child:
                isEditing
                    ? TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    )
                    : Text(controller.text),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(String day, String hours) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            hours,
            style: TextStyle(
              color: hours == 'Off' ? Colors.red : Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }
}
