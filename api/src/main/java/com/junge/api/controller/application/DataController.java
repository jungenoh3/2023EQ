package com.junge.api.controller.application;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.messaging.*;
import com.junge.api.Model.application.SensorInfo;
import com.junge.api.Repository.application.SensorInfoRep;
import com.junge.api.Repository.application.ShelterRep;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/EQMS")
public class DataController {
    private final SensorInfoRep sensorInfoRep;
    private final ShelterRep shelterRep;
    private final FirebaseMessaging firebaseMessaging;
    private final List<SensorInfo> sensorDataList = new ArrayList<SensorInfo>();

    public DataController(SensorInfoRep sensorInfoRep, ShelterRep shelterRep, FirebaseMessaging firebaseMessaging) {
        this.sensorInfoRep = sensorInfoRep;
        this.shelterRep = shelterRep;
        this.firebaseMessaging = firebaseMessaging;
    }

    @GetMapping("/sensor-info/all")
    public ResponseEntity getAllSensor(){
        return ResponseEntity.ok(this.sensorInfoRep.findAll());
    }

    @GetMapping("/sensor-info/specific")
    public ResponseEntity getSpecificSensor(){
        return ResponseEntity.ok(this.sensorInfoRep.getNeed());
        // return ResponseEntity.ok(this.sensorInfoRep.getReferenceById(2L));
    }

    @GetMapping("/shelter/all")
    public ResponseEntity getAllShelter(){
        return ResponseEntity.ok(this.shelterRep.findAll());
    }

    @GetMapping("/shelter/specific")
    public ResponseEntity getSpecificShelter(){
        return ResponseEntity.ok(this.shelterRep.getNeed());
    }

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
