package pluto1024.www.service;

import pluto1024.www.entity.Comment;

import java.util.List;

public interface CommentService {
    /**
     * 添加评论
     *
     * @param comment
     * @return
     */
    int add(Comment comment);

    /**
     * 更新评论
     *
     * @param comment
     */
    void update(Comment comment);

    /**
     * 根据文章id查询所有评论
     *
     * @param content_id
     * @return
     */
    List<Comment> findAll(Long content_id);

    /**
     * 根据id 查询评论
     *
     * @param id
     * @return
     */
    Comment findById(Long id);

    /**
     * 根据文章id查询所有父评论
     *
     * @param content_id
     * @return
     */
    List<Comment> findAllFirstComment(Long content_id);

    /**
     * 根据id删除评论
     *
     * @param id
     */
    void deleteById(Long id);

    /**
     * 批量删除子评论
     *
     * @param children
     */
    void deleteChildrenComment(String children);

}