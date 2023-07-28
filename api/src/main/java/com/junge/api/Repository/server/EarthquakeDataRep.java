package com.junge.api.Repository.server;

import com.junge.api.Model.server.Earthquake;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EarthquakeDataRep extends JpaRepository<Earthquake, Long> {

    @Query(value = "SELECT * FROM earthquake WHERE now() - update_time < interval '30 minute';", nativeQuery = true)
    List<Earthquake> findAllOngoing();
}
