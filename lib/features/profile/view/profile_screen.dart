import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProfileController>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.lightBlue,
      ),

      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Icon(Icons.person, size: 60, color: Colors.lightBlue),

                SizedBox(height: 20),

                // NAME
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 15),

                // EMAIL
                TextField(
                  controller: controller.emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),


                SizedBox(height: 20),

                // SAVE BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                    ),
                    onPressed: controller.isLoading
                        ? null
                        : () {
                      controller.saveProfile();
                    },

                    child: Text("Save Profile",style: TextStyle(color: Colors.black),),
                  ),
                ),
                SizedBox(height: 15),

                // LOGOUT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: controller.isLoading
                        ? null
                        : () {
                      _showLogoutDialog(context);
                    },
                    child: Text("Logout",style: TextStyle(color: Colors.white),),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showLogoutDialog(BuildContext context) {
    final controller = context.read<ProfileController>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.logout(context); // call controller method
            },
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

}
