package com.junge.api.Repository.application;

import com.junge.api.Model.application.SensorInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;


@Repository
public interface SensorInfoRep extends JpaRepository<SensorInfo, Long>, JpaSpecificationExecutor<SensorInfo> {
}
