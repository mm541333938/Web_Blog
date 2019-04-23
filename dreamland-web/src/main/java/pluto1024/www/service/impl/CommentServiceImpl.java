package pluto1024.www.service.impl;

import org.springframework.stereotype.Service;
import pluto1024.www.entity.Comment;
import pluto1024.www.service.CommentService;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Override
    public int add(Comment comment) {
        return 0;
    }

    @Override
    public void update(Comment comment) {

    }

    @Override
    public List<Comment> findAll(Long content_id) {
        return null;
    }

    @Override
    public Comment findById(Long id) {
        return null;
    }

    @Override
    public List<Comment> findAllFirstComment(Long content_id) {
        return null;
    }

    @Override
    public void deleteById(Long id) {

    }

    @Override
    public void deleteChildrenComment(String children) {

    }
}
