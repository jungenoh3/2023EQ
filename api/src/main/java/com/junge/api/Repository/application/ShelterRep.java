package com.junge.api.Repository.application;

import com.junge.api.Model.application.SensorInfoSpecific;
import com.junge.api.Model.application.Shelter;
import com.junge.api.Model.application.ShelterSpecific;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShelterRep extends JpaRepository<Shelter, Long> {

    @Query(value = "SELECT id, dtl_adres, xcord, ycord FROM shelter;", nativeQuery = true)
    List<ShelterSpecific> getNeed();
}
