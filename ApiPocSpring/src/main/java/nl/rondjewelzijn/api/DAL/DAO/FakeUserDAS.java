package nl.rondjewelzijn.api.DAL.DAO;

import nl.rondjewelzijn.api.BLL.models.User;
import nl.rondjewelzijn.api.DAL.interfaces.IUserDao;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class FakeUserDAS implements IUserDao {

    private static List<User> db = new ArrayList();


    @Override
    public int insertUser(UUID id, User user) {
        db.add(new User(id, user.getUsername()));
        return 1;
    }

    @Override
    public List<User> selectAllUsers() {
        return null;
    }

    @Override
    public Optional<User> selectUsersById(UUID id) {
        return Optional.empty();
    }

    @Override
    public int deleteUserById(UUID id) {
        return 0;
    }

    @Override
    public int updateUserById(UUID id, User newUser) {
        return 0;
    }
}
