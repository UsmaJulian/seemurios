
import 'package:seemur/src/pages/add_client_screen.dart';
import 'package:seemur/src/pages/leading_screen.dart';

abstract class Content {
  Future<LeadingPage> lista();

  Future<ClientAddPage> admin();
}

class ContentPage implements Content {
  Future<LeadingPage> lista() async {
    return LeadingPage();
  }



  Future<ClientAddPage> admin() async {
    return ClientAddPage();
  }


}