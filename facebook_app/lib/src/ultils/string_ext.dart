import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

extension StringX on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool isValidPassword() {
    return this.length >= 8;
  }

  String toSha256() {
    return sha256.convert(utf8.encode(this)).toString();
  }

  String xorString(String thatString) {
    String output = this + thatString;
    return output.toSha256();
  }

  String encryptDecrypt(String input) {
    var first = this.substring(0, 6);
    var second = input.substring(0, 6);
    var output = [];
    for(var i = 0; i < 6; i++) {
      var charCode = first.codeUnitAt(i) ^ second.codeUnitAt(i);
      output.add(new String.fromCharCode(charCode));
    }
    return output.join("").toSha256();
  }

  //gui icon tu string sang emoj
  String getMyText() {
    String s = this;
    int n = s.length;
    for(int i=0;i<n;i++){
      // icon buồn
      if(i<n-1&&s[i]==":"&&s[i+1]=="(") {
        s = s.substring(0,i) + "😞"+ s.substring(i+2,n);
        i++;
      } // icon fine
      else if(i<n-1&&s[i]==":"&&s[i+1]==")") {
        s = s.substring(0,i) + "🙂"+ s.substring(i+2,n);
        i++;
      }
      else if(i<n-1&&s[i]==":"&&s[i+1]=="D") {
        s = s.substring(0,i) + "😃"+ s.substring(i+2,n);
        i++;
      }
      else if(i<n-1&&s[i]==":"&&s[i+1]=="P") {
        s = s.substring(0,i) + "😛"+ s.substring(i+2,n);
        i++;
      }
      else if(i<n-1&&s[i]==":"&&s[i+1]=="O") {
        s = s.substring(0,i) + "😮"+ s.substring(i+2,n);
        i++;
      }
      else if(i<n-1&&s[i]==":"&&s[i+1]=="/") {
        s = s.substring(0,i) + "😕"+ s.substring(i+2,n);
        i++;
      }
      else if(i<n-1&&s[i]==":"&&s[i+1]=="*") {
        s = s.substring(0,i) + "😘"+ s.substring(i+2,n);
        i++;
      }
      else if(i<n-1&&s[i]=="<"&&s[i+1]=="3") {
        s = s.substring(0,i) + "❤"+ s.substring(i+2,n);
        i++;
      }
      else if(i<n-1&&s[i]=="="&&s[i+1]=="b"){
        s = s.substring(0,i) + "👍"+ s.substring(i+2,n);
        i++;
      }
      else if(i<n-1&&s[i]==";"&&s[i+1]==")"){
        s = s.substring(0,i) + "😉"+ s.substring(i+2,n);
        i++;
      }
      else if(i<n-5&&s[i]==":"&&s[i+1]=="p"&&s[i+2]=="o"&&s[i+3]=="o"&&s[i+4]=="p"&&s[i+5]==":"){
        s = s.substring(0,i) + "💩"+ s.substring(i+6,n);
        i++;
      }
      // code thêm thì làm theo form trên
    }
    return s;
  }

  //hien thi emoj
  String getMyTextSpace() {
    String s = this;
    int n = s.length;
    if(n>=3&&s[n-3]==":"&&s[n-2]=="(") {
      if(n>=4) s = s.substring(0,n-3) + "😞 ";
      else{
        s = s.substring(0,n-3) + "😞 ";
      }
    } // icon fine
    else if(n>=3&&s[n-3]==":"&&s[n-2]==")") {
      if(n>=4) s = s.substring(0,n-3) + "🙂 ";
      else{
        s = s.substring(0,n-3) + "🙂 ";
      }
    }
    else if(n>=3&&s[n-3]==":"&&s[n-2]=="D") {
      if(n>=4)s = s.substring(0,n-3) + "😃 ";
      else{
        s = s.substring(0,n-3) + "😃 ";
      }
    }
    else if(n>=3&&s[n-3]==":"&&s[n-2]=="P") {
      if(n>=4)s = s.substring(0,n-3) + "😛 ";
      else{
        s = s.substring(0,n-3) + "😛 ";
      }
    }
    else if(n>=3&&s[n-3]==":"&&s[n-2]=="O") {
      if(n>=4)s = s.substring(0,n-3) + "😮 ";
      else{
        s = s.substring(0,n-3) + "😮 ";
      }
    }
    else if(n>=3&&s[n-3]==":"&&s[n-2]=="/") {
      if(n>=4)s = s.substring(0,n-3) + "😕 ";
      else{
        s = s.substring(0,n-3) + "😕 ";
      }
    }
    else if(n>=3&&s[n-3]==":"&&s[n-2]=="*") {
      if(n>=4)s = s.substring(0,n-3) + "😘 ";
      else{
        s = s.substring(0,n-3) + "😘 ";
      }
    }
    else if(n>=3&&s[n-3]=="<"&&s[n-2]=="3") {
      if(n>=4)s = s.substring(0,n-3) + "❤ ";
      else{
        s = s.substring(0,n-3) + "❤ ";
      }
    }
    else if(n>=3&&s[n-3]=="="&&s[n-2]=="b"){
      if(n>=4)s = s.substring(0,n-3) + "👍 ";
      else{
        s = s.substring(0,n-3) + "👍 ";
      }
    }
    else if(n>=3&&s[n-3]==";"&&s[n-2]==")"){
      if(n>=4)s = s.substring(0,n-3) + "😉 ";
      else{
        s = s.substring(0,n-3) + "😉 ";
      }
    }
    else if(n>=7&&s[n-7]==":"&&s[n-6]=="p"&&s[n-5]=="o"&&s[n-4]=="o"&&s[n-3]=="p"&&s[n-2]==":"){
      if(n>=8) s = s.substring(0,n-7) + "💩 ";
      else{
        s = s.substring(0,n-7) + "💩 ";
      }
    }
    // code thêm thì làm theo form trên

    return s;
  }
}
