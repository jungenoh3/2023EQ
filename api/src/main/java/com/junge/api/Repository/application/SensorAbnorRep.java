package com.junge.api.Repository.application;

import com.junge.api.Model.application.SensorAbnormal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SensorAbnorRep extends JpaRepository<SensorAbnormal, Long>, JpaSpecificationExecutor<SensorAbnormal> {

    @Query("select sa from SensorAbnormal sa join fetch sa.sensorInfo")
    List<SensorAbnormal> getAbnormalWithInfo();

}
