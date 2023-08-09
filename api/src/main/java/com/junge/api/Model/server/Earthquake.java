package com.junge.api.Model.server;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Array;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Earthquake {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private double lat;
    private double lng;
    private Timestamp event_occurred_msec;
    private Timestamp alert_created_msec;
    private Timestamp update_time;
    private List<String> associated_sensors;
    private String stage;
    private Long assoc_id;

}
