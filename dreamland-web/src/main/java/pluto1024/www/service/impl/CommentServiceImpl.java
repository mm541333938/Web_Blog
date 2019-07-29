package pluto1024.www.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pluto1024.www.dao.CommentMapper;
import pluto1024.www.entity.Comment;
import pluto1024.www.service.CommentService;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentMapper commentMapper;


    public int add(Comment comment) {
        return commentMapper.insertComment(comment);
    }

    @Override
    public void update(Comment comment) {

    }

    public List<Comment> findAll(Long content_id) {

        return commentMapper.selectAll(content_id);
    }

    @Override
    public Comment findById(Long id) {
        return null;
    }

    public List<Comment> findAllFirstComment(Long content_id) {
        return commentMapper.findAllFirstComment(content_id);
    }

    public List<Comment> findAllChildrenComment(Long content_id, String children) {
        return commentMapper.findAllChildrenComment(content_id, children);
    }


    @Override
    public void deleteById(Long id) {

    }

    @Override
    public void deleteChildrenComment(String children) {

    }
}
