import 'utility.dart';

class Validate{
  static bool validatePassword(String value){
    int noNum = 0;
    for(int i=0;i<value.length;i++){
      if(Check.isDigit(value[i])) noNum++;
    }
    //phải lớn 6 ký tự,có ít nhất 1 số và không được chỉ có mỗi số, ngoài số ra có thể điền ký tự đặc biệt khác tùy ý.
    return value.length>=6 && noNum != 0  && noNum != value.length;
  }
}
