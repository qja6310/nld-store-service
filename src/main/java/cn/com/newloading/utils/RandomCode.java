package cn.com.newloading.utils;

import java.util.Random;

public class RandomCode {

    private static final int PC = 6;
    private static final int SC = 10;

    /**
     * 随机生成编码
     * @return
     */
    public static String generateCode(){
        StringBuffer code = new StringBuffer();
        String prefix = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
        String[] prefixArr = prefix.split(",");
        for (int i = 0;i < PC;i++){
            int index = new Random().nextInt(prefixArr.length);
            code.append(prefixArr[index]);
        }
        for (int i = 0;i < SC;i++){
            code.append(new Random().nextInt(10));
        }
        return code.toString();
    }
}
