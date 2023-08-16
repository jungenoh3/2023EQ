package com.junge.api.Repository.application;

import com.junge.api.Model.application.SensorInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface SensorInfoRep extends JpaRepository<SensorInfo, Long>, JpaSpecificationExecutor<SensorInfo> {
    @Query(value = "select distinct si.region from SensorInfo si where si.region is not null")
    List<String> findAllRegion();

    @Query(value = "select distinct si.facility from SensorInfo si where si.facility is not null")
    List<String> findAllFacility();
}
