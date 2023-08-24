package com.junge.api.repository;

import com.junge.api.model.emergencyinst.EmergencyInst;
import com.junge.api.model.emergencyinst.EmergencyInstSpecific;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmergencyInstRep extends JpaRepository<EmergencyInst, Long> {
    @Query(value = "SELECT id, institution, address, med_category, latitude, longitude FROM emergency_inst;", nativeQuery = true)
    List<EmergencyInstSpecific> findSpecific();
}
