import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4A50C7),
        title: Text(
          'الروزنامة',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFF4A50C7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Muhammad Almasri',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'الثلاثاء',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A50C7),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('رجب', style: TextStyle(fontSize: 18)),
                              Text('28',
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('يناير', style: TextStyle(fontSize: 18)),
                              Text('28',
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'باقي لأذان الظهر 1:47',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('الفجر', style: TextStyle(fontSize: 16)),
                              Text('5:04', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('الشمس', style: TextStyle(fontSize: 16)),
                              Text('6:33', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('الظهر', style: TextStyle(fontSize: 16)),
                              Text('1:47', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('العصر', style: TextStyle(fontSize: 16)),
                              Text('4:40', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('المغرب', style: TextStyle(fontSize: 16)),
                              Text('7:01', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('العشاء', style: TextStyle(fontSize: 16)),
                              Text('8:31', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('إعدادات الروزنامة'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('الذهاب إلى تاريخ'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
