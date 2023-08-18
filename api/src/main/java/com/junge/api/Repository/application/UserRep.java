package com.junge.api.Repository.application;

import com.junge.api.Model.application.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRep extends JpaRepository<Users, Long> {
    Users getReferenceByidentification(String identification);
}
