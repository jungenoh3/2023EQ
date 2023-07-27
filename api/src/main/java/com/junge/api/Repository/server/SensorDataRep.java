package com.junge.api.Repository.server;

import com.junge.api.Model.server.SensorData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SensorDataRep extends JpaRepository<SensorData, Long> {
}
