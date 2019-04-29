package pluto1024.www.service;

import pluto1024.www.entity.User;

/**
 * 用户接口
 * 接口一般主要包含增删改查方法
 */
public interface UserService {
    /**
     * 用户注册
     *
     * @param user
     * @return
     */
    int regist(User user);

    /**
     * 用户登录
     *
     * @param email
     * @param password
     * @return
     */
    User login(String email, String password);

    /**
     * 根据用户邮箱查询用户
     *
     * @param email
     * @return
     */
    User findByEmail(String email);

    /**
     * 根据用户手机号查询用户
     *
     * @param phone
     * @return
     */
    User findByPhone(String phone);

    /**
     * 根据id查询用户
     *
     * @param id
     * @return
     */
    User findById(Long id);

    /**
     * 根据邮箱账户删除用户
     *
     * @param email
     */
    void deleteByEmail(String email);

    /**
     * 更新用户信息
     *
     * @param user
     */
    void update(User user);
}
