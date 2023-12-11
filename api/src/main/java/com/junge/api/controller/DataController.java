package com.junge.api.controller;

import com.junge.api.service.DataService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/EQMS")
public class DataController {
    private final DataService dataService;

    public DataController(DataService dataService) {
        this.dataService = dataService;
    }

    @GetMapping("/sensor/count")
    public ResponseEntity getSensorCount() { return ResponseEntity.ok(this.dataService.getSensorCount()); }

    @GetMapping("/sensor-info/all")
    public ResponseEntity getAllSensor(){ return ResponseEntity.ok(this.dataService.getSensorInfoList()); }
    @GetMapping("/sensor-info/region")
    public ResponseEntity getAllSensorRegion() { return ResponseEntity.ok(this.dataService.getSensorInfoRegion()); }

    @GetMapping("/sensor-info/facility")
    public ResponseEntity getAllSensorFacility() { return ResponseEntity.ok(this.dataService.getSensorInfoFacility()); }

    @GetMapping("/sensor-info/search")
    public ResponseEntity getSpecificSensor(
            @RequestParam(required = false) String deviceid,
            @RequestParam(required = false) String facility,
            @RequestParam(required = false) String region
    ){
        return ResponseEntity.ok(this.dataService.searchSensorInfo(deviceid, facility, region));
    }

    @GetMapping("/sensor-abnormal/all") // N+1
    public ResponseEntity getSensorAbnormal() { return ResponseEntity.ok(this.dataService.getSensorAbnormalList()); }
    @GetMapping("/sensor-abnormal/region")
    public ResponseEntity getAllSensorAbnormalRegion() { return ResponseEntity.ok(this.dataService.getSensorAbnormalRegion()); }
    @GetMapping("/sensor-abnormal/facility")
    public ResponseEntity getAllSensorAbnormalFacility() { return ResponseEntity.ok(this.dataService.getSensorAbnormalFacility()); }
    @GetMapping("/sensor-abnormal/search") // Cannot Serialize
    public ResponseEntity getSpecificSensorAbnormal(
            @RequestParam(required = false) String sensorData,
            @RequestParam(required = false) String region
    ){
        return ResponseEntity.ok(this.dataService.searchSensorAbnormal(sensorData,region));
    }
    @GetMapping("/shelter/all")
    public ResponseEntity getAllShelter(){
        return ResponseEntity.ok(this.dataService.getShelterList());
    }

    @GetMapping("/shelter/specific")
    public ResponseEntity getSpecificShelter(){ return ResponseEntity.ok(this.dataService.getShelterSpecList()); }

    @GetMapping("/shelter/near")
    public ResponseEntity getShelterNearData(
            @RequestParam(required = true) double lat,
            @RequestParam(required = true) double lon
    ) {
        return ResponseEntity.ok(this.dataService.getNearShelter(lat, lon));
    }

    @GetMapping("/earthquake/all")
    public ResponseEntity getEarthQuakeData() { return ResponseEntity.ok(this.dataService.getEarthquakeList());}
    @GetMapping("/earthquake/ongoing")
    public ResponseEntity getSpecificEarthQuakeData() { return ResponseEntity.ok(this.dataService.getEarthquakeOngoing());}

    @GetMapping("/emergency/all")
    public ResponseEntity getEmergencyInst() { return ResponseEntity.ok(this.dataService.getEmergencyInstList()); }
    @GetMapping("/emergency/specific")
    public ResponseEntity getSpecificEmergencyInst() { return ResponseEntity.ok(this.dataService.getEmergencyInstSpecList()); }

    @GetMapping("/emergency/near")
    public ResponseEntity getEmergencyInstNearData(
            @RequestParam(required = true) double lat,
            @RequestParam(required = true) double lon
    ) {
        return ResponseEntity.ok(this.dataService.getNearEmergenyInst(lat, lon));
    }

}
