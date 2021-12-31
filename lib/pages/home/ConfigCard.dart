import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'indicator.dart';

class ConfigCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ConfigCardState();
}

class ConfigCardState extends State {

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${appProvider.selectedVaccine.vaccineId} Vaccine Configuration',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text('Expiration:',
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ),
            Row(
              children: [
                Expanded(
                    child: RadioListTile(
                  value: 0,
                  groupValue: 0,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {},
                  title: Text('Period', style: TextStyle(fontSize: 10)),
                )),
                Expanded(
                    child: RadioListTile(
                  value: 1,
                  groupValue: 0,
                  onChanged: (value) {},
                  title: Text('Fixed Date', style: TextStyle(fontSize: 10)),
                )),
                Expanded(
                    child: RadioListTile(
                  value: 1,
                  groupValue: 0,
                  onChanged: (value) {},
                  title: Text('Lifetime', style: TextStyle(fontSize: 10)),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(5),
                      )),
                )),
                /*Expanded(
                  child: DropdownButtonFormField(
                    items: ['Days', 'Month', 'Years']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(5),
                        )),
                    icon: Container(),
                    menuMaxHeight: 16,
                    value: 'Days',
                  ),
                )*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
