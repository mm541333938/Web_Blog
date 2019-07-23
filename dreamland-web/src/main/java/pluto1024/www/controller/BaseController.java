package pluto1024.www.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import pluto1024.www.common.PageHelper.Page;
import pluto1024.www.entity.Comment;
import pluto1024.www.entity.User;
import pluto1024.www.entity.UserContent;
import pluto1024.www.service.UserContentService;
import pluto1024.www.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;


@Component //注解表明一个类会作为组件类，并告知Spring要为这个类创建bean
public class BaseController {
    private static final String[] HEADERS_TO_TRY = {
            "X-Forwarded-For",
            "Proxy-Client-IP",
            "WL-Proxy-Client-IP",
            "HTTP_X_FORWARDED_FOR",
            "HTTP_X_FORWARDED",
            "HTTP_X_CLUSTER_CLIENT_IP",
            "HTTP_CLIENT_IP",
            "HTTP_FORWARDED_FOR",
            "HTTP_FORWARDED",
            "HTTP_VIA",
            "REMOTE_ADDR",
            "X-Real-IP"};

    @Autowired
    private UserContentService userContentService;
    @Autowired
    private UserService userService;

    public boolean isLogin(Long id) {
        if (id != null) {
            User user = userService.findById(id);
            if (user != null) {
                return true;
            }
        }
        return false;
    }

    public User getUser(Long id) {
        User user = userService.findById(id);
        return user;
    }

    public List<UserContent> getUserContentList(Long uid) {
        List<UserContent> list = userContentService.findByUserId(uid);
        return list;
    }

    public List<UserContent> getAllUserContentList() {
        List<UserContent> list = userContentService.findAll();
        return list;
    }

    public Page<UserContent> findAll(UserContent content, Integer pageNum, Integer pageSize) {
        Page<UserContent> page = userContentService.findAll(content, pageNum, pageSize);
        return page;
    }

    public Page<UserContent> findAll(UserContent content, Comment comment, Integer pageNum, Integer pageSize) {
        Page<UserContent> page = userContentService.findAll(content, comment, pageNum, pageSize);
        return page;
    }

    public Page<UserContent> findAllByUpvote(UserContent content, Integer pageNum, Integer pageSize) {
        Page<UserContent> page = userContentService.findAllByUpvote(content, pageNum, pageSize);
        return page;
    }

    /**
     * 获取request
     *
     * @return
     */
    public static HttpServletRequest getRequest() {
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        return attrs.getRequest();
    }

    /**
     * 获取response
     *
     * @return
     */
    public static HttpServletResponse getResponse() {
        HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
        return response;
    }

    /**
     * 获取session
     *
     * @return
     */
    public static HttpSession getSession() {
        HttpSession session = null;
        try {
            session = getRequest().getSession();
        } catch (Exception e) {
        }
        return session;
    }

    /***
     * 获取客户端ip地址(可以穿透代理)
     * @return
     */
    public static String getClientIpAddress() {
        HttpServletRequest request = getRequest();
        for (String header : HEADERS_TO_TRY) {
            String ip = request.getHeader(header);
            if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
                return ip;
            }
        }
        return request.getRemoteAddr();
    }
    // 匹对验证码的正确性
    /*public int checkValidateCode(String code){
        Object vercode = getRequest().getSession().getAttribute("VERCODE_KEY");
        if (vercode == null) {
            return -1;
        }
        if (!code.equalsIgnoreCase(vercode.toString())) {
            return 0;
        }
        return 1;
    }*/

}
