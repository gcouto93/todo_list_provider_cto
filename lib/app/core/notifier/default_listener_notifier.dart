import 'package:cto_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class DefaultListenerNotifier {
  DefaultChangeNotifier changeNotifier;

  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidCallback successCallback,
    EverCallback? everCallback,
    ErrorVoidCallback? errorCallback
    }) {
    changeNotifier.addListener(() {
      if(everCallback !=  null) {
        everCallback(changeNotifier, this);
      }

      if(changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }
      if(changeNotifier.hasError) {
        if(errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
            successCallback(changeNotifier, this);
      }
    });
  }
  void dispose() {
    changeNotifier.removeListener((){});
  }
}

typedef SuccessVoidCallback = void Function(
  DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance
);
typedef ErrorVoidCallback = void Function(
  DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance
);
typedef EverCallback = void Function(
  DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance
);