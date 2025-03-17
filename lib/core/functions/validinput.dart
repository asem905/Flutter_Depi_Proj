Validinput(String type, String value) {
  if (type == "email") {
    if (value.isEmpty || !value.contains("@")) {
      return "Please enter a valid email";
    } 
  }
  if (type == "phone") {
    if (value.isEmpty || value.length < 10) {
      return "Please enter a valid phone number";
    } 
  } 
  if (type == "password") {
    if (value.isEmpty || value.length < 8) {
      return "Please enter a valid password";
    } 
  } 
  if (type == "username") {
    if (value.isEmpty) {
      return "Please enter a valid username";
    } 
  }
}
