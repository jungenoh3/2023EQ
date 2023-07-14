package com.junge.api.controller;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.junge.api.Model.SensorData;
import com.junge.api.Repository.SensorDataRep;
import com.junge.api.Repository.SensorInfoRep;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/sensor/basic-info")
public class SensorController {
    private final SensorInfoRep sensorInfoRep;
    private final SensorDataRep sensorDataRep;
    private final List<SensorData> sensorDataList = new ArrayList<SensorData>();

    public SensorController(SensorInfoRep sensorInfoRep, SensorDataRep sensorDataRep) {
        this.sensorInfoRep = sensorInfoRep;
        this.sensorDataRep = sensorDataRep;
    }
    @GetMapping("/all")
    public ResponseEntity getAllSensor(){
        return ResponseEntity.ok(this.sensorInfoRep.findAll());
    }

    @GetMapping("/test")
    public ResponseEntity getSpecific(){
        return ResponseEntity.ok(this.sensorInfoRep.getNeed());
        // return ResponseEntity.ok(this.sensorInfoRep.getReferenceById(2L));
    }

    @PostMapping("/post")
    public void PostData(@RequestBody SensorData sensorData) throws Exception {
        sensorDataList.add(sensorData);

        if (sensorData.getAcc_x() > 5) {
            FirebaseMessaging firebaseMessaging = FirebaseMessaging.getInstance();

            Message msg = Message.builder()
                    .setToken("temp")
                    .putData("body", "hello")
                    .build();

            String id = firebaseMessaging.send(msg);
        }
    }

    @GetMapping("/post")
    public List<SensorData> ReceivedData(){
        return sensorDataList;
    }


}
