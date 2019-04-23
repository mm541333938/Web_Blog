package pluto1024.www.service.impl;

import org.springframework.stereotype.Service;
import pluto1024.www.entity.User;
import pluto1024.www.service.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Override
    public int regist(User user) {
        return 0;
    }

    @Override
    public User login(String email, String password) {
        return null;
    }

    @Override
    public User findByEmail(String email) {
        return null;
    }

    @Override
    public User findByEail(String phone) {
        return null;
    }

    @Override
    public User findById(Long id) {
        return null;
    }

    @Override
    public void deleteByEmail(String email) {

    }

    @Override
    public void update(User user) {

    }
}
