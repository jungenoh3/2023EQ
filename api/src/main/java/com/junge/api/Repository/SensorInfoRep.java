package com.junge.api.Repository;

import com.junge.api.Model.SensorInfo;
import com.junge.api.Model.SpecificOnly;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SensorInfoRep extends JpaRepository<SensorInfo, Long> {
    // 동적으로 쿼리를 날리려면 nativeQuery는 꼭 체크!
    @Query(value = "SELECT id, deviceid, latitude, longitude FROM sensor_info limit 5;", nativeQuery = true)
    List<SpecificOnly> getNeed();
}
