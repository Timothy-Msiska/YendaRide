import 'package:flutter/material.dart';

class ContactSupportPage extends StatefulWidget {
  @override
  _ContactSupportPageState createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, String>> _chatMessages = [];
  final TextEditingController _chatController = TextEditingController();

  void _submitSupportForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      // Simulate sending form (can connect to backend here)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Support request submitted!"),
          backgroundColor: Colors.green,
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  void _sendChatMessage() {
    final text = _chatController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _chatMessages.add({"sender": "You", "text": text});
      });
      _chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Contact Support"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Support Form", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(_nameController, "Name"),
                  SizedBox(height: 10),
                  _buildTextField(_emailController, "Email", keyboardType: TextInputType.emailAddress),
                  SizedBox(height: 10),
                  _buildTextField(_messageController, "Message", maxLines: 3),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitSupportForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child: Text("Submit", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.yellow, height: 40),
            Text("Live Chat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
            SizedBox(height: 10),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: _chatMessages.length,
                itemBuilder: (context, index) {
                  final msg = _chatMessages[index];
                  return ListTile(
                    title: Text(
                      "${msg['sender']}: ${msg['text']}",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _sendChatMessage,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                  child: Icon(Icons.send, color: Colors.black),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.yellow),
        filled: true,
        fillColor: Colors.grey.shade900,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) => value == null || value.isEmpty ? "This field is required" : null,
    );
  }
}
