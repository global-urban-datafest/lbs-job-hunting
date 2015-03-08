/*����js*/
function notEmpty(val){
    if(val==null||val==''||typeof (val)=='underfined')
        return false;
    else
        return true;
}
function Emailmatch(str){
    var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
    return reg.test(str);
}
function matchLength(str,length){
    if(notEmpty(str)){
        if(str.length>=length)
            return true;
        else
            return false;
    }else{
        return false;
    }
}