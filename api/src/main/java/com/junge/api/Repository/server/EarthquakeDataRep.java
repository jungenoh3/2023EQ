package com.junge.api.Repository.server;

import com.junge.api.Model.server.Earthquake;
import com.junge.api.Model.server.EarthquakeSpecific;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EarthquakeDataRep extends JpaRepository<Earthquake, Long> {

    // 중복된 값이 있을 경우 첫번째 - begin 부터 가지고 옴
    @Query(value = "SELECT DISTINCT ON (lat, lng) id, lat, lng, update_time, assoc_id\n" +
            "FROM earthquake\n" +
            "WHERE (stage = 'BEGIN' or stage = 'ON_GOING')\n" +
            "AND NOT EXISTS (\n" +
            "    SELECT 1\n" +
            "    FROM earthquake AS t2\n" +
            "    WHERE t2.assoc_id = earthquake.assoc_id\n" +
            "    AND t2.stage = 'END'\n" +
            ");", nativeQuery = true)
    List<EarthquakeSpecific> findAllOngoing();

    @Query(value = "SELECT id, lat, lng, update_time, assoc_id from earthquake", nativeQuery = true)
    List<EarthquakeSpecific> findSpecific();

}
