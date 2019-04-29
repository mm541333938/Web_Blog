package pluto1024.www.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pluto1024.www.dao.UserMapper;
import pluto1024.www.entity.User;
import pluto1024.www.service.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Transactional
    public int regist(User user) {
        return userMapper.insert(user);
    }

    public User login(String name, String password) {
        User user = new User();
        user.setEmail(name);
        user.setPassword(password);

        return userMapper.selectOne(user);
        //return userMapper.findUserByNameAndPwd( name,password );
    }

    public User findByEmail(String email) {
        User user = new User();
        user.setEmail(email);
        return userMapper.selectOne(user);
        // return userMapper.findByEmail(email);
    }

    public User findByEmailActive(String email) {
        User user = new User();
        user.setEmail(email);
        return userMapper.selectOne(user);
    }

    public User findByPhone(String phone) {
        User user = new User();
        user.setPhone(phone);
        return userMapper.selectOne(user);
    }

    public User findById(Long id) {
        User user = new User();
        user.setId(id);
        return userMapper.selectOne(user);
    }

    public User findById(String id) {
        User user = new User();
        Long uid = Long.valueOf(id);
        user.setId(uid);
        return userMapper.selectOne(user);
    }

    @Transactional
    public void deleteByEmail(String email) {
        User user = new User();
        user.setEmail(email);
        userMapper.delete(user);
    }

    @Transactional
    public void update(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }
}
