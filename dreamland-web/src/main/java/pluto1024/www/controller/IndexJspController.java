package pluto1024.www.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import pluto1024.www.common.PageHelper.*;
import pluto1024.www.entity.Comment;
import pluto1024.www.entity.Upvote;
import pluto1024.www.entity.User;
import pluto1024.www.entity.UserContent;
import pluto1024.www.service.CommentService;
import pluto1024.www.service.UpvoteService;
import pluto1024.www.service.UserContentService;
import pluto1024.www.service.UserService;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexJspController extends BaseController {
    private final static Logger log = Logger.getLogger(IndexJspController.class);
    @Autowired
    private UserContentService userContentService;
    @Autowired
    private UpvoteService upvoteService;

    @RequestMapping("/index_list")
    public String findAllList(Model model, @RequestParam(value = "id", required = false) String id,
                              @RequestParam(value = "pageNum", required = false) Integer pageNum,
                              @RequestParam(value = "pageSize", required = false) Integer pageSize) {

        log.info("===========进入index_list=========");
        User user = (User) getSession().getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
        Page<UserContent> page = findAll(null, pageNum, pageSize);
        model.addAttribute("page", page);
        return "../index";
    }

    @RequestMapping("/upvote")
    @ResponseBody
    public Map<String, Object> upvote(Model model, @RequestParam(value = "id", required = false) long id,
                                      @RequestParam(value = "uid", required = false) long uid,
                                      @RequestParam(value = "upvote", required = false) int upvote) {
        log.info("id=" + id + ",uid=" + uid + ",upvote=" + upvote);
        Map map = new HashMap<String, Object>();
        User user = (User) getSession().getAttribute("user");
        if (user == null) {
            map.put("data", "fail");
            return map;
        }
        Upvote up = new Upvote();
        up.setContentId(id);
        up.setId(user.getId());
        Upvote upv = upvoteService.findByUidAndConId(up);
        if (upv != null) {
            log.info(upv.toString() + "=====================");
        }
        UserContent userContent = userContentService.findById(id);
        if (upvote == -1) {
            if (upv != null) {
                if ("1".equals(upv.getDownvote())) {
                    map.put("data", "down");
                    return map;
                } else {
                    upv.setDownvote("1");
                    upv.setUpvoteTime(new Date());
                    upv.setIp(getClientIpAddress());
                    upvoteService.update(upv);
                }
            } else {
                up.setDownvote("1");
                up.setUpvoteTime(new Date());
                up.setIp(getClientIpAddress());
                upvoteService.add(up);
            }
            userContent.setDownvote(userContent.getDownvote() + upvote);
        } else {
            if (upv != null) {
                if ("1".equals(upv.getUpvote())) {
                    map.put("data", "done");
                    return map;
                } else {
                    upv.setUpvote("1");
                    upv.setUpvoteTime(new Date());
                    upv.setIp(getClientIpAddress());
                    upvoteService.update(upv);
                }
            } else {
                up.setUpvote("1");
                up.setUpvoteTime(new Date());
                up.setIp(getClientIpAddress());
                upvoteService.add(up);
            }

            userContent.setUpvote(userContent.getUpvote() + upvote);
        }
        userContentService.updateById(userContent);
        map.put("data", "success");
        return map;
    }

    @Autowired
    private CommentService commentService;
    @Autowired
    private UserService userService;

    public Map<String, Object> reply(Model model, @RequestParam(value = "content_id", required = false) Long content_id) {
        Map map = new HashMap<String, Object>();
        List<Comment> list = commentService.findAllFirstComment(content_id);
        if (list != null && list.size() > 0) {
            for (Comment c : list) {
                List<Comment> kidList = commentService.findAllChildrenComment(c.getConId(), c.getChildren());
                if (kidList != null && kidList.size() > 0) {
                    for (Comment com : kidList) {
                        if (com.getById() != null) {
                            User byUser = userService.findById(com.getById());
                            com.setByUser(byUser);
                        }
                    }
                }
                c.setComList(kidList);
            }
        }
        map.put("list", list);
        return map;
    }




}
