package pluto1024.www.service;

import pluto1024.www.common.PageHelper;
import pluto1024.www.entity.Comment;
import pluto1024.www.entity.UserContent;

import java.util.List;

public interface UserContentService {
    /**
     * 查询所有Content并分页
     *
     * @param content
     * @param pageNum
     * @param pageSize
     * @return
     */
    PageHelper.Page<UserContent> findAll(UserContent content, Integer pageNum, Integer pageSize);

    PageHelper.Page<UserContent> findAll(UserContent content, Comment comment, Integer pageNum, Integer pageSize);

    PageHelper.Page<UserContent> findAllByUpvote(UserContent content, Integer pageNum, Integer pageSize);

    /**
     * 添加文章
     *
     * @param content
     */
    void addContent(UserContent content);

    /**
     * 根据用户id查询文章集合
     *
     * @param uid
     * @return
     */
    List<UserContent> findByUserId(Long uid);

    /**
     * 查询所有文章
     *
     * @return
     */
    List<UserContent> findAll();

    /**
     * 根据文章id查找文章
     *
     * @param id
     * @return
     */
    UserContent findById(long id);

    /**
     * 根据文章id更新文章
     *
     * @param content
     * @return
     */
    void updateById(UserContent content);
}
