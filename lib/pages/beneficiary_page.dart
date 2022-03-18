import 'package:flutter/material.dart';
import 'package:untitled/pages/recipients_page.dart';
import 'package:provider/provider.dart';
import '../model/contact_list.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BeneficialPage extends StatefulWidget {
  const BeneficialPage({Key? key}) : super(key: key);

  @override
  State<BeneficialPage> createState() => _BeneficialPageState();
}

class _BeneficialPageState extends State<BeneficialPage> {

  void checkConnectivity() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      var provider = Provider.of<ContactList>(context, listen: false);
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile
          || connectivityResult == ConnectivityResult.wifi) {
        provider.setFromAPI();
      }else{
        provider.setFromDB();
      }
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkConnectivity();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leadingWidth: 10,
        foregroundColor: Colors.black,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text("Beneficiary", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Icon(Icons.arrow_back_ios),
        ),
        bottom: const SearchBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("Recipients", style: TextStyle(color: Colors.grey, fontSize: 30, fontWeight: FontWeight.bold),),
            ),
            ContactListView()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        child: const Icon(Icons.add, size: 50,),
        onPressed: (){
          Navigator.of(context).pushNamed(RecipientsPage.recipients_name);
        },
      ),
    );
  }
}

class ContactListView extends StatelessWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ContactList>();
    return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: provider.contacts.length,
          itemBuilder: (context, index) => ContactView(index: index,));
  }
}

class ContactView extends StatelessWidget {
  const ContactView({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ContactList>();
    var contact = provider.contacts[index];
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        provider.delete(contact);
      },
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey
          ),
        ),
        title: Text(contact.namesurname, style: const TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(contact.number),
        trailing: GestureDetector(
          onTap: (){},
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.2,
            height: 35,
            child: const Text("Send", style: TextStyle(color: Colors.white),),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        )
      ),
    );
  }
}

class SearchBar extends StatelessWidget implements PreferredSizeWidget{
  const SearchBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                prefixIconColor: Colors.grey.shade600,
                contentPadding: EdgeInsets.zero,
                hintMaxLines: 1,
                filled: true,
                fillColor: Colors.blueGrey.shade100.withOpacity(0.3),
                hintStyle: TextStyle(color: Colors.grey.shade600),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
              ),
            ),
          ),
        ),
    );
  }
}
