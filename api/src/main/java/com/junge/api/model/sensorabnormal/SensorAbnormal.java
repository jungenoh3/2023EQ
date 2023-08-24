package com.junge.api.model.sensorabnormal;

import com.junge.api.model.SensorInfo;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SensorAbnormal implements Serializable {
    @Id
    @Column(name = "id")
    private Long id;
    @Column(insertable=false, updatable=false, name = "sa_deviceid")
    private String sa_deviceid;
    private String accelerator;
    private String pressure;
    private String temperature;
    private String noise_class;
    private String fault_message;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sa_deviceid", referencedColumnName = "deviceid")
    private SensorInfo sensorInfo;

}
