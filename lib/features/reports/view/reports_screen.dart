import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/reports_controller.dart';

class ReportsScreen extends StatefulWidget {
  @override
  State<ReportsScreen> createState() =>
      _ReportsScreenState();
}

class _ReportsScreenState
    extends State<ReportsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportsController>().loadReport();
    });
  }


  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReportsController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Reports"),
        backgroundColor: Colors.lightBlue,
      ),

      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildReport(controller),
    );
  }

  Widget _buildReport(ReportsController controller) {
    if (controller.error != null) {
      return Center(child: Text(controller.error!));
    }

    if (controller.report == null ||
        controller.report!.isEmpty) {
      return Center(child: Text("No Report Data"));
    }

    final report = controller.report!;

    return ListView(
      padding: EdgeInsets.all(16),
      children: report.entries.map((e) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5)
            ],
          ),

          child: Row(
            children: [

              Icon(Icons.calendar_month,
                  color: Colors.lightBlue),

              SizedBox(width: 12),

              Expanded(
                child: Text(
                  e.key,
                  style: TextStyle(
                      fontWeight: FontWeight.bold),
                ),
              ),

              Text(
                "Rs ${e.value}",
                style: TextStyle(
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
