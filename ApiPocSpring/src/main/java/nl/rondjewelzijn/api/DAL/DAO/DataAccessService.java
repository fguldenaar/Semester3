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
        String sql = "" +
                "INSERT INTO user_table (" +
                "id" +
                "username" +
                "VALUES (?, ?)";

        return jdbcTemplate.update(sql, user.getId(), user.getUsername());
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
}
