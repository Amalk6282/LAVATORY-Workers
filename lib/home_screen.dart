import 'package:flutter/material.dart';
import 'package:lacatory_workers/dashboard.dart';
import 'package:lacatory_workers/login_page.dart';
import 'package:lacatory_workers/order_details_screen.dart';
import 'package:lacatory_workers/order_management.dart';
import 'package:lacatory_workers/services_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 60.0),
                Text(
                  'Lavatory',
                  style: TextStyle(fontSize: 25, color: Colors.blue),
                ),
                SizedBox(height: 80.0),
                DrawerItemButton(
                  inverse: _tabController.index == 0,
                  iconData: Icons.dashboard,
                  label: 'Dashboard',
                  onTap: () {
                    _tabController.animateTo(0);
                    setState(() {});
                  },
                ),
                DrawerItemButton(
                  inverse: _tabController.index == 1,
                  iconData: Icons.book_online_outlined,
                  label: 'Order Details',
                  onTap: () {
                    _tabController.animateTo(1);
                    setState(() {});
                  },
                ),
                DrawerItemButton(
                  inverse: _tabController.index == 2,
                  iconData: Icons.home_repair_service_outlined,
                  label: 'Laundry Services',
                  onTap: () {
                    _tabController.animateTo(2);
                    setState(() {});
                  },
                ),

                Spacer(),
                DrawerItemButton(
                  inverse: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  iconData: Icons.logout,
                  label: "Log out",
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                DashboardScreen(),
                OrderManagementScreen(),
                LaundryServicesScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItemButton extends StatelessWidget {
  final Function() onTap;
  final bool inverse;
  final IconData iconData;
  final String label;
  const DrawerItemButton({
    super.key,
    required this.onTap,
    this.inverse = true,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: inverse ? Color(0xFFE7EEE7) : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Icon(iconData, color: inverse ? Colors.blue : Colors.black),
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(color: inverse ? Colors.blue : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
