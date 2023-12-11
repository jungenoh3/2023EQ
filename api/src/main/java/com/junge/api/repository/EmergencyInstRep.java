package com.junge.api.repository;

import com.junge.api.model.emergencyinst.EmergencyInst;
import com.junge.api.model.emergencyinst.EmergencyInstSpecific;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmergencyInstRep extends JpaRepository<EmergencyInst, Long> {
    @Query(value = "SELECT id, institution, address, med_category, latitude, longitude FROM emergency_inst;", nativeQuery = true)
    List<EmergencyInstSpecific> findSpecific();
    @Query(value = "Select id, institution, address, med_category, inst_category, latitude, longitude from emergency_inst e order by earth_distance(ll_to_earth(:latitude, :longitude), ll_to_earth(e.latitude, e.longitude));", nativeQuery = true)
    List<EmergencyInstSpecific> findAround(@Param("latitude") Double latitude, @Param("longitude") Double longitude);
}

