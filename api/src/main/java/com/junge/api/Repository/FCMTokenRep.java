package com.junge.api.Repository;

import com.junge.api.Model.FCMToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FCMTokenRep extends JpaRepository<FCMToken, String > {
    FCMToken getReferenceBytoken(String token);

    @Query(value = "SELECT token FROM fcmtoken WHERE now() - update_time > interval '2 minute';", nativeQuery = true)
    List<String> findAllDeprecated();

    // void deleteAllByTokenInBatch(String token);
}
