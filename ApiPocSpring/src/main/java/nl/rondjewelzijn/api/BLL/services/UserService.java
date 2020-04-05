package nl.rondjewelzijn.api.BLL.services;

import nl.rondjewelzijn.api.BLL.models.User;
import nl.rondjewelzijn.api.DAL.interfaces.IUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserService {

    private IUserDao userDao;

    @Autowired
    public UserService(@Qualifier("postgres") IUserDao userDao){
        this.userDao = userDao;
    }

    public int addUser(User user){
        return userDao.insertUser(user);
    }

    public List<User> getAllUsers(){
        return userDao.selectAllUsers();
    }

    public Optional<User> getUserById(UUID id){
        return userDao.selectUsersById(id);
    }

    public int deleteUser(UUID id){
        return userDao.deleteUserById(id);
    }

    public int updateUser(UUID id, User newUser){
        return userDao.updateUserById(id, newUser);
    }

}
