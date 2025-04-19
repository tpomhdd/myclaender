import 'package:flutter/material.dart';
import 'package:untitled/core/sqllite/db.dart';



class NotesListScreen extends StatefulWidget {
  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  SqlDb sqlDb = SqlDb();
  List<Map> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  // ✅ جلب البيانات من قاعدة البيانات
  Future<void> fetchNotes() async {
    List<Map> result = await sqlDb.readData("SELECT * FROM note");
    setState(() {
      notes = result;
    });
  }

  // ✅ حذف سجل معين
  Future<void> deleteNote(int id) async {
    await sqlDb.deleteData("DELETE FROM note WHERE id = $id");
    fetchNotes(); // إعادة تحميل القائمة بعد الحذف
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("قائمة الملاحظات"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: notes.isEmpty
          ? Center(child: CircularProgressIndicator()) // مؤشر تحميل عند انتظار البيانات
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(

              title: Text(
                notes[index]['name'] ?? "بدون عنوان",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("📅 ${notes[index]['dete']}"),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  deleteNote(notes[index]['id']);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
