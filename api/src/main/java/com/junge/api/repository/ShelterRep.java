package com.junge.api.repository;

import com.junge.api.model.shelter.Shelter;
import com.junge.api.model.shelter.ShelterSpecific;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShelterRep extends JpaRepository<Shelter, Long> {

    @Query(value = "SELECT id, vt_acmdfclty_nm, dtl_adres, xcord, ycord FROM shelter;", nativeQuery = true)
    List<ShelterSpecific> findSpecific();
}
