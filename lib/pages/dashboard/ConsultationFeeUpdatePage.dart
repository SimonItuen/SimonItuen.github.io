import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';

class ConsultationFeeUpdatePage extends StatefulWidget {
  const ConsultationFeeUpdatePage({Key? key}) : super(key: key);

  @override
  _ConsultationFeeUpdatePageState createState() =>
      _ConsultationFeeUpdatePageState();
}

class _ConsultationFeeUpdatePageState extends State<ConsultationFeeUpdatePage> {
  TextEditingController feeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isError = false;
  bool isLoading = false;
  bool isButtonPressed = false;
  bool isEditMode = false;
  ScrollController pageScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    feeController.text = (Provider.of<AppProvider>(context, listen: false)
            .currentDashboard
            .consultationFee
            .amount)
        .toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: !isEditMode
          ? AppBar(
              backgroundColor: Theme.of(context).cardColor,
              foregroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              toolbarHeight: 48,
              automaticallyImplyLeading: false,
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = true;
                    });
                  },
                  child: Text(locale!.edit),
                )
              ],
            )
          : null,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [ Scrollbar(
                interactive:true,
                controller: pageScrollController,
                child: SingleChildScrollView(
                  controller: pageScrollController,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            keyboardType: TextInputType.number,
                            controller: feeController,
                            onChanged: (val) {
                              isButtonPressed = false;
                              if (isError) {
                                formKey.currentState!.validate();
                              }
                            },
                            validator: (val) {
                              if (!isButtonPressed) {
                                return null;
                              }
                              isError = true;
                              if (val!.isEmpty) {
                                return '${locale!.consultationFee} ${locale.cannotBeEmpty}';
                              }else if (int.tryParse(val)==null) {
                                return '${locale!.consultationFee} ${locale.isInvalid}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: '${locale!.consultationFee}',
                                labelText: '${locale.consultationFee}',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Colors.blueGrey, width: 2)),
                                suffix: Text(
                                  'kr',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          if (isEditMode)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  isButtonPressed = true;
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                      isEditMode = false;
                                    });

                                    isLoading =
                                        await HttpService.updateConsultationFee(
                                            context,
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .currentDashboard
                                                .consultationFee
                                                .id,
                                            feeController.text);
                                    setState(() {});
                                  }
                                },
                                child: Text(locale.save),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: !isEditMode,
                    child: Positioned.fill(
                        child:
                            Container(color: Colors.white.withOpacity(0.7)))),
                Visibility(
                    visible: isLoading,
                    child: Positioned.fill(
                        child: Container(
                      color: Colors.white.withOpacity(0.7),
                      child: Center(child: CircularProgressIndicator()),
                    )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
