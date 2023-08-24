package com.junge.api.repository.sensorinfo;

import com.junge.api.model.SensorInfo;
import org.springframework.data.jpa.domain.Specification;

public class SensorInfoSpecficiation {
    public static Specification<SensorInfo> equalFacility(String facility){
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("facility"), facility);
    }

    public static Specification<SensorInfo> equalRegion(String region){
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("region"), region);
    }

    public static Specification<SensorInfo> likeDeviceId(String deviceid){
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get("deviceid"), "%" + deviceid + "%");
    }
}
