package nl.rondjewelzijn.api.BLL.models;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.constraints.NotBlank;
import java.util.UUID;

public class User {

    private UUID id;

    @NotBlank
    private String username;

    public User(@JsonProperty("id") UUID id, @JsonProperty("username") String username) {
        this.id = id;
        this.username = username;
    }

    public UUID getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

}
