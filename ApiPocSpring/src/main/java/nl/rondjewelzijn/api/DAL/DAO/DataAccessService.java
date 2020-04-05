package nl.rondjewelzijn.api.DAL.DAO;

import nl.rondjewelzijn.api.BLL.models.User;
import nl.rondjewelzijn.api.DAL.interfaces.IUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository("postgres")
public class DataAccessService implements IUserDao {

    private final JdbcTemplate jdbcTemplate;

    @Autowired //auto dependency injection
    public DataAccessService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public int insertUser(UUID id, User user) {
        //db.add(new User(id, user.getUsername()));
        return 0;
    }

    @Override
    public List<User> selectAllUsers() {
        final String sql = "SELECT id, username FROM user_table";
        return jdbcTemplate.query(sql, (resultSet, i) -> {
            UUID id = UUID.fromString(resultSet.getString("id"));
            String username = resultSet.getString("username");
            return new User(id, username);
        });
        //return users;
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
    public int updateUserById(UUID id, User updateUser) {
        return 0;
    }

//    @Override
//    public Optional<User> selectUsersById(UUID id) {
//        return db.stream()
//                .filter(user -> user.getId().equals(id))
//                .findFirst();
//    }
//
//    @Override
//    public int deleteUserById(UUID id) {
//        Optional<User> userMaybe = selectUsersById(id);
//        if(userMaybe.isEmpty()){
//            return 0;
//        }
//        db.remove(userMaybe.get());
//        return 1;
//    }
//
//    @Override
//    public int updateUserById(UUID id, User update) {
//        return selectUsersById(id)
//                .map(user -> {
//                    int indexOfUserToUpdate = db.indexOf(user);
//                    if(indexOfUserToUpdate >= 0){
//                        db.set(indexOfUserToUpdate, new User(id, update.getUsername()));
//                        return 1;
//                    }
//                    return 0;
//                })
//                .orElse(0);
//    }
}
