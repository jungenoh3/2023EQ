package com.junge.api.controller.application;

import com.junge.api.Service.DataService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/EQMS")
public class DataController {
    private final DataService dataService;

    public DataController(DataService dataService) {
        this.dataService = dataService;
    }

    @GetMapping("/sensor-info/all")
    public ResponseEntity getAllSensor(){ return ResponseEntity.ok(this.dataService.getSensorInfoList()); }

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
    @GetMapping("/sensor-abnormal/search") // Cannot Serialize
    public ResponseEntity getSpecificSensorAbnormal(
            @RequestParam(required = false) String accerlator,
            @RequestParam(required = false) String pressure,
            @RequestParam(required = false) String temperature,
            @RequestParam(required = false) String fault_message,
            @RequestParam(required = false) String region
    ){
        return ResponseEntity.ok(this.dataService.searchSensorAbnormal(accerlator,pressure,temperature,fault_message,region));
    }
    @GetMapping("/shelter/all")
    public ResponseEntity getAllShelter(){
        return ResponseEntity.ok(this.dataService.getShelterList());
    }
    @GetMapping("/shelter/specific")
    public ResponseEntity getSpecificShelter(){ return ResponseEntity.ok(this.dataService.getShelterSpecList()); }

    @GetMapping("/earthquake/all")
    public ResponseEntity getEarthQuakeData() { return ResponseEntity.ok(this.dataService.getEarthquakeList());}
    @GetMapping("/earthquake/ongoing")
    public ResponseEntity getSpecificEarthQuakeData() { return ResponseEntity.ok(this.dataService.getEarthquakeOngoing());}

    @GetMapping("/emergency/all")
    public ResponseEntity getEmergencyInst() { return ResponseEntity.ok(this.dataService.getEmergencyInstList()); }
    @GetMapping("/emergency/specific")
    public ResponseEntity getSpecificEmergencyInst() { return ResponseEntity.ok(this.dataService.getEmergencyInstSpecList()); }

}
