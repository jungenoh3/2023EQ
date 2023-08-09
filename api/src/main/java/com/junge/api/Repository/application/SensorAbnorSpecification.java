package com.junge.api.Repository.application;


import com.junge.api.Model.application.SensorAbnormal;
import com.junge.api.Model.application.SensorInfo;
import jakarta.persistence.criteria.Fetch;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import org.springframework.data.jpa.domain.Specification;

public class SensorAbnorSpecification {
    public static Specification<SensorAbnormal> hasTemperatureData(){
        return (root, query, criteriaBuilder) -> {
            root.fetch("sensorInfo", JoinType.LEFT);
            return criteriaBuilder.isNull(root.get("temperature"));
        };
    }

    public static Specification<SensorAbnormal> hasAcceleratorData(){
        return (root, query, criteriaBuilder) -> {
            root.fetch("sensorInfo", JoinType.LEFT);
            return criteriaBuilder.isNull(root.get("accelerator"));
        };
    }

    public static Specification<SensorAbnormal> hasPressureData(){
        return (root, query, criteriaBuilder) -> {
            root.fetch("sensorInfo", JoinType.LEFT);
            return criteriaBuilder.isNull(root.get("pressure"));
        };
    }

    public static Specification<SensorAbnormal> equalRegion(String region){
        return (root, query, criteriaBuilder) -> {
            Fetch<SensorAbnormal, SensorInfo> sensorInfoFetch = root.fetch("sensorInfo", JoinType.LEFT);
            Join<SensorAbnormal, SensorInfo> sensorInfoJoin = (Join<SensorAbnormal, SensorInfo>) sensorInfoFetch;
            return criteriaBuilder.equal(sensorInfoJoin.get("region"), region);
        };
    }
}
