package com.junge.api.Repository.application;

import com.junge.api.Model.application.EmergencyInst;
import com.junge.api.Model.application.EmergencyInstSpecific;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmergencyInstRep extends JpaRepository<EmergencyInst, Long> {
    @Query(value = "SELECT id, institution, address, med_category, latitude, longitude FROM emergency_inst;", nativeQuery = true)
    List<EmergencyInstSpecific> getNeed();
}
