package com.junge.api.Repository.server;

import com.junge.api.Model.server.Earthquake;
import com.junge.api.Model.server.EarthquakeSpecific;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EarthquakeDataRep extends JpaRepository<Earthquake, Long> {

    @Query(value = "SELECT id, lat, lng, update_time, assoc_id FROM earthquake WHERE stage=\'BEGIN\' or stage=\'ON_GOING\'", nativeQuery = true)
    List<EarthquakeSpecific> findAllOngoing();

    @Query(value = "SELECT id, lat, lng, update_time, assoc_id from earthquake", nativeQuery = true)
    List<EarthquakeSpecific> findAllNeed();
}
