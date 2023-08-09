package com.junge.api.Repository.application;

import com.junge.api.Model.application.SensorInfo;
import com.junge.api.Model.application.SensorInfoSpecific;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SensorInfoRep extends JpaRepository<SensorInfo, Long>, JpaSpecificationExecutor<SensorInfo> {
    // 동적으로 쿼리를 날리려면 nativeQuery는 꼭 체크!
    //@Query(value = "SELECT id, deviceid, latitude, longitude FROM sensor_info limit 5;", nativeQuery = true)

//    List<SensorInfoSpecific> findSpecificAll();

//    List<SensorInfo> findByDeviceidContaining(String deviceId);
//    List<SensorInfo> findByFacility(String facility);
//    List<SensorInfo> findByRegion(String region);
}
