// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:untitled/core/app_color.dart';
// import 'package:untitled/providers/bookmark.dart';
// import 'package:untitled/widgets/horizental_divider.dart';
// import 'package:untitled/widgets/marker.dart';
// import 'package:provider/provider.dart';
//
// import 'package:untitled/widgets/myWidget/mystack.dart';
//
// import '../../providers/quran.dart';
// import '../../providers/show_overlay_provider.dart';
// import '../../quran/quran.dart';
//
// class Grid_Juaz extends StatefulWidget {
//   const Grid_Juaz({Key? key}) : super(key: key);
//
//   @override
//   State<Grid_Juaz> createState() => _Grid_JuazState();
// }
//
// class _Grid_JuazState extends State<Grid_Juaz> {
//   @override
//   Widget build(BuildContext context) {
//     final quran = Provider.of<Quran>(context, listen: false);
//     final bookMark = Provider.of<BookMarkProvider>(context);
//     final overlay = Provider.of<ShowOverlayProvider>(context, listen: false);
//     final colorScheme = Theme.of(context).colorScheme;
//     final textStyle = TextStyle(
//       color: colorScheme.juzCardText,
//       fontSize: 15,
//     );
//
//     void _goToBookMark() {
//       quran.goToPage(bookMark.markPage);
//       overlay.toggleisShowOverlay();
//       Navigator.pop(context);
//     }
//
//     return GridView.builder(mystak(
//     sourah: "الجزء"+" "+JuazNumber.toString(),
//     onPressed: (){
//     Navigator.of(context).pop();
//     getJuzPage(index+1);
//     },
//     );
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2, // number of items in each row
//       ),
//       padding: EdgeInsets.all(8.0), // padding around the grid
//       itemCount: 614, // total number of items
//       itemBuilder: (context, index) {
//         final JuazNumber = index + 1;
//
//
//       },
//     );
//   }
// }
