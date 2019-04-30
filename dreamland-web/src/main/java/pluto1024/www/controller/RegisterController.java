package pluto1024.www.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import pluto1024.www.entity.User;
import pluto1024.www.service.UserService;

import java.util.HashMap;
import java.util.Map;

@Controller
public class RegisterController {
    //通过 Logger.getLogger 方法获取日志对象 Logger，参数就是要打印的类的字节码文件
    private final static Logger log = Logger.getLogger(RegisterController.class);
    //通过 @Autowired 注解注入 UserService 对象，可调用其中的方法
    private UserService userService;

    //@RequestMapping 注解映射前端访问的 URL 路径，这里对应的就是 AJAX 请求的 URL
    @RequestMapping("/checkPhone")
    //@ResponseBody 注解作用是返回 JSON 格式的数据
    @ResponseBody
    //@RequestParam 注解接收前台传来的参数，value 对应参数的名字，required=false 代表该参数是非必须的，
    // 可以没有，后面的 String phone 用来接收参数的值，类型为 String 类型
    public Map<String, Object> checkPhone(Model model, @RequestParam(value = "phone", required = false) String phone) {
        log.debug("注册-判断手机号" + phone + "是否可用");
        Map map = new HashMap<String, Object>();
        User user = userService.findByPhone(phone);
        if (user == null) {
            //未注册
            map.put("message", "success");
        } else {
            //手机号已注册
            map.put("message", "fail");
        }
        return map;
    }
}
