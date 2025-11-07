import 'dart:convert';
import 'package:ababydaycare/DTO/apply_dto.dart';
import 'package:ababydaycare/DTO/view_details_dto.dart';
import 'package:http/http.dart' as http;

class ApplyService {
  final String baseUrl = 'http://localhost:8085/api/applications';

  // 🔐 Helper to build headers (like Angular’s getAuthHeaders)
  Map<String, String> _headers(String? token) => {
    'Content-Type': 'application/json',
    if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
  };

  // ✅ Apply for a job (create new application)
  Future<ApplyDTO> applyForJob(
      Map<String, dynamic> applyPayload, String token) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: _headers(token),
      body: json.encode(applyPayload),
    );

    if (response.statusCode == 200) {
      return ApplyDTO.fromJson(json.decode(response.body));
    } else {
      throw Exception('❌ Failed to apply for job: ${response.body}');
    }
  }

  // ✅ Get logged-in caregiver’s own applications (/my)
  Future<List<ApplyDTO>> getMyApplications(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/my'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => ApplyDTO.fromJson(e)).toList();
    } else {
      throw Exception('❌ Failed to load your applications');
    }
  }

  // ✅ Get all applicants for a specific job (Parent View)
  Future<List<ApplyDTO>> getApplicationsForJob(int jobId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/applicant/$jobId'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => ApplyDTO.fromJson(e)).toList();
    } else {
      throw Exception('❌ Failed to load applications for job');
    }
  }

  // ✅ Get detailed applicant info for a specific job (ViewDetailsDTO list)
  Future<List<ViewDetailsDTO>> getViewDetailsForJob(
      int jobId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/applicant/$jobId'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => ViewDetailsDTO.fromJson(e)).toList();
    } else {
      throw Exception('❌ Failed to load applicant details for job');
    }
  }

  // ✅ Get single caregiver’s detailed info (ViewDetailsDTO)
  Future<ViewDetailsDTO> getViewDetailsForCaregiver(
      int caregiverId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/caregiver/$caregiverId'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return ViewDetailsDTO.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          '❌ Failed to load caregiver details: ${response.statusCode}');
    }
  }

  // ✅ Get all applications (Admin)
  Future<List<ApplyDTO>> getAllApplications(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => ApplyDTO.fromJson(e)).toList();
    } else {
      throw Exception('❌ Failed to load all applications');
    }
  }

  // ✅ Get single application by ID
  Future<ApplyDTO> getApplicationById(int id, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return ApplyDTO.fromJson(json.decode(response.body));
    } else {
      throw Exception('❌ Application not found');
    }
  }

  // ✅ Update an existing application
  Future<bool> updateApplication(
      int id, Map<String, dynamic> payload, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: _headers(token),
      body: json.encode(payload),
    );

    return response.statusCode == 200;
  }

  // ✅ Delete an application
  Future<bool> deleteApplication(int id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: _headers(token),
    );

    return response.statusCode == 204;
  }
}
