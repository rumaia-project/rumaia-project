import 'package:flutter/material.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  _MyRequestsScreenState createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _allRequests = [
    {
      'location': 'BSD, Tangerang',
      'description': 'Rumah Minimalis - 3 unit',
      'people': '5 orang',
      'date': '12 Okt 2025',
      'status': 'Pending',
    },
    {
      'location': 'Bekasi Timur',
      'description': 'Townhouse 3 Lantai - 4 unit',
      'people': '3 orang',
      'date': '8 Okt 2025',
      'status': 'Pending',
    },
    {
      'location': 'Cilandak, Jakarta Selatan',
      'description': 'Rumah 2 Lantai - 5 unit',
      'people': '12 orang',
      'date': '15 Okt 2025',
      'status': 'Terkumpul',
    },
    {
      'location': 'Depok',
      'description': 'Rumah 1 Lantai - 6 unit',
      'people': '15 orang',
      'date': '5 Okt 2025',
      'status': 'Terkumpul',
    },
    {
      'location': 'Pondok Indah, Jakarta Selatan',
      'description': 'Villa Modern - 2 unit',
      'people': '8 orang',
      'date': '10 Okt 2025',
      'status': 'Proses',
    },
  ];

  List<Map<String, dynamic>> get _filteredRequests {
    switch (_selectedTab) {
      case 0: // Semua
        return _allRequests;
      case 1: // Pending
        return _allRequests
            .where((request) => request['status'] == 'Pending')
            .toList();
      case 2: // Terkumpul
        return _allRequests
            .where((request) => request['status'] == 'Terkumpul')
            .toList();
      case 3: // Proses
        return _allRequests
            .where((request) => request['status'] == 'Proses')
            .toList();
      default:
        return _allRequests;
    }
  }

  String get _tipsText {
    switch (_selectedTab) {
      case 0: // Semua
        return 'Pantau semua pengajuan pembangunan Anda di berbagai lokasi. Status yang berbeda memberikan informasi perkembangan permintaan Anda.';
      case 1: // Pending
        return 'Pengajuan dengan status "Pending" sedang menunggu lebih banyak orang yang tertarik di area yang sama. Ajak tetangga atau teman untuk bergabung!';
      case 2: // Terkumpul
        return 'Pengajuan dengan status "Terkumpul" menunjukkan banyak orang di area yang sama juga tertarik. Developer akan lebih mungkin mempertimbangkan area dengan permintaan tinggi!';
      case 3: // Proses
        return 'Pengajuan dengan status "Proses" sedang ditindaklanjuti oleh developer. Mereka akan menghubungi Anda untuk koordinasi lebih lanjut.';
      default:
        return 'Pantau perkembangan pengajuan pembangunan Anda.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pengajuan Saya',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header description
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pantau status pengajuan pembangunan Anda',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),

          // Status Tabs - Diperkecil agar semua muat
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusTab(0, 'Semua (5)'),
                _buildStatusTab(1, 'Pending (2)'),
                _buildStatusTab(2, 'Terkumpul (2)'),
                _buildStatusTab(3, 'Proses (1)'),
              ],
            ),
          ),

          SizedBox(height: 8),

          // Request List
          Expanded(
            child: _filteredRequests.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada pengajuan dengan status ini',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : ListView(
                    padding: EdgeInsets.all(16),
                    children: _filteredRequests.map((request) {
                      return Column(
                        children: [
                          _buildRequestItem(
                            location: request['location'],
                            description: request['description'],
                            people: request['people'],
                            date: request['date'],
                            status: request['status'],
                          ),
                          SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
          ),

          // Tips Section
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tips',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _tipsText,
                  style: TextStyle(color: Colors.blue[700], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTab(int index, String text) {
    bool isActive = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF1565C0) : Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.w600,
                fontSize: 12, // Diperkecil
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestItem({
    required String location,
    required String description,
    required String people,
    required String date,
    required String status,
  }) {
    Color statusColor;
    Color statusBgColor;
    String statusText = status;

    switch (status) {
      case 'Terkumpul':
        statusColor = Colors.green;
        statusBgColor = Colors.green.withOpacity(0.1);
        statusText = 'Terkumpul';
        break;
      case 'Proses':
        statusColor = Colors.blue;
        statusBgColor = Colors.blue.withOpacity(0.1);
        statusText = 'Ditindaklanjuti';
        break;
      case 'Pending':
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withOpacity(0.1);
        statusText = 'Pending';
        break;
      default:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey.withOpacity(0.1);
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Description
          Text(description, style: TextStyle(color: Colors.grey[600])),

          SizedBox(height: 12),

          // People and Date
          Row(
            children: [
              if (people.isNotEmpty) ...[
                Icon(Icons.people_outline, size: 16, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  people,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                SizedBox(width: 16),
              ],
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: Colors.grey[600],
              ),
              SizedBox(width: 4),
              Text(
                date,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
