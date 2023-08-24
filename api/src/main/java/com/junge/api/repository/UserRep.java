package com.junge.api.repository;

import com.junge.api.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRep extends JpaRepository<Users, Long> {
    Users getReferenceByidentification(String identification);
}
