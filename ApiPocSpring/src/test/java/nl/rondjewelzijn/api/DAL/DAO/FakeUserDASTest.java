package nl.rondjewelzijn.api.DAL.DAO;

import nl.rondjewelzijn.api.BLL.models.User;

import java.util.List;
import java.util.UUID;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

class FakeUserDASTest {

    private FakeUserDAS fakeUserTest;

    @BeforeEach
    void setUp() {
        fakeUserTest = new FakeUserDAS();
    }

    @Test
    void selectAllUsers() {
        List<User> users = fakeUserTest.selectAllUsers();
    }

    @Test
    void selectUsersById() {
//        UUID idOne = new UUID.randomUUID();
//        User userOne = new User(idOne, "Test User");
//
//        fakeUserTest.insertUser(idOne, userOne);
//
//        assertThat(fakeUserTest.selectUsersById(idOne))
//                .isPresent();
    }
}