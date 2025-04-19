import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:untitled/Theme/color.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'core/AdManager.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("voice_memos.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE memos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        path TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertMemo(String path) async {
    final db = await database;
    String date = DateTime.now().toLocal().toString().split('.')[0];
    await db.insert("memos", {"path": path, "date": date});
  }

  Future<List<Map<String, dynamic>>> getMemos() async {
    final db = await database;
    return await db.query("memos", orderBy: "id DESC");
  }

  Future<int> deleteMemo(int id) async {
    final db = await database;
    return await db.delete("memos", where: "id = ?", whereArgs: [id]);
  }
}

class VoiceMemoScreen extends StatefulWidget {
  @override
  _VoiceMemoScreenState createState() => _VoiceMemoScreenState();
}

class _VoiceMemoScreenState extends State<VoiceMemoScreen> {
  FlutterTts flutterTts = FlutterTts();
  FlutterSoundRecorder? recorder;
  FlutterSoundPlayer player = FlutterSoundPlayer();
  bool isRecording = false;
  String? filePath;
  List<Map<String, dynamic>> memos = [];

  @override
  void initState() {
    super.initState();
    recorder = FlutterSoundRecorder();
    player.openPlayer();
    initRecorder();

    loadMemos();
    AdManager.loadInterstitialAd(() {
      print("تم إغلاق الإعلان بنجاح");
    });

  }

  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await recorder!.openRecorder();
  }

  Future<void> startRecording() async {
    if (await Permission.microphone.isDenied) {
      await Permission.microphone.request();
      return;
    }
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      filePath =
      '${tempDir.path}/voice_memo_${DateTime.now().millisecondsSinceEpoch}.aac';
      await recorder!.startRecorder(toFile: filePath, codec: Codec.aacADTS);
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print("خطأ أثناء بدء التسجيل: $e");
    }
  }

  Future<void> stopRecording() async {
    try {
      if (isRecording) {
        await recorder!.stopRecorder();
        setState(() {
          isRecording = false;
        });
        if (filePath != null) {
          await DatabaseHelper.instance.insertMemo(filePath!);
          loadMemos();
        }
      }
    } catch (e) {
      print("خطأ أثناء إيقاف التسجيل: $e");
    }
  }

  Future<void> speakDate() async {
    DateTime now = DateTime.now();
    String dateText = "اليوم هو ${now.day} من شهر ${now.month} سنة ${now.year}";
    await flutterTts.speak(dateText);
  }

  Future<void> loadMemos() async {
    memos = await DatabaseHelper.instance.getMemos();
    setState(() {});
  }

  Future<void> playMemo(String path) async {
    try {
      final file = File(path);
      if (!await file.exists()) {
        print("الملف غير موجود: $path");
        return;
      }
      if (player.isPlaying) {
        await player.stopPlayer();
      }
      await player.startPlayer(
        fromURI: path,
        codec: Codec.aacADTS,
        whenFinished: () {
          print("انتهى تشغيل المقطع.");
        },
      );
    } catch (e) {
      print("خطأ أثناء تشغيل المقطع: $e");
    }
  }

  Future<void> deleteMemo(int id, String path) async {
    try {
      // حذف الملف من التخزين
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
      // حذف السجل من قاعدة البيانات
      await DatabaseHelper.instance.deleteMemo(id);
      loadMemos();
    } catch (e) {
      print("خطأ أثناء حذف التسجيل: $e");
    }
  }

  @override
  void dispose() {
    recorder!.closeRecorder();
    player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("📌 المذكرات الصوتية", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.secondColor, AppColor.thirdColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: memos.isEmpty
                  ? Center(
                child: Text(
                  "لا توجد مذكرات حتى الآن",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: memos.length,
                itemBuilder: (context, index) {
                  final memo = memos[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: Icon(Icons.mic, color: Colors.blueAccent),
                      title: Text("تسجيل ${memo['id']}", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("📅 ${memo['date']}", style: TextStyle(color: Colors.grey[700])),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.play_arrow, color: Colors.green, size: 30),
                            onPressed: () => playMemo(memo['path']),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red, size: 30),
                            onPressed: () => deleteMemo(memo['id'], memo['path']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColor.primaryColor,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.calendar_today, color: Colors.white, size: 30),
                onPressed: speakDate,
                tooltip: "نطق التاريخ",
              ),
              IconButton(
                icon: Icon(isRecording ? Icons.stop : Icons.mic, color: Colors.white, size: 30),
                onPressed: isRecording ? stopRecording : startRecording,
                tooltip: isRecording ? "إيقاف التسجيل" : "بدء التسجيل",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isRecording ? stopRecording : startRecording,
        child: Icon(isRecording ? Icons.stop : Icons.mic, color: Colors.white),
        backgroundColor: isRecording ? Colors.red : Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
