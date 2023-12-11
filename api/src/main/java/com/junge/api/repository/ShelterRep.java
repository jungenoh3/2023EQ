package com.junge.api.repository;

import com.junge.api.model.shelter.Shelter;
import com.junge.api.model.shelter.ShelterSpecific;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShelterRep extends JpaRepository<Shelter, Long> {

    @Query(value = "SELECT id, vt_acmdfclty_nm, dtl_adres, xcord, ycord FROM shelter;", nativeQuery = true)
    List<ShelterSpecific> findSpecific();

    @Query(value = "Select id, vt_acmdfclty_nm, dtl_adres, xcord, ycord from shelter s order by earth_distance(ll_to_earth(:latitude, :longitude), ll_to_earth(s.ycord, s.xcord));", nativeQuery = true)
    List<ShelterSpecific> findAround(@Param("latitude") Double latitude, @Param("longitude") Double longitude);
}
