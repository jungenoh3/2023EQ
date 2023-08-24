package com.junge.api.repository;

import com.junge.api.model.SensorData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SensorDataRep extends JpaRepository<SensorData, Long> {
}
