package pluto1024.www.common;

public class Constants {
    public static final String SALT = "salt";

    /**
     *  匹对验证码的正确性
     * @param vercode
     * @param code
     * @return
     */
    public static int isVerCode(Object vercode, String code){
        if (null == vercode) {
            return -1;
        }
        if (!code.equalsIgnoreCase(vercode.toString())) {
            return 0;
        }
        return 1;
    }
}
