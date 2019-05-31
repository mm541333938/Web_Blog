package pluto1024.www.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pluto1024.www.common.PageHelper;
import pluto1024.www.dao.UserContentMapper;
import pluto1024.www.entity.Comment;
import pluto1024.www.entity.UserContent;
import pluto1024.www.service.UserContentService;

import java.util.List;

@Service
public class UserContentServiceImpl implements UserContentService {

    @Autowired
    private UserContentMapper userContentMapper;

    public PageHelper.Page<UserContent> findAll(UserContent content, Integer pageNum, Integer pageSize) {
        //分页查询
        System.out.print("第" + pageNum + "页");
        System.out.print("每页显示:" + pageSize + "条");
        PageHelper.startPage(pageNum, pageSize);//开始分页
        List<UserContent> list = userContentMapper.select(content);
        PageHelper.Page endPage = PageHelper.endPage();//分页结束
        return endPage;
    }

    @Override
    public PageHelper.Page<UserContent> findAll(UserContent content, Comment comment, Integer pageNum, Integer pageSize) {
        return null;
    }

    @Override
    public PageHelper.Page<UserContent> findAllByUpvote(UserContent content, Integer pageNum, Integer pageSize) {
        return null;
    }

    @Override
    public void addContent(UserContent content) {

    }

    @Override
    public List<UserContent> findByUserId(Long uid) {
        return null;
    }

    @Override
    public List<UserContent> findAll() {
        return null;
    }

    @Override
    public UserContent findById(long id) {
        return null;
    }

    @Override
    public void updateById(UserContent content) {

    }
}
