package com.junge.api.Service;

import com.junge.api.Model.application.*;
import com.junge.api.Model.server.Earthquake;
import com.junge.api.Model.server.EarthquakeProjection;
import com.junge.api.Model.server.EarthquakeSpecific;
import com.junge.api.Repository.application.*;
import com.junge.api.Repository.server.EarthquakeDataRep;
import jakarta.persistence.criteria.JoinType;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DataService {
    private final SensorInfoRep sensorInfoRep;
    private final ShelterRep shelterRep;
    private final EarthquakeDataRep earthQuakeDataRep;
    private final EmergencyInstRep emergencyInstRep;
    private final SensorAbnorRep sensorAbnorRep;

    public DataService(SensorInfoRep sensorInfoRep, ShelterRep shelterRep, EarthquakeDataRep earthQuakeDataRep, EmergencyInstRep emergencyInstRep, SensorAbnorRep sensorAbnorRep) {
        this.sensorInfoRep = sensorInfoRep;
        this.shelterRep = shelterRep;
        this.earthQuakeDataRep = earthQuakeDataRep;
        this.emergencyInstRep = emergencyInstRep;
        this.sensorAbnorRep = sensorAbnorRep;
    }

    public Map<String, Long> getSensorCount() { return this.sensorInfoRep.getSensorCount(); }
    @Cacheable(value = "sensorInfo")
    public List<SensorInfo> getSensorInfoList() { return this.sensorInfoRep.findAll(); }
    @Cacheable(value = "sensorInfoRegion")
    public List<String> getSensorInfoRegion() { return this.sensorInfoRep.findAllRegion(); }
    @Cacheable(value = "sensorInfoFacility")
    public List<String> getSensorInfoFacility() { return this.sensorInfoRep.findAllFacility(); }
    @Cacheable(value = "sensorInfoSearch", key = "'SISearch' + (#deviceid != null ? #deviceid : '') + (#facility != null ? #facility : '') + (#region != null ? #region : '')")
    public List<SensorInfo> searchSensorInfo(String deviceid, String facility, String region) {
        Specification<SensorInfo> spec = (root, query, criteriaBuilder) -> null;
        if(deviceid != null)
            spec = spec.and(SensorInfoSpecficiation.likeDeviceId(deviceid));
        if(facility != null)
            spec = spec.and(SensorInfoSpecficiation.equalFacility(facility));
        if(region != null)
            spec = spec.and(SensorInfoSpecficiation.equalRegion(region));
        return this.sensorInfoRep.findAll(spec);
    }

    @Cacheable(value = "sensorAbnormal")
    public List<SensorAbnormal> getSensorAbnormalList() { return this.sensorAbnorRep.getAbnormalWithInfo(); }
    @Cacheable(value = "sensorAbnormalRegion")
    public List<String> getSensorAbnormalRegion() { return this.sensorAbnorRep.findAllRegion(); }
    @Cacheable(value = "sensorAbnormalFacility")
    public List<String> getSensorAbnormalFacility() { return this.sensorAbnorRep.findAllFacility(); }
    @Cacheable(value = "sensorAbnormalSearch", key = "'SASearch' + (#sensorData != null ? #sensorData : '') + (#region != null ? #region : '')")
    public List<SensorAbnormalDTO> searchSensorAbnormal(String sensorData, String region){
        Specification<SensorAbnormal> spec = (root, query, criteriaBuilder) -> {
            root.fetch("sensorInfo", JoinType.LEFT);
            return criteriaBuilder.and();
        };

        if(sensorData != null){
            if(sensorData.equals("accelerator")){
                spec = spec.and(SensorAbnorSpecification.hasAcceleratorData());
            }
            else if(sensorData.equals("pressure")){
                spec = spec.and(SensorAbnorSpecification.hasPressureData());
            }
            else if(sensorData.equals("temperature")){
                spec = spec.and(SensorAbnorSpecification.hasTemperatureData());
            }
            else if(sensorData.equals("fault_message")){
                spec = spec.and(SensorAbnorSpecification.hasFaultMessageData());
            }
        }
        if(region != null)
            spec = spec.and(SensorAbnorSpecification.equalRegion(region));

        List<SensorAbnormal> sensorAbnormals = this.sensorAbnorRep.findAll(spec);
        List<SensorAbnormalDTO> sensorAbnormalDTOS = sensorAbnormals.stream()
                .map(sensorAbnormal -> new SensorAbnormalDTO(sensorAbnormal.getId(), sensorAbnormal.getSa_deviceid(), sensorAbnormal.getAccelerator(), sensorAbnormal.getPressure(), sensorAbnormal.getTemperature(), sensorAbnormal.getNoise_class(), sensorAbnormal.getFault_message(), sensorAbnormal.getSensorInfo().getAddress(), sensorAbnormal.getSensorInfo().getRegion()))
                .collect(Collectors.toList());
        return sensorAbnormalDTOS;
    }

    @Cacheable(value = "shelterAll")
    public List<Shelter> getShelterList() { return this.shelterRep.findAll(); }
    @Cacheable(value = "shelterSpecific")
    public List<ShelterProjection> getShelterSpecList() {
        List<ShelterSpecific> shelterSpecifics = this.shelterRep.findSpecific();
        List<ShelterProjection> shelterProjections = new ArrayList<ShelterProjection>();

        for (ShelterSpecific shelterSpecific : shelterSpecifics){
            shelterProjections.add(new ShelterProjection(shelterSpecific.getId(),
                    shelterSpecific.getVt_acmdfclty_nm(),
                    shelterSpecific.getDtl_adres(),
                    shelterSpecific.getXcord(),
                    shelterSpecific.getYcord()
                    ));
        }
        return shelterProjections;
    }

    @Cacheable(value = "earthquakeAll")
    public List<Earthquake> getEarthquakeList() { return this.earthQuakeDataRep.findAll(); }
    @Cacheable(value = "earthquakeOngoing")
    public List<EarthquakeProjection> getEarthquakeOngoing() {
        List<EarthquakeSpecific> earthquakeSpecifics = this.earthQuakeDataRep.findAllOngoing();
        List<EarthquakeProjection> earthquakeProjections = new ArrayList<EarthquakeProjection>();

        for (EarthquakeSpecific earthquakeSpecific : earthquakeSpecifics){
            earthquakeProjections.add(new EarthquakeProjection(earthquakeSpecific.getId(),
                    earthquakeSpecific.getLat(),
                    earthquakeSpecific.getLng(),
                    earthquakeSpecific.getUpdate_time(),
                    earthquakeSpecific.getAssoc_id()
            ));
        }
        return earthquakeProjections;
    }

    @Cacheable(value = "emergencyInstAll")
    public List<EmergencyInst> getEmergencyInstList() { return this.emergencyInstRep.findAll(); }
    @Cacheable(value = "emergencyInstSpecific")
    public List<EmerygencyInstProjection> getEmergencyInstSpecList() {
        List<EmergencyInstSpecific> emergencyInstSpecifics = this.emergencyInstRep.findSpecific();
        List<EmerygencyInstProjection> emerygencyInstProjections = new ArrayList<EmerygencyInstProjection>();

        for (EmergencyInstSpecific emergencyInstSpecific : emergencyInstSpecifics){
            emerygencyInstProjections.add(new EmerygencyInstProjection(emergencyInstSpecific.getId(),
                    emergencyInstSpecific.getInstitution(),
                    emergencyInstSpecific.getMed_category(),
                    emergencyInstSpecific.getAddress(),
                    emergencyInstSpecific.getLatitude(),
                    emergencyInstSpecific.getLongitude()
            ));
        }
        return emerygencyInstProjections;
    }

}
