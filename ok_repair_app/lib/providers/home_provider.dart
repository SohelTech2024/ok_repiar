import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  List<Map<String, dynamic>> _jobs = [];
  List<Map<String, dynamic>> _filteredJobs = [];
  String _searchQuery = '';

  List<Map<String, dynamic>> get jobs => _filteredJobs;
  List<Map<String, dynamic>> get allJobs => _jobs;

  // Initialize sample jobs data
  void initializeJobs() {
    _jobs = [
      {
        'id': '#js003',
        'issue': 'issues with camera',
        'status': 'pending',
        'customerName': 'new customerrrr',
        'device': 'redmi note 5',
        'phone': '9876543210',
        'addedDate': '20 Sept 2025',
        'customerType': 'new',
      },
      {
        'id': '#js002',
        'issue': 'Parties Order no problem',
        'status': 'pending',
        'customerName': 'ganesh services',
        'device': 'motorola edge 5G',
        'phone': '9898989898',
        'addedDate': '20 Sept 2025',
        'customerType': 'regular',
      },
      {
        'id': '#js001',
        'issue': 'Screen replacement',
        'status': 'delivered',
        'customerName': 'john doe',
        'device': 'iPhone 14',
        'phone': '9876543210',
        'addedDate': '19 Sept 2025',
        'customerType': 'regular',
      },
    ];
    _filteredJobs = _jobs;
    notifyListeners();
  }

  // Search jobs
  void searchJobs(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  // Get filtered jobs based on status
  List<Map<String, dynamic>> getFilteredJobs(String filter) {
    if (filter == 'all') return _filteredJobs;
    return _filteredJobs.where((job) => job['status'] == filter).toList();
  }

  // Get job statistics
  Map<String, int> getJobStats() {
    return {
      'pending': _jobs.where((job) => job['status'] == 'pending').length,
      'repaired': _jobs.where((job) => job['status'] == 'repaired').length,
      'delivered': _jobs.where((job) => job['status'] == 'delivered').length,
      'all': _jobs.length,
    };
  }

  // Apply search and filters
  void _applyFilters() {
    if (_searchQuery.isEmpty) {
      _filteredJobs = _jobs;
    } else {
      _filteredJobs = _jobs.where((job) {
        return job['id'].toLowerCase().contains(_searchQuery) ||
            job['customerName'].toLowerCase().contains(_searchQuery) ||
            job['device'].toLowerCase().contains(_searchQuery) ||
            job['phone'].contains(_searchQuery) ||
            job['issue'].toLowerCase().contains(_searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  // Delete job
  void deleteJob(String jobId) {
    _jobs.removeWhere((job) => job['id'] == jobId);
    _applyFilters();
    notifyListeners();
  }

  // Update job status
  void updateJobStatus(String jobId, String newStatus) {
    final jobIndex = _jobs.indexWhere((job) => job['id'] == jobId);
    if (jobIndex != -1) {
      _jobs[jobIndex]['status'] = newStatus;
      _applyFilters();
      notifyListeners();
    }
  }

  // Add new job
  void addJob(Map<String, dynamic> newJob) {
    _jobs.insert(0, newJob);
    _applyFilters();
    notifyListeners();
  }
}