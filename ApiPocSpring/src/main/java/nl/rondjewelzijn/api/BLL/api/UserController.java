package nl.rondjewelzijn.api.BLL.api;

import nl.rondjewelzijn.api.BLL.models.User;
import nl.rondjewelzijn.api.BLL.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.UUID;

@RequestMapping("api/v1/user")
@RestController //expose endpoints
public class UserController {

    private UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    //Endpoints
    @PostMapping
    public void addUser(@Valid @NotNull @RequestBody User user){
        userService.addUser(user);
    }

    @GetMapping
    public List<User> getAllUsers(){
        return userService.getAllUsers();
    }

    @GetMapping(path = "{id}")
    public User getUserById(@PathVariable("id") UUID id){
        return userService.getUserById(id)
                .orElse(null);
    }

    @DeleteMapping(path = {"{id}"})
    public void deleteUserById(@PathVariable("id") UUID id){
        userService.deleteUser(id);
    }

    @PutMapping(path = "{id}")
    public void updateUser(@PathVariable("id") UUID id, @Valid @NotNull @RequestBody User userToUpdate){
        userService.updateUser(id, userToUpdate);
    }
}

