String createUniqueString(){
  final DateTime nowDate = DateTime.now();
  final String uniqueString = '${nowDate.year}${nowDate.month}${nowDate.day}${nowDate.hour}${nowDate.minute}${nowDate.second}';
  return uniqueString;
}

double createUniqueNumber(){
  final DateTime nowDate = DateTime.now();
  final String uniqueString = '${nowDate.year.toString().substring(0,1)}${nowDate.month.toString().substring(0,1)}${nowDate.day.toString().substring(0,1)}${nowDate.hour.toString().substring(0,1)}${nowDate.minute.toString().substring(0,1)}${nowDate.second.toString().substring(0,1)}';
  return double.parse(uniqueString);
}