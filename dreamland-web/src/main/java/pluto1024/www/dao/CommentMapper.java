package pluto1024.www.dao;

import org.apache.ibatis.annotations.Param;
import pluto1024.www.entity.Comment;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface CommentMapper extends Mapper<Comment> {
    //根据文章id查询所有评论
    List<Comment> selectAll(@Param("cid") long cid);

    //根据文章id 查询所有一级评论
    List<Comment> findAllFirstComment(@Param("cid") long cid);

    //根据文章id和二级评论ids 查询许哦有二级评论
    List<Comment> findAllChildrenComment(@Param("cid") long cid, @Param("children") String children);

    //插入平路并返回主键id 返回值是影响行数 id 在Comment对象中
    int insertComment(Comment comment);
}
