package com.junge.api.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;
    private String identification;
    private String password;
    private String phone_number;
    private String email;

    public Users(String name, String identification, String password, String phone_number, String email) {
        this.name = name;
        this.identification = identification;
        this.password = password;
        this.phone_number = phone_number;
        this.email = email;
    }
}
