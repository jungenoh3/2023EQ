package com.junge.api.controller.application;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.messaging.*;
import com.junge.api.Model.application.SensorInfo;
import com.junge.api.Repository.application.EmergencyInstRep;
import com.junge.api.Repository.application.SensorInfoRep;
import com.junge.api.Repository.application.SensorInfoSpecficiation;
import com.junge.api.Repository.application.ShelterRep;
import com.junge.api.Repository.server.EarthquakeDataRep;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/EQMS")
public class DataController {
    private final SensorInfoRep sensorInfoRep;
    private final ShelterRep shelterRep;
    private final EarthquakeDataRep earthQuakeDataRep;
    private final EmergencyInstRep emergencyInstRep;
    private final FirebaseMessaging firebaseMessaging;
    private final List<SensorInfo> sensorDataList = new ArrayList<SensorInfo>();

    public DataController(SensorInfoRep sensorInfoRep, ShelterRep shelterRep, EarthquakeDataRep earthQuakeDataRep, EmergencyInstRep emergencyInstRep, FirebaseMessaging firebaseMessaging) {
        this.sensorInfoRep = sensorInfoRep;
        this.shelterRep = shelterRep;
        this.earthQuakeDataRep = earthQuakeDataRep;
        this.emergencyInstRep = emergencyInstRep;
        this.firebaseMessaging = firebaseMessaging;
    }

    @GetMapping("/sensor-info/all")
    public ResponseEntity getAllSensor(){ return ResponseEntity.ok(this.sensorInfoRep.findAll()); }
    @GetMapping("/sensor-info/specific")
    public ResponseEntity getSearchSensor(){ return ResponseEntity.ok(this.sensorInfoRep.getNeed()); }
    @GetMapping("/sensor-info/search")
    public ResponseEntity getSpecificSensor(
            @RequestParam(required = false) String deviceid,
            @RequestParam(required = false) String facility,
            @RequestParam(required = false) String region
    ){
        Specification<SensorInfo> spec = (root, query, criteriaBuilder) -> null;
        if(deviceid != null)
            spec = spec.and(SensorInfoSpecficiation.likeDeviceId(deviceid));
        if(facility != null)
            spec = spec.and(SensorInfoSpecficiation.equalFacility(facility));
        if(region != null)
            spec = spec.and(SensorInfoSpecficiation.equalRegion(region));

        return ResponseEntity.ok(this.sensorInfoRep.findAll(spec));
    }

    @GetMapping("/shelter/all")
    public ResponseEntity getAllShelter(){
        return ResponseEntity.ok(this.shelterRep.findAll());
    }
    @GetMapping("/shelter/specific")
    public ResponseEntity getSpecificShelter(){
        return ResponseEntity.ok(this.shelterRep.getNeed());
    }

    @GetMapping("/earthquake/all")
    public ResponseEntity getEarthQuakeData() { return ResponseEntity.ok(this.earthQuakeDataRep.findAll());}
    @GetMapping("/earthquake/specific")
    public ResponseEntity getSpecificEarthQuakeData() { return ResponseEntity.ok(this.earthQuakeDataRep.findAllOngoing());}

    @GetMapping("/emergency/all")
    public ResponseEntity getEmergencyInst() { return ResponseEntity.ok(this.emergencyInstRep.findAll()); }
    @GetMapping("/emergency/specific")
    public ResponseEntity getSpecificEmergencyInst() { return ResponseEntity.ok(this.emergencyInstRep.getNeed()); }

    @PostMapping("/post")
    public void PostData(@RequestBody SensorInfo sensorInfo) throws Exception {
        sensorDataList.add(sensorInfo);
    }

    @GetMapping("/post")
    public List<SensorInfo> ReceivedData(){
        return sensorDataList;
    }

    @PostMapping("/Real-time-test")
    public void RealTimeDataBase(@RequestBody String data) {
        final FirebaseDatabase firebaseDatabase = FirebaseDatabase.getInstance();
        DatabaseReference reference = firebaseDatabase.getReference("server/saving-data/fireblog");
        reference.setValueAsync(data);
    }

}
