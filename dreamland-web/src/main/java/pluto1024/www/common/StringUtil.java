package pluto1024.www.common;

/**
 * 自定义字符串处理函数，
 * 返回删除子评论列表中指定id后的字符串
 * 参数是以逗号分隔的子评论 id 字符串和要删除的 id
 */
public class StringUtil {
    public static String getString(String str, Long id) {
        String[] arr = str.split(",");
        String s = "";
        if (arr != null && arr.length > 0) {
            for (int i = 0; i < arr.length; i++) {
                System.out.println(id.toString().equals(arr[i]));
                if (id.toString().equals(arr[i])) {
                    System.out.println(arr[i]);
                    continue;
                } else {
                    if (i == arr.length - 1) {
                        s += arr[i];
                    } else {
                        s = s + arr[i] + ",";
                    }
                }
            }
            if (s.endsWith(",")) {
                s = s.substring(0, s.length() - 1);
            }
        }
        return s;
    }
}
