package cn.com.newloading.utils;

public class Common {
    public static final int PAGE = 1;
    public static final int LIMIT = 10;
    public static final int IMGCOUNT = 5;
    public static final int GOODS_INDEX_LIMIT = 30;
    public static final int thDays = 7;

    public static final String INIT_A_PWD = "123456";

    public static boolean isBlank(String str){
        if(str == null) return true;
        if("".equals(str.trim())) return true;
        return false;
    }
}
