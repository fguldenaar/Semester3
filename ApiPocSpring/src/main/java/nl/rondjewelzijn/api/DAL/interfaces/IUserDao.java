package nl.rondjewelzijn.api.DAL.interfaces;

import nl.rondjewelzijn.api.BLL.models.User;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface IUserDao {
    int insertUser(UUID id, User user);

    default int insertUser(User user){
        UUID id = UUID.randomUUID();
        return insertUser(id, user);
    }

    List<User> selectAllUsers();

    Optional<User> selectUsersById(UUID id);

    int deleteUserById(UUID id);

    int updateUserById(UUID id, User newUser);
}
