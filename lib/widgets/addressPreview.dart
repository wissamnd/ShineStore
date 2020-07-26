import 'package:flutter/material.dart';

class AddressPreview extends StatefulWidget {
  final IconData icon;
  final String iconText;
  const AddressPreview({Key key, this.icon, this.iconText}) : super(key: key);
  @override
  _AddressPreviewState createState() => _AddressPreviewState();
}

class _AddressPreviewState extends State<AddressPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueGrey[50],
      ),
      padding: EdgeInsets.all(8),
      child: Tooltip(
        message: "Edit " + widget.iconText,
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    widget.icon,
                    size: 40,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.iconText,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text("Malrilda Clen", style: TextStyle(fontSize: 15)),
                    Text("Bliss Street, Hamra", style: TextStyle(fontSize: 15)),
                    Text("Beirut, Lebanon", style: TextStyle(fontSize: 15)),
                    Text("+961 03 555 444", style: TextStyle(fontSize: 15))
                  ],
                ),
              ),
              // Expanded(child: Icon(Icons.arrow_right))
            ],
          ),
        ),
      ),
    );
  }
}
