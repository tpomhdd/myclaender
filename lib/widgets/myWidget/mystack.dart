import 'package:flutter/material.dart';
class mystak extends StatefulWidget {
  final String sourah;
  final void Function()? onPressed;
  const mystak({Key? key, required this.sourah, this.onPressed}) : super(key: key);

  @override
  State<mystak> createState() => _mystakState();
}

class _mystakState extends State<mystak> {
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: InkWell(
        onTap: widget.onPressed,
        child: Stack(


          children: [
            Container(
              width: 555,
              height: 555,
              decoration: BoxDecoration(
                ///////     color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/star.png'),
                    fit: BoxFit.cover,
//            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
                  )
              ),
              child: Center(
                child: Text(
                  widget.sourah,
                  style: TextStyle(fontSize: 18.0, color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
