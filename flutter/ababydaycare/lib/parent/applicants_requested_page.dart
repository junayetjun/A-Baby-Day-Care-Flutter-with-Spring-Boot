import 'package:ababydaycare/parent/view_details_of_caregiver.dart';
import 'package:flutter/material.dart';
import '../DTO/apply_dto.dart';
import '../service/apply_service.dart';

class ParentJobApplicationPage extends StatefulWidget {
  final int jobId;
  final String token; // 🔐 Required for the API call

  const ParentJobApplicationPage({
    Key? key,
    required this.jobId,
    required this.token,
  }) : super(key: key);

  @override
  State<ParentJobApplicationPage> createState() => _ParentJobApplicationPageState();
}

class _ParentJobApplicationPageState extends State<ParentJobApplicationPage> {
  List<ApplyDTO> applications = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result =
      await ApplyService().getApplicationsForJob(widget.jobId, widget.token);
      setState(() {
        applications = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = '❌ Failed to load applications.';
        isLoading = false;
      });
      debugPrint('Error fetching applications: $e');
    }
  }

  void viewDetails(int caregiverId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CaregiverDetailsPage(
          caregiverId: caregiverId,
          token: widget.token, // pass token from parent page
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          "👥 Applicants",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(color: Colors.pinkAccent),
        )
            : errorMessage != null
            ? Center(
          child: Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        )
            : applications.isEmpty
            ? const Center(
          child: Text(
            "🚫 No applicants found for this job.",
            style: TextStyle(fontSize: 16),
          ),
        )
            : ListView.builder(
          itemCount: applications.length,
          itemBuilder: (context, index) {
            final app = applications[index];
            return Card(
              elevation: 4,
              shadowColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.pinkAccent,
                  child: Text(
                    app.caregiverName.isNotEmpty
                        ? app.caregiverName[0].toUpperCase()
                        : "?",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  "Caregiver Name: ${app.caregiverName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Job: ${app.jobTitle}"),
                      Text("Parent Name: ${app.parentName}"),
                      Text("Apply ID: ${app.id}"),
                    ],
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.pinkAccent),
                onTap: () => viewDetails(app.caregiverId),
              ),
            );
          },
        ),
      ),
    );
  }
}
