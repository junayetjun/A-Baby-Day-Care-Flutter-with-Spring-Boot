import 'package:flutter/material.dart';
import '../DTO/view_details_dto.dart';
import '../service/apply_service.dart';

class CaregiverDetailsPage extends StatefulWidget {
  final int caregiverId;
  final String token;

  const CaregiverDetailsPage({
    Key? key,
    required this.caregiverId,
    required this.token,
  }) : super(key: key);

  @override
  State<CaregiverDetailsPage> createState() => _CaregiverDetailsPageState();
}

class _CaregiverDetailsPageState extends State<CaregiverDetailsPage> {
  ViewDetailsDTO? caregiverDetails;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchCaregiverDetails();
  }

  Future<void> fetchCaregiverDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final details = await ApplyService()
          .getViewDetailsForCaregiver(widget.caregiverId, widget.token);
      setState(() {
        caregiverDetails = details;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = '❌ Failed to load caregiver details';
        isLoading = false;
      });
      debugPrint('Error fetching caregiver details: $e');
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  Widget detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.pinkAccent),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value.isNotEmpty ? value : "N/A"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("👤 Caregiver Details"),
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: goBack,
        ),
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
            : caregiverDetails == null
            ? const Center(
          child: Text(
            "🚫 No caregiver details found.",
            style: TextStyle(fontSize: 16),
          ),
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              // Job & Parent Info
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Title: ${caregiverDetails!.jobTitle}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Parent: ${caregiverDetails!.parentName}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Caregiver Photo
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.pinkAccent.shade100,
                backgroundImage:
                (caregiverDetails!.caregiver?.photo != null &&
                    caregiverDetails!.caregiver!.photo.isNotEmpty)
                    ? NetworkImage(
                    "http://localhost:8085/images/caregiver/${caregiverDetails!.caregiver!.photo}")
                    : null,
                child: (caregiverDetails!.caregiver?.photo == null ||
                    caregiverDetails!.caregiver!.photo.isEmpty)
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 20),

              // Caregiver Details
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Caregiver Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(color: Colors.grey),
                      detailRow(Icons.person, "Name", caregiverDetails!.caregiverName),
                      detailRow(Icons.email, "Email",
                          caregiverDetails!.caregiver?.email ?? ""),
                      detailRow(Icons.phone, "Phone",
                          caregiverDetails!.caregiver?.phone ?? ""),
                      detailRow(Icons.male, "Gender",
                          caregiverDetails!.caregiver?.gender ?? ""),
                      detailRow(Icons.cake, "Date of Birth",
                          caregiverDetails!.caregiver?.dateOfBirth ?? ""),
                      detailRow(Icons.home, "Address",
                          caregiverDetails!.caregiver?.address ?? ""),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
