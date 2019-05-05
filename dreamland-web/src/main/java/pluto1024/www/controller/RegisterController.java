package pluto1024.www.controller;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import pluto1024.www.common.CodeCaptchaServlet;
import pluto1024.www.common.Constants;
import pluto1024.www.common.MD5Util;
import pluto1024.www.entity.User;
import pluto1024.www.mail.SendEmail;
import pluto1024.www.service.RoleUserService;
import pluto1024.www.service.UserService;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

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


    @RequestMapping("/checkCode")
    @ResponseBody
    public Map<String, Object> checkCode(Model model, @RequestParam(value = "code", required = false) String code) {
        log.debug("注册-判断验证码" + code + "是否可用");
        Map map = new HashMap<String, Object>();
        //通过 ServletRequestAttributes 获取 Request 对象，然后通过 Request 获取 Session 对象
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        //通过 session.getAttribute 方法获取之前生成验证码时存入 session 中的验证码，赋值给 vcode
        String vcode = (String) attrs.getRequest().getSession().getAttribute(CodeCaptchaServlet.VERCODE_KEY);
        if (code.equals(vcode)) {
            //验证码正确
            map.put("message", "success");
        } else {
            //验证码错误
            map.put("message", "fail");
        }
        return map;
    }

    @Autowired//redis数据库操作模板
    private RedisTemplate<String, String> redisTemplate;

    @RequestMapping("/doRegister")
    public String doRegister(Model model, @RequestParam(value = "email", required = false) String email,
                             @RequestParam(value = "password", required = false) String password,
                             @RequestParam(value = "phone", required = false) String phone,
                             @RequestParam(value = "nickName", required = false) String nickname,
                             @RequestParam(value = "code", required = false) String code) {
        log.debug("注册...");
        if (StringUtils.isBlank(code)) {
            model.addAttribute("error", "非法注册，请重新注册!");
            return "../register";
        }

        int b = checkValidateCode(code);
        if (b == -1) {
            model.addAttribute("error", "验证码超市,请重新注册!");
            return "../register";
        } else if (b == 0) {
            model.addAttribute("error", "验证码不正确，请重新输入!");
            return "../register";
        }

        User user = userService.findByEmail(email);
        if (user != null) {
            model.addAttribute("error", "该用户已经被注册！");
            return "../register";
        } else {
            user = new User();
            user.setNickName(nickname);

            user.setPassword(MD5Util.encodeToHex("salt" + password));
            user.setPhone(phone);
            user.setEmail(email);
            user.setState("0");
            user.setEnable("0");
            user.setImgUrl("/images/icon_m.jpg");
            //邮箱激活码
            String validateCode = MD5Util.encodeToHex(Constants.SALT + email + password);
            redisTemplate.opsForValue().set(email, validateCode, 24, TimeUnit.HOURS);// 24小时 有效激活 redis保存激活码

            userService.regist(user);

            log.info("注册成功");
            SendEmail.sendEmailMessage(email, validateCode);
            String message = email + "," + validateCode;
            model.addAttribute("message", message);
            return "/regist/registerSuccess";
        }
    }

    // 匹对验证码的正确性
    public int checkValidateCode(String code) {
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        Object vercode = attrs.getRequest().getSession().getAttribute("VERCODE_KEY");

        return Constants.isVerCode(vercode, code);
        /*if (null == vercode) {
            return -1;
        }
        if (!code.equalsIgnoreCase(vercode.toString())) {
            return 0;
        }
        return 1;*/
    }

    @RequestMapping("/sendEmail")
    @ResponseBody
    public Map<String, Object> sendEmail(Model model) {
        Map map = new HashMap<String, Object>();
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        String validateCode = attrs.getRequest().getParameter("validateCode");
        String email = attrs.getRequest().getParameter("email");
        SendEmail.sendEmailMessage(email, validateCode);
        map.put("success", "success");
        return map;
    }

    @Autowired
    private RoleUserService roleUserService;

    @RequestMapping("/activecode")
    public String active(Model model) {
        log.info("==============激活验证==================");
        //判断   激活有无过期 是否正确
        //validateCode=
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        String validateCode = attrs.getRequest().getParameter("validateCode");
        String email = attrs.getRequest().getParameter("email");
        String code = redisTemplate.opsForValue().get(email);
        log.info("验证邮箱为：" + email + ",邮箱激活码为：" + code + ",用户链接的激活码为：" + validateCode);
        //判断是否已激活

        User userTrue = userService.findByEmail(email);
        if (userTrue != null && "1".equals(userTrue.getState())) {
            //已激活
            model.addAttribute("success", "您已激活,请直接登录！");
            return "../login";
        }

        if (code == null) {
            //激活码过期
            model.addAttribute("fail", "您的激活码已过期,请重新注册！");
            userService.deleteByEmail(email);
            return "/regist/activeFail";
        }

        if (StringUtils.isNotBlank(validateCode) && validateCode.equals(code)) {
            //激活码正确
            userTrue.setEnable("1");
            userTrue.setState("1");
            userService.update(userTrue);
            model.addAttribute("email", email);
            return "/regist/activeSuccess";
        } else {
            //激活码错误
            model.addAttribute("fail", "您的激活码错误,请重新激活！");
            return "/regist/activeFail";
        }
    }


}
