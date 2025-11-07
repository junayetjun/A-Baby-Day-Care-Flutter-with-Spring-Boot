import 'package:ababydaycare/entity/caregiver.dart';

class ViewDetailsDTO {
  final int id;
  final int jobId;
  final String jobTitle;
  final int parentId;
  final String parentName;
  final int caregiverId;
  final String caregiverName;
  final Caregiver? caregiver; // optional field

  const ViewDetailsDTO({
    required this.id,
    required this.jobId,
    required this.jobTitle,
    required this.parentId,
    required this.parentName,
    required this.caregiverId,
    required this.caregiverName,
    this.caregiver,
  });

  /// ✅ Factory constructor for creating an instance from JSON
  factory ViewDetailsDTO.fromJson(Map<String, dynamic> json) {
    return ViewDetailsDTO(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      jobId: json['jobId'] is int ? json['jobId'] : int.tryParse(json['jobId'].toString()) ?? 0,
      jobTitle: json['jobTitle']?.toString() ?? '',
      parentId: json['parentId'] is int ? json['parentId'] : int.tryParse(json['parentId'].toString()) ?? 0,
      parentName: json['parentName']?.toString() ?? '',
      caregiverId: json['caregiverId'] is int ? json['caregiverId'] : int.tryParse(json['caregiverId'].toString()) ?? 0,
      caregiverName: json['caregiverName']?.toString() ?? '',
      caregiver: json['caregiver'] != null
          ? Caregiver.fromJson(json['caregiver'] as Map<String, dynamic>)
          : null,
    );
  }

  /// ✅ Convert instance to JSON (for backend requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobId': jobId,
      'jobTitle': jobTitle,
      'parentId': parentId,
      'parentName': parentName,
      'caregiverId': caregiverId,
      'caregiverName': caregiverName,
      if (caregiver != null) 'caregiver': caregiver!.toJson(),
    };
  }
}
